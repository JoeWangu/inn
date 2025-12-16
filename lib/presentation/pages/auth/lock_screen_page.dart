import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/security_controller.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class LockScreenPage extends ConsumerStatefulWidget {
  const LockScreenPage({super.key});

  @override
  ConsumerState<LockScreenPage> createState() => _LockScreenPageState();
}

class _LockScreenPageState extends ConsumerState<LockScreenPage> {
  String _pin = '';
  String _error = '';
  Timer? _timer;
  Duration _lockoutRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _checkLockout();
    // Try biometrics immediately if enabled and not locked out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryBiometrics();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _checkLockout() {
    final state = ref.read(securityControllerProvider).value;
    if (state?.lockoutEndTime != null) {
      _startLockoutTimer(state!.lockoutEndTime!);
    }
  }

  void _startLockoutTimer(DateTime endTime) {
    _timer?.cancel();
    final now = DateTime.now();
    if (endTime.isAfter(now)) {
      setState(() {
        _lockoutRemaining = endTime.difference(now);
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          final remaining = endTime.difference(DateTime.now());
          if (remaining.isNegative) {
            _lockoutRemaining = Duration.zero;
            timer.cancel();
            ref.invalidate(
              securityControllerProvider,
            ); // Refresh to clear lockout state
          } else {
            _lockoutRemaining = remaining;
          }
        });
      });
    }
  }

  bool _isAuthenticating = false;

  Future<void> _tryBiometrics() async {
    if (_isAuthenticating) return;

    final state = ref.read(securityControllerProvider).value;
    if (state == null) return;

    if (state.isBiometricsEnabled && _lockoutRemaining == Duration.zero) {
      setState(() => _isAuthenticating = true);
      try {
        print('LockScreen: Triggering biometrics...');
        final success = await ref
            .read(securityControllerProvider.notifier)
            .authenticateBiometrics();
        if (success) {
          print('LockScreen: Biometrics success, unlocking...');
          _unlock();
        } else {
          print('LockScreen: Biometrics failed or canceled.');
        }
      } finally {
        if (mounted) {
          setState(() => _isAuthenticating = false);
        }
      }
    }
  }

  void _onNumberTap(String number) {
    if (_lockoutRemaining > Duration.zero) return;

    setState(() {
      _error = '';
      if (_pin.length < 4) {
        _pin += number;
        if (_pin.length == 4) {
          _verifyPin();
        }
      }
    });
  }

  void _onBackspace() {
    if (_lockoutRemaining > Duration.zero) return;
    setState(() {
      _error = '';
      if (_pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  Future<void> _verifyPin() async {
    try {
      final success = await ref
          .read(securityControllerProvider.notifier)
          .verifyPin(_pin);
      if (success) {
        _unlock();
      } else {
        setState(() {
          _pin = '';
          _error = 'Incorrect PIN';
        });

        // Check if we just got locked out
        final state = ref.read(securityControllerProvider).value;
        if (state?.lockoutEndTime != null) {
          _startLockoutTimer(state!.lockoutEndTime!);
        }
      }
    } catch (e) {
      if (e.toString().contains('Locked out')) {
        final state = ref.read(securityControllerProvider).value;
        if (state?.lockoutEndTime != null) {
          _startLockoutTimer(state!.lockoutEndTime!);
        }
      } else {
        setState(() {
          _error = 'Error verifying PIN';
        });
      }
    }
  }

  void _unlock() {
    if (mounted) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/'); // Fallback
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLockedOut = _lockoutRemaining > Duration.zero;

    return PopScope(
      canPop: false, // Prevent back button
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.lock_outline, size: 64, color: Colors.blueGrey),
              const SizedBox(height: 20),
              Text(
                isLockedOut ? 'App Locked' : 'Enter PIN',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              if (isLockedOut)
                Text(
                  'Try again in ${_formatDuration(_lockoutRemaining)}',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                )
              else
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < _pin.length
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                        ),
                      );
                    }),
                  ),
                ),
              if (_error.isNotEmpty && !isLockedOut)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const Spacer(),
              _buildKeypad(isLockedOut),
              const SizedBox(height: 20),
              // Biometric Button
              if (!isLockedOut &&
                  (ref
                          .watch(securityControllerProvider)
                          .value
                          ?.isBiometricsEnabled ??
                      false))
                TextButton.icon(
                  onPressed: _tryBiometrics,
                  icon: const Icon(Icons.fingerprint, size: 32),
                  label: const Text('Use Biometrics'),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(d.inMinutes.remainder(60));
    String seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Widget _buildKeypad(bool disabled) {
    return Column(
      children: [
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var j = 1; j <= 3; j++)
                  _buildKey('${i * 3 + j}', disabled),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 60),
              _buildKey('0', disabled),
              SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                  onPressed: disabled ? null : _onBackspace,
                  icon: const Icon(Icons.backspace_outlined),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKey(String number, bool disabled) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextButton(
        onPressed: disabled ? null : () => _onNumberTap(number),
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.grey.shade100,
        ),
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
