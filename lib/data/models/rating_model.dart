import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_model.freezed.dart';
part 'rating_model.g.dart';

@freezed
abstract class RatingModel with _$RatingModel {
  const factory RatingModel({
    required int id,
    required int rental,
    required int stars,
    @JsonKey(name: 'rating_reason') String? ratingReason,
  }) = _RatingModel;

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
