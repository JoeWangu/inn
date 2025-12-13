// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_house_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateHouseRequest _$CreateHouseRequestFromJson(Map<String, dynamic> json) =>
    _CreateHouseRequest(
      title: json['title'] as String,
      image: (json['image'] as num?)?.toInt(),
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      available: json['available'] as bool,
      totalUnits: (json['total_units'] as num).toInt(),
      isActive: json['is_active'] as bool,
      country: (json['country'] as num?)?.toInt(),
      state: (json['state'] as num?)?.toInt(),
      city: (json['city'] as num?)?.toInt(),
      neighborhood: (json['neighborhood'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateHouseRequestToJson(_CreateHouseRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'available': instance.available,
      'total_units': instance.totalUnits,
      'is_active': instance.isActive,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
    };
