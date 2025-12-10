import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inn/data/models/user_model.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required UserModel user,
    required String token,
    required String refresh,
    required bool created,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => 
      _$LoginResponseFromJson(json);
}