// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    _SignupResponse(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      refresh: json['refresh'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SignupResponseToJson(_SignupResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'refresh': instance.refresh,
      'message': instance.message,
    };
