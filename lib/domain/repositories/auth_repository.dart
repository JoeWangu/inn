import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inn/data/models/auth_models/login_request.dart';
import 'package:inn/data/models/auth_models/login_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/storage/secure_storage_provider.dart';
import 'package:inn/data/models/auth_models/signup_response.dart';
import 'package:inn/data/models/auth_models/sign_up_request.dart';
import 'package:inn/data/datasources/remote/auth_api.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final api = ref.read(authApiProvider);
  final storage = ref.read(secureStorageProvider);

  return AuthRepository(api: api, storage: storage);
}

class AuthRepository {
  final AuthApi _api;
  final FlutterSecureStorage _storage;

  AuthRepository({required AuthApi api, required FlutterSecureStorage storage})
    : _api = api,
      _storage = storage;

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
    return response;
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _api.login(request);
    await _storage.write(key: 'access_token', value: response.token);
    return response;
  }
}
