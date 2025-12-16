import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import "package:flutter/services.dart";
import 'package:inn/core/storage/secure_storage_provider.dart';

import 'package:inn/core/security/local_auth_provider.dart';

part 'security_controller.g.dart';

enum AutoLockTimeout {
  immediate(Duration.zero, 'Immediately'),
  oneMinute(Duration(minutes: 1), '1 Minute'),
  fiveMinutes(Duration(minutes: 5), '5 Minutes'),
  thirtyMinutes(Duration(minutes: 30), '30 Minutes');

  final Duration duration;
  final String label;
  const AutoLockTimeout(this.duration, this.label);
}

class SecurityState {
  final bool isPinEnabled;
  final bool isBiometricsEnabled;
  final bool isLocked; // Is the lock screen currently showing?
  final AutoLockTimeout autoLockTimeout;
  final int failedAttempts;
  final DateTime? lockoutEndTime;
  final bool isSupported; // Device supports local auth

  const SecurityState({
    this.isPinEnabled = false,
    this.isBiometricsEnabled = false,
    this.isLocked = false,
    this.autoLockTimeout = AutoLockTimeout.immediate,
    this.failedAttempts = 0,
    this.lockoutEndTime,
    this.isSupported = false,
  });

  SecurityState copyWith({
    bool? isPinEnabled,
    bool? isBiometricsEnabled,
    bool? isLocked,
    AutoLockTimeout? autoLockTimeout,
    int? failedAttempts,
    DateTime? lockoutEndTime,
    bool? isSupported,
  }) {
    return SecurityState(
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      isBiometricsEnabled: isBiometricsEnabled ?? this.isBiometricsEnabled,
      isLocked: isLocked ?? this.isLocked,
      autoLockTimeout: autoLockTimeout ?? this.autoLockTimeout,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      lockoutEndTime: lockoutEndTime ?? this.lockoutEndTime,
      isSupported: isSupported ?? this.isSupported,
    );
  }
}

@Riverpod(keepAlive: true)
class SecurityController extends _$SecurityController {
  late final LocalAuthentication _auth;
  late final FlutterSecureStorage _storage;
  DateTime? _lastActiveTime;

  static const _pinKey = 'security_pin';
  static const _pinEnabledKey = 'security_pin_enabled';
  static const _biometricsEnabledKey = 'security_biometrics_enabled';
  static const _timeoutKey = 'security_auto_lock_timeout';

  // ...

  @override
  Future<SecurityState> build() async {
    _auth = ref.watch(localAuthProvider);
    _storage = ref.watch(secureStorageProvider);

    final isSupported = await _checkSupport();
    final pinEnabled = (await _storage.read(key: _pinEnabledKey)) == 'true';
    final bioEnabled =
        (await _storage.read(key: _biometricsEnabledKey)) == 'true';
    final timeoutIndexStr = await _storage.read(key: _timeoutKey);
    final timeout = timeoutIndexStr != null
        ? AutoLockTimeout.values[int.parse(timeoutIndexStr)]
        : AutoLockTimeout.immediate;

    // On app launch, if PIN is enabled, start locked
    final shouldLock = pinEnabled;

    return SecurityState(
      isSupported: isSupported,
      isPinEnabled: pinEnabled,
      isBiometricsEnabled: bioEnabled,
      autoLockTimeout: timeout,
      isLocked: shouldLock,
    );
  }

  Future<bool> _checkSupport() async {
    try {
      final isDeviceSupported = await _auth.isDeviceSupported();
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      return isDeviceSupported || canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
    await _storage.write(key: _pinEnabledKey, value: 'true');
    state = const AsyncValue.data(
      SecurityState(),
    ).whenData((s) => s.copyWith(isPinEnabled: true));
    // Explicitly update current state to ensure UI reflects it
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.copyWith(isPinEnabled: true));
    }
  }

  Future<void> disablePin() async {
    await _storage.delete(key: _pinKey);
    await _storage.write(key: _pinEnabledKey, value: 'false');
    await _storage.write(key: _biometricsEnabledKey, value: 'false');
    if (state.hasValue) {
      state = AsyncValue.data(
        state.value!.copyWith(isPinEnabled: false, isBiometricsEnabled: false),
      );
    }
  }

  Future<bool> verifyPin(String pin) async {
    final currentState = state.value;
    if (currentState == null) return false;

    // Check lockout
    if (currentState.lockoutEndTime != null) {
      if (DateTime.now().isBefore(currentState.lockoutEndTime!)) {
        throw Exception('Locked out');
      } else {
        // Lockout expired
        state = AsyncValue.data(
          currentState.copyWith(lockoutEndTime: null, failedAttempts: 0),
        );
      }
    }

    final storedPin = await _storage.read(key: _pinKey);
    if (storedPin == pin) {
      // Success
      state = AsyncValue.data(
        currentState.copyWith(
          failedAttempts: 0,
          isLocked: false,
          lockoutEndTime: null, // Ensure cleared
        ),
      );
      _updateLastActiveTime();
      return true;
    } else {
      // Failure
      final newAttempts = currentState.failedAttempts + 1;
      DateTime? newLockoutTime;

      if (newAttempts >= 3) {
        newLockoutTime = DateTime.now().add(const Duration(minutes: 10));
      }

      state = AsyncValue.data(
        currentState.copyWith(
          failedAttempts: newAttempts,
          lockoutEndTime: newLockoutTime,
        ),
      );
      return false;
    }
  }

  Future<void> toggleBiometrics(bool enable) async {
    await _storage.write(key: _biometricsEnabledKey, value: enable.toString());
    if (state.hasValue) {
      state = AsyncValue.data(
        state.value!.copyWith(isBiometricsEnabled: enable),
      );
    }
  }

  Future<void> setAutoLockTimeout(AutoLockTimeout timeout) async {
    await _storage.write(key: _timeoutKey, value: timeout.index.toString());
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.copyWith(autoLockTimeout: timeout));
    }
  }

  bool _isAuthenticating = false;

  Future<bool> authenticateBiometrics() async {
    final currentState = state.value;

    // Strict lockout: disable biometrics if locked out
    if (currentState?.lockoutEndTime != null) {
      if (DateTime.now().isBefore(currentState!.lockoutEndTime!)) {
        return false;
      }
    }

    _isAuthenticating = true;
    try {
      print('Starting biometric authentication...');
      final bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to unlock the app',
        biometricOnly: true, // Only allow biometrics, no fallback to PIN
        persistAcrossBackgrounding: true, // Don't persist across backgrounding
      );
      print('Biometric authentication result: $authenticated');

      if (authenticated) {
        state = AsyncValue.data(
          currentState!.copyWith(isLocked: false, failedAttempts: 0),
        );
        _updateLastActiveTime();
        return true;
      } else {
        // User cancelled or failed - don't retry automatically
        print('Biometric authentication failed or was cancelled');
        return false;
      }
    } on LocalAuthException catch (e) {
      // Handle LocalAuthException (e.g., userCanceled, notAvailable) and others
      print('Biometric authentication error: $e');
      if (e.code == LocalAuthExceptionCode.noBiometricHardware ||
          e.code == LocalAuthExceptionCode.noBiometricsEnrolled) {
        // Biometrics not available/enrolled, disable it so we don't loop
        await toggleBiometrics(false);
      }
      return false;
    } on PlatformException catch (e) {
      print('Biometric authentication platform error: $e');
      return false;
    } finally {
      // In Riverpod Controller, we don't have 'mounted' but the object lifecycle is managed by the provider.
      // We accept that if it's disposed, this assignment might be ignored or harmless.
      _isAuthenticating = false;
    }
  }

  void lockApp() {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.copyWith(isLocked: true));
    }
  }

  void unlockApp() {
    if (state.hasValue) {
      state = AsyncValue.data(state.value!.copyWith(isLocked: false));
    }
  }

  void _updateLastActiveTime() {
    _lastActiveTime = DateTime.now();
  }

  void checkAutoLock() {
    // Prevent auto-lock if we are currently authenticating (e.g. biometric dialog is open)
    if (_isAuthenticating) return;

    final currentState = state.value;
    if (currentState == null || !currentState.isPinEnabled) return;

    // If already locked, do nothing
    if (currentState.isLocked) return;

    if (_lastActiveTime != null) {
      final difference = DateTime.now().difference(_lastActiveTime!);
      if (difference >= currentState.autoLockTimeout.duration) {
        lockApp();
      }
    }
  }

  // Call this when user interacts with the app
  void reportActivity() {
    _updateLastActiveTime();
  }
}
