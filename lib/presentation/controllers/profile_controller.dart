import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/data/models/user_profile_model.dart';
import 'package:inn/domain/repositories/auth_repository.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserProfileModel?> build() async {
    return _fetchProfile(forceRefresh: false);
  }

  Future<UserProfileModel?> _fetchProfile({bool forceRefresh = false}) async {
    try {
      final repo = ref.read(authRepositoryProvider);
      return await repo.getUserProfile(forceRefresh: forceRefresh);
    } catch (e) {
      // print("ProfileController Error: $e");
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => _fetchProfile(forceRefresh: true),
    );
  }

  Future<bool> createProfile({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? dob,
    String? gender,
    String? address,
    String? bio,
    int? country,
    int? stateId,
    int? city,
    int? neighborhood,
    File? profilePicture,
  }) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      return await repo.createUserProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dob: dob,
        gender: gender,
        address: address,
        bio: bio,
        country: country,
        state: stateId,
        city: city,
        neighborhood: neighborhood,
        profilePicture: profilePicture,
      );
    });

    if (ref.mounted) {
      state = newState;
    }

    return !state.hasError;
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? address,
    String? bio,
    int? country,
    int? stateId,
    int? city,
    int? neighborhood,
    File? profilePicture,
  }) async {
    final currentUser = state.value;
    if (currentUser == null) return false;

    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      return await repo.updateUserProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dob: dob,
        gender: gender,
        address: address,
        bio: bio,
        country: country,
        state: stateId,
        city: city,
        neighborhood: neighborhood,
        profilePicture: profilePicture,
      );
    });

    if (ref.mounted) {
      state = newState;
    }

    return !state.hasError;
  }
}
