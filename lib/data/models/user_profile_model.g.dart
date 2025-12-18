// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      profilePicture: json['profile_picture'] as String?,
      bio: json['bio'] as String?,
      username: json['username'] as String?,
      countryId: (json['country'] as num?)?.toInt(),
      stateId: (json['state'] as num?)?.toInt(),
      cityId: (json['city'] as num?)?.toInt(),
      neighborhoodId: (json['neighborhood'] as num?)?.toInt(),
      country: json['countryDetails'] == null
          ? null
          : Country.fromJson(json['countryDetails'] as Map<String, dynamic>),
      state: json['stateDetails'] == null
          ? null
          : StateData.fromJson(json['stateDetails'] as Map<String, dynamic>),
      city: json['cityDetails'] == null
          ? null
          : City.fromJson(json['cityDetails'] as Map<String, dynamic>),
      neighborhood: json['neighborhoodDetails'] == null
          ? null
          : Neighborhood.fromJson(
              json['neighborhoodDetails'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'dob': instance.dob,
      'gender': instance.gender,
      'address': instance.address,
      'profile_picture': instance.profilePicture,
      'bio': instance.bio,
      'username': instance.username,
      'country': instance.countryId,
      'state': instance.stateId,
      'city': instance.cityId,
      'neighborhood': instance.neighborhoodId,
      'countryDetails': instance.country?.toJson(),
      'stateDetails': instance.state?.toJson(),
      'cityDetails': instance.city?.toJson(),
      'neighborhoodDetails': instance.neighborhood?.toJson(),
    };
