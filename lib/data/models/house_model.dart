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
    required int image, 
    required double price,
    @JsonKey(name: 'total_units') required int totalUnits,
    required String title,
    required String description,
    required String category,
    
    // Dates are automatically parsed if in YYYY-MM-DD format
    @JsonKey(name: 'date_posted') required DateTime datePosted,
    @JsonKey(name: 'date_modified') required DateTime dateModified,
    
    // Times are usually safer as Strings unless you combine them with dates
    @JsonKey(name: 'time_posted') required String timePosted,
    @JsonKey(name: 'time_modified') required String timeModified,
    
    required bool available,
    @JsonKey(name: 'is_active') required bool isActive,
    
    // Nested Objects
    @JsonKey(name: 'author_detail') required AuthorDetail authorDetail,
    @JsonKey(name: 'image_detail') required ImageDetail imageDetail,
    
    // Rating
    @JsonKey(name: 'avg_rating') required num avgRating, // num handles int or double
    
    // Location Objects (Nullable based on your JSON item #2)
    Country? country,
    StateData? state, // 'State' is a Flutter keyword, so we rename the class
    City? city,
    Neighborhood? neighborhood,
    
    // The flat username string
    required String author, 
  }) = _HouseModel;

  factory HouseModel.fromJson(Map<String, dynamic> json) => 
      _$HouseModelFromJson(json);
}

// --- NESTED CLASSES ---

@freezed
abstract class AuthorDetail with _$AuthorDetail {
  const factory AuthorDetail({
    required int id,
    required String username,
    required String email,
    @JsonKey(name: 'user_profile') UserProfile? userProfile,
  }) = _AuthorDetail;

  factory AuthorDetail.fromJson(Map<String, dynamic> json) => _$AuthorDetailFromJson(json);
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    @JsonKey(name: 'phone_number') required String phoneNumber,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
abstract class ImageDetail with _$ImageDetail {
  const factory ImageDetail({
    required int id,
    @JsonKey(name: 'image_name') required String imageName,
    required String image, // This is the full URL
    required String author,
  }) = _ImageDetail;

  factory ImageDetail.fromJson(Map<String, dynamic> json) => _$ImageDetailFromJson(json);
}

@freezed
abstract class Country with _$Country {
  const factory Country({
    required int id,
    required String name,
    required String code,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}

@freezed
abstract class City with _$City {
  const factory City({
    required int id,
    required String name,
    // 'state' might be an ID or object here? JSON shows null, assuming int? or object?
    // Kept dynamic/nullable to be safe
    Object? state, 
    required int country,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
abstract class Neighborhood with _$Neighborhood {
  const factory Neighborhood({
    required int id,
    required String name,
    required int city,
  }) = _Neighborhood;

  factory Neighborhood.fromJson(Map<String, dynamic> json) => _$NeighborhoodFromJson(json);
}

@freezed
abstract class StateData with _$StateData {
  const factory StateData({
    required int id,
    required String name,
  }) = _StateData;

  factory StateData.fromJson(Map<String, dynamic> json) => _$StateDataFromJson(json);
}