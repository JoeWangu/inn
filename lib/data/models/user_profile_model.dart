import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inn/data/models/house_model.dart'; // For Country, StateData, etc.

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  @JsonSerializable(explicitToJson: true)
  const factory UserProfileModel({
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? dob, // YYYY-MM-DD
    String? gender, // 'M', 'F', 'O'
    String? address,
    @JsonKey(name: 'profile_picture') String? profilePicture,
    String? bio,

    // Location Fields (IDs from backend)
    @JsonKey(name: 'country') int? countryId,
    @JsonKey(name: 'state') int? stateId,
    @JsonKey(name: 'city') int? cityId,
    @JsonKey(name: 'neighborhood') int? neighborhoodId,

    // Location Objects (Details from backend)
    @JsonKey(name: 'countryDetails') Country? country,
    @JsonKey(name: 'stateDetails') StateData? state,
    @JsonKey(name: 'cityDetails') City? city,
    @JsonKey(name: 'neighborhoodDetails') Neighborhood? neighborhood,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
