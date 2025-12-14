// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => _RatingModel(
  id: (json['id'] as num).toInt(),
  rental: (json['rental'] as num).toInt(),
  stars: (json['stars'] as num).toInt(),
  ratingReason: json['rating_reason'] as String?,
);

Map<String, dynamic> _$RatingModelToJson(_RatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rental': instance.rental,
      'stars': instance.stars,
      'rating_reason': instance.ratingReason,
    };
