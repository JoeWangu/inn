import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_model.freezed.dart';
part 'house_model.g.dart';

@freezed
abstract class HouseModel with _$HouseModel {
  @JsonSerializable(explicitToJson: true)
  const factory HouseModel({
    required int id,
    int? image,
    required double price,
    @JsonKey(name: 'total_units') required int totalUnits,
    String? title,
    String? description,
    String? category,

    @JsonKey(name: 'date_posted') required DateTime datePosted,
    @JsonKey(name: 'date_modified') required DateTime dateModified,

    @JsonKey(name: 'time_posted') String? timePosted,
    @JsonKey(name: 'time_modified') String? timeModified,

    required bool available,
    @JsonKey(name: 'is_active') required bool isActive,

    @JsonKey(name: 'author_detail') required AuthorDetail authorDetail,
    @JsonKey(name: 'image_detail') ImageDetail? imageDetail,

    @JsonKey(name: 'avg_rating') required num avgRating,
    Country? country,
    StateData? state,
    City? city,
    Neighborhood? neighborhood,

    String? author,
  }) = _HouseModel;

  factory HouseModel.fromJson(Map<String, dynamic> json) =>
      _$HouseModelFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class AuthorDetail with _$AuthorDetail {
  const factory AuthorDetail({
    required int id,
    String? username,
    String? email,
    @JsonKey(name: 'user_profile') UserProfile? userProfile,
  }) = _AuthorDetail;

  factory AuthorDetail.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    @JsonKey(name: 'phone_number') String? phoneNumber,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class ImageDetail with _$ImageDetail {
  const factory ImageDetail({
    required int id,
    @JsonKey(name: 'image_name') String? imageName,
    String? image,
    String? author,
  }) = _ImageDetail;

  factory ImageDetail.fromJson(Map<String, dynamic> json) =>
      _$ImageDetailFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class Country with _$Country {
  const factory Country({required int id, String? name, String? code}) =
      _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class StateData with _$StateData {
  const factory StateData({required int id, String? name, int? country}) =
      _StateData;

  factory StateData.fromJson(Map<String, dynamic> json) =>
      _$StateDataFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class City with _$City {
  const factory City({
    required int id,
    String? name,
    int? state,
    required int country,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  @override
  Map<String, dynamic> toJson();
}

@freezed
abstract class Neighborhood with _$Neighborhood {
  const factory Neighborhood({required int id, String? name, int? city}) =
      _Neighborhood;

  factory Neighborhood.fromJson(Map<String, dynamic> json) =>
      _$NeighborhoodFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
