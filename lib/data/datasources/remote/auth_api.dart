import 'package:dio/dio.dart' hide Headers;
import 'package:inn/core/constants.dart';
import 'package:inn/data/models/auth_models/login_request.dart';
import 'package:inn/data/models/auth_models/login_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/core/network/dio_provider.dart';
import 'package:inn/data/models/auth_models/sign_up_request.dart';
import 'package:inn/data/models/auth_models/signup_response.dart';
import 'package:inn/data/models/user_profile_model.dart';
import 'dart:io';

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
  @Headers({'requiresToken': 'false'})
  Future<SignupResponse> signUp(@Body() SignUpRequest request);

  // log in the user
  @POST(Constants.loginUsersEndpoint)
  @Headers({'requiresToken': 'false'})
  Future<LoginResponse> login(@Body() LoginRequest request);

  // --- User Profile ---

  @GET(Constants.userProfileEndpoint)
  Future<UserProfileModel> getUserProfile();

  @POST(Constants.userProfileEndpoint)
  @MultiPart()
  Future<UserProfileModel> createUserProfile({
    @Part(name: "first_name") String? firstName,
    @Part(name: "last_name") String? lastName,
    @Part(name: "phone_number") String? phoneNumber,
    @Part(name: "dob") String? dob,
    @Part(name: "gender") String? gender,
    @Part(name: "address") String? address,
    @Part(name: "bio") String? bio,
    @Part(name: "country") int? country,
    @Part(name: "state") int? state,
    @Part(name: "city") int? city,
    @Part(name: "neighborhood") int? neighborhood,
    @Part(name: "profile_picture") File? profilePicture,
  });

  @PATCH(Constants.userProfileEndpoint)
  @MultiPart()
  Future<UserProfileModel> updateUserProfile({
    @Part(name: "first_name") String? firstName,
    @Part(name: "last_name") String? lastName,
    @Part(name: "phone_number") String? phoneNumber,
    @Part(name: "dob") String? dob,
    @Part(name: "gender") String? gender,
    @Part(name: "address") String? address,
    @Part(name: "bio") String? bio,
    @Part(name: "country") int? country,
    @Part(name: "state") int? state,
    @Part(name: "city") int? city,
    @Part(name: "neighborhood") int? neighborhood,
    @Part(name: "profile_picture") File? profilePicture,
  });
}
