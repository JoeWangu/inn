import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/profile_controller.dart';
import 'package:inn/domain/repositories/auth_repository.dart';
import 'package:inn/data/models/user_profile_model.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockAuthRepository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  final tProfile = UserProfileModel(firstName: 'John', lastName: 'Doe');

  test('initial state is AsyncData with profile from repo', () async {
    when(
      mockAuthRepository.getUserProfile(forceRefresh: false),
    ).thenAnswer((_) async => tProfile);

    final container = makeContainer();

    // Verify initial state loading
    // We expect AsyncLoading then AsyncData

    // Read the provider to trigger build
    container.listen(profileControllerProvider, (previous, next) {});

    // Wait for the future to complete
    await container.read(profileControllerProvider.future);

    expect(container.read(profileControllerProvider).value, tProfile);
    verify(mockAuthRepository.getUserProfile(forceRefresh: false)).called(1);
  });

  test('refresh calls repo with forceRefresh: true', () async {
    when(
      mockAuthRepository.getUserProfile(forceRefresh: false),
    ).thenAnswer((_) async => tProfile);
    when(
      mockAuthRepository.getUserProfile(forceRefresh: true),
    ).thenAnswer((_) async => tProfile);

    final container = makeContainer();

    // Trigger build
    await container.read(profileControllerProvider.future);

    // Now call refresh
    await container.read(profileControllerProvider.notifier).refresh();

    verify(mockAuthRepository.getUserProfile(forceRefresh: true)).called(1);
  });

  test('createProfile calls repo and updates state', () async {
    when(
      mockAuthRepository.getUserProfile(forceRefresh: false),
    ).thenAnswer((_) async => null); // Start with no profile
    when(
      mockAuthRepository.createUserProfile(
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '123',
      ),
    ).thenAnswer((_) async => tProfile);

    final container = makeContainer();
    await container.read(profileControllerProvider.future);

    final success = await container
        .read(profileControllerProvider.notifier)
        .createProfile(firstName: 'John', lastName: 'Doe', phoneNumber: '123');

    expect(success, true);
    expect(container.read(profileControllerProvider).value, tProfile);
    verify(
      mockAuthRepository.createUserProfile(
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '123',
      ),
    ).called(1);
  });
}
