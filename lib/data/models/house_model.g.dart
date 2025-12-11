// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HouseModel _$HouseModelFromJson(Map<String, dynamic> json) => _HouseModel(
  id: (json['id'] as num).toInt(),
  image: (json['image'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  totalUnits: (json['total_units'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  datePosted: DateTime.parse(json['date_posted'] as String),
  dateModified: DateTime.parse(json['date_modified'] as String),
  timePosted: json['time_posted'] as String,
  timeModified: json['time_modified'] as String,
  available: json['available'] as bool,
  isActive: json['is_active'] as bool,
  authorDetail: AuthorDetail.fromJson(
    json['author_detail'] as Map<String, dynamic>,
  ),
  imageDetail: ImageDetail.fromJson(
    json['image_detail'] as Map<String, dynamic>,
  ),
  avgRating: json['avg_rating'] as num,
  country: json['country'] == null
      ? null
      : Country.fromJson(json['country'] as Map<String, dynamic>),
  state: json['state'] == null
      ? null
      : StateData.fromJson(json['state'] as Map<String, dynamic>),
  city: json['city'] == null
      ? null
      : City.fromJson(json['city'] as Map<String, dynamic>),
  neighborhood: json['neighborhood'] == null
      ? null
      : Neighborhood.fromJson(json['neighborhood'] as Map<String, dynamic>),
  author: json['author'] as String,
);

Map<String, dynamic> _$HouseModelToJson(_HouseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'price': instance.price,
      'total_units': instance.totalUnits,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'date_posted': instance.datePosted.toIso8601String(),
      'date_modified': instance.dateModified.toIso8601String(),
      'time_posted': instance.timePosted,
      'time_modified': instance.timeModified,
      'available': instance.available,
      'is_active': instance.isActive,
      'author_detail': instance.authorDetail.toJson(),
      'image_detail': instance.imageDetail.toJson(),
      'avg_rating': instance.avgRating,
      'country': instance.country?.toJson(),
      'state': instance.state?.toJson(),
      'city': instance.city?.toJson(),
      'neighborhood': instance.neighborhood?.toJson(),
      'author': instance.author,
    };

_AuthorDetail _$AuthorDetailFromJson(Map<String, dynamic> json) =>
    _AuthorDetail(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      userProfile: json['user_profile'] == null
          ? null
          : UserProfile.fromJson(json['user_profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthorDetailToJson(_AuthorDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'user_profile': instance.userProfile,
    };

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) =>
    _UserProfile(phoneNumber: json['phone_number'] as String);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{'phone_number': instance.phoneNumber};

_ImageDetail _$ImageDetailFromJson(Map<String, dynamic> json) => _ImageDetail(
  id: (json['id'] as num).toInt(),
  imageName: json['image_name'] as String,
  image: json['image'] as String,
  author: json['author'] as String,
);

Map<String, dynamic> _$ImageDetailToJson(_ImageDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_name': instance.imageName,
      'image': instance.image,
      'author': instance.author,
    };

_Country _$CountryFromJson(Map<String, dynamic> json) => _Country(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  code: json['code'] as String,
);

Map<String, dynamic> _$CountryToJson(_Country instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
};

_City _$CityFromJson(Map<String, dynamic> json) => _City(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  state: json['state'],
  country: (json['country'] as num).toInt(),
);

Map<String, dynamic> _$CityToJson(_City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'state': instance.state,
  'country': instance.country,
};

_Neighborhood _$NeighborhoodFromJson(Map<String, dynamic> json) =>
    _Neighborhood(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      city: (json['city'] as num).toInt(),
    );

Map<String, dynamic> _$NeighborhoodToJson(_Neighborhood instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
    };

_StateData _$StateDataFromJson(Map<String, dynamic> json) =>
    _StateData(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$StateDataToJson(_StateData instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
