import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inn/data/models/auth_models/login_request.dart';
import 'package:inn/data/models/auth_models/login_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/storage/secure_storage_provider.dart';
import 'package:inn/data/models/auth_models/signup_response.dart';
import 'package:inn/data/models/auth_models/sign_up_request.dart';
import 'package:inn/data/datasources/remote/auth_api.dart';
import 'package:inn/data/models/user_profile_model.dart';
import 'dart:io';

import 'package:inn/core/database/app_database.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final api = ref.read(authApiProvider);
  final storage = ref.read(secureStorageProvider);
  final db = ref.read(appDatabaseProvider);

  return AuthRepository(api: api, storage: storage, db: db);
}

class AuthRepository {
  final AuthApi _api;
  final FlutterSecureStorage _storage;
  final AppDatabase _db;

  AuthRepository({
    required AuthApi api,
    required FlutterSecureStorage storage,
    required AppDatabase db,
  }) : _api = api,
       _storage = storage,
       _db = db;

  Future<SignupResponse> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final request = SignUpRequest(
      username: username,
      email: email,
      password: password,
    );
    final response = await _api.signUp(request);
    await _storage.write(key: 'access_token', value: response.token);
    await _storage.write(key: 'refresh_token', value: response.refresh);
    return response;
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _api.login(request);
    await _storage.write(key: 'access_token', value: response.token);
    await _storage.write(key: 'refresh_token', value: response.refresh);
    return response;
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<UserProfileModel?> getUserProfile({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      try {
        final local = await _db.getUserProfile();
        if (local != null) return local;
      } catch (e) {
        // print("Local DB Error: $e");
      }
    }

    try {
      final remote = await _api.getUserProfile();
      try {
        await _db.insertUserProfile(remote);
      } catch (dbError) {
        // print("DB Insert Error: $dbError");
      }
      return remote;
    } catch (e) {
      if (forceRefresh) rethrow;
      try {
        return await _db.getUserProfile();
      } catch (_) {
        throw e;
      }
    }
  }

  Future<UserProfileModel> createUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? address,
    String? bio,
    int? country,
    int? state,
    int? city,
    int? neighborhood,
    File? profilePicture,
  }) async {
    final response = await _api.createUserProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      dob: dob,
      gender: gender,
      address: address,
      bio: bio,
      country: country,
      state: state,
      city: city,
      neighborhood: neighborhood,
      profilePicture: profilePicture,
    );
    await _db.insertUserProfile(response);
    return response;
  }

  Future<UserProfileModel> updateUserProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? address,
    String? bio,
    int? country,
    int? state,
    int? city,
    int? neighborhood,
    File? profilePicture,
  }) async {
    final response = await _api.updateUserProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      dob: dob,
      gender: gender,
      address: address,
      bio: bio,
      country: country,
      state: state,
      city: city,
      neighborhood: neighborhood,
      profilePicture: profilePicture,
    );
    await _db.insertUserProfile(response);
    return response;
  }
}
