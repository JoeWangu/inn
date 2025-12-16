import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/security_controller.dart';
import 'package:inn/core/storage/secure_storage_provider.dart';
import 'package:inn/core/security/local_auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

@GenerateNiceMocks([
  MockSpec<FlutterSecureStorage>(),
  MockSpec<LocalAuthentication>(),
])
import 'security_controller_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockFlutterSecureStorage mockStorage;
  late MockLocalAuthentication mockAuth;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    mockAuth = MockLocalAuthentication();
    container = ProviderContainer(
      overrides: [
        secureStorageProvider.overrideWithValue(mockStorage),
        localAuthProvider.overrideWithValue(mockAuth),
      ],
    );
  });

  test('Initial state should verify support and load settings', () async {
    when(mockAuth.isDeviceSupported()).thenAnswer((_) async => true);
    when(mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(
      mockStorage.read(key: 'security_pin_enabled'),
    ).thenAnswer((_) async => 'false');

    // Read the controller to trigger build
    final state = await container.read(securityControllerProvider.future);

    expect(state.isSupported, true);
    expect(state.isPinEnabled, false);
  });

  test('setPin should enable PIN and save to storage', () async {
    when(mockAuth.isDeviceSupported()).thenAnswer((_) async => false);

    final controller = container.read(securityControllerProvider.notifier);
    // Wait for build
    await container.read(securityControllerProvider.future);

    await controller.setPin('1234');

    verify(mockStorage.write(key: 'security_pin', value: '1234')).called(1);
    verify(
      mockStorage.write(key: 'security_pin_enabled', value: 'true'),
    ).called(1);

    final state = container.read(securityControllerProvider).value;
    expect(state!.isPinEnabled, true);
  });

  test('verifyPin should return true for correct PIN', () async {
    when(mockStorage.read(key: 'security_pin')).thenAnswer((_) async => '1234');

    final controller = container.read(securityControllerProvider.notifier);
    await container.read(securityControllerProvider.future);

    final result = await controller.verifyPin('1234');
    expect(result, true);

    final state = container.read(securityControllerProvider).value;
    expect(state!.failedAttempts, 0);
  });

  test('verifyPin should increment failedAttempts for incorrect PIN', () async {
    when(mockStorage.read(key: 'security_pin')).thenAnswer((_) async => '1234');

    final controller = container.read(securityControllerProvider.notifier);
    await container.read(securityControllerProvider.future);

    final result = await controller.verifyPin('0000');
    expect(result, false);

    final state = container.read(securityControllerProvider).value;
    expect(state!.failedAttempts, 1);
  });

  test('verifyPin should lockout after 3 attempts', () async {
    when(mockStorage.read(key: 'security_pin')).thenAnswer((_) async => '1234');

    final controller = container.read(securityControllerProvider.notifier);
    await container.read(securityControllerProvider.future);

    await controller.verifyPin('0000');
    await controller.verifyPin('0000');
    await controller.verifyPin('0000');

    final state = container.read(securityControllerProvider).value;
    expect(state!.failedAttempts, 3);
    expect(state.lockoutEndTime, isNotNull);
  });
  test(
    'authenticateBiometrics should call auth with correct params and unlock on success',
    () async {
      when(
        mockAuth.authenticate(
          localizedReason: anyNamed('localizedReason'),
          biometricOnly: anyNamed('biometricOnly'),
          persistAcrossBackgrounding: anyNamed('persistAcrossBackgrounding'),
        ),
      ).thenAnswer((_) async => true);

      final controller = container.read(securityControllerProvider.notifier);
      await container.read(securityControllerProvider.future);

      // Simulate locked state
      controller.lockApp();

      final result = await controller.authenticateBiometrics();

      expect(result, true);
      verify(
        mockAuth.authenticate(
          localizedReason: 'Authenticate to unlock the app',
          biometricOnly: true,
          persistAcrossBackgrounding: false,
        ),
      ).called(1);

      final state = container.read(securityControllerProvider).value;
      expect(state!.isLocked, false);
      expect(state.failedAttempts, 0);
    },
  );
}
