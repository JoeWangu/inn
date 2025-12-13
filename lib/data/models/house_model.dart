import 'package:freezed_annotation/freezed_annotation.dart';

part 'house_model.freezed.dart';
part 'house_model.g.dart';

@freezed
abstract class HouseModel with _$HouseModel {
  // explicitToJson allows nested objects to be serialized correctly
  @JsonSerializable(explicitToJson: true)
  const factory HouseModel({
    required int id,
    // The ID reference to the image (int)
    int? image,
    required double price,
    @JsonKey(name: 'total_units') required int totalUnits,
    String? title,
    String? description,
    String? category,

    // Dates are automatically parsed if in YYYY-MM-DD format
    @JsonKey(name: 'date_posted') required DateTime datePosted,
    @JsonKey(name: 'date_modified') required DateTime dateModified,

    // Times are usually safer as Strings unless you combine them with dates
    @JsonKey(name: 'time_posted') String? timePosted,
    @JsonKey(name: 'time_modified') String? timeModified,

    required bool available,
    @JsonKey(name: 'is_active') required bool isActive,

    // Nested Objects
    @JsonKey(name: 'author_detail') required AuthorDetail authorDetail,
    @JsonKey(name: 'image_detail') ImageDetail? imageDetail,

    // Rating
    @JsonKey(name: 'avg_rating')
    required num avgRating, // num handles int or double

    Country? country,
    StateData? state,
    City? city,
    Neighborhood? neighborhood,

    // The flat username string
    String? author,
  }) = _HouseModel;

  factory HouseModel.fromJson(Map<String, dynamic> json) =>
      _$HouseModelFromJson(json);

  Map<String, dynamic> toJson();
}

// --- NESTED CLASSES ---

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

  Map<String, dynamic> toJson();
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    @JsonKey(name: 'phone_number') String? phoneNumber,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

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

  Map<String, dynamic> toJson();
}

@freezed
abstract class Country with _$Country {
  const factory Country({required int id, String? name, String? code}) =
      _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson();
}

@freezed
abstract class StateData with _$StateData {
  const factory StateData({required int id, String? name, int? country}) =
      _StateData;

  factory StateData.fromJson(Map<String, dynamic> json) =>
      _$StateDataFromJson(json);

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

  Map<String, dynamic> toJson();
}

@freezed
abstract class Neighborhood with _$Neighborhood {
  const factory Neighborhood({required int id, String? name, int? city}) =
      _Neighborhood;

  factory Neighborhood.fromJson(Map<String, dynamic> json) =>
      _$NeighborhoodFromJson(json);

  Map<String, dynamic> toJson();
}
