// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtraImageModel _$ExtraImageModelFromJson(Map<String, dynamic> json) =>
    _ExtraImageModel(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String,
      rental: (json['rental'] as num).toInt(),
    );

Map<String, dynamic> _$ExtraImageModelToJson(_ExtraImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'rental': instance.rental,
    };
