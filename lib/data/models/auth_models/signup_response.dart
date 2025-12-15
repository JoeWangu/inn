import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inn/data/models/user_model.dart';

part 'signup_response.freezed.dart';
part 'signup_response.g.dart';

@freezed
abstract class SignupResponse with _$SignupResponse {
  const factory SignupResponse({
    required UserModel user,
    required String token,
    required String refresh,
    required String? message,
  }) = _SignupResponse;

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
