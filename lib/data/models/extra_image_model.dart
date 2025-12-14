import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_image_model.freezed.dart';
part 'extra_image_model.g.dart';

@freezed
abstract class ExtraImageModel with _$ExtraImageModel {
  const factory ExtraImageModel({
    required int id,
    required String image,
    required int rental,
  }) = _ExtraImageModel;

  factory ExtraImageModel.fromJson(Map<String, dynamic> json) =>
      _$ExtraImageModelFromJson(json);
}
