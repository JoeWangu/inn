import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';
part 'favorite_model.g.dart';

@freezed
abstract class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    required int id, // The ID of the favorite record
    required int rental, // The ID of the house
  }) = _FavoriteModel;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);
}
