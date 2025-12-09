import 'package:dio/dio.dart';
import 'package:inn/core/constants.dart';
import 'package:inn/data/models/auth_models/login_request.dart';
import 'package:inn/data/models/auth_models/login_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/core/network/dio_provider.dart';
import 'package:inn/data/models/auth_models/sign_up_request.dart';
import 'package:inn/data/models/auth_models/signup_response.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(Ref ref) {
  final dio = ref.read(dioProvider);
  return AuthApi(dio);
}

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;
  // create the user
  @POST(Constants.createUsersEndpoint)
  Future<SignupResponse> signUp(@Body() SignUpRequest request);
  // log in the user
  @POST(Constants.loginUsersEndpoint)
  Future<LoginResponse> login(@Body() LoginRequest request);
}
