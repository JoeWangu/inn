import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_house_request.freezed.dart';
part 'create_house_request.g.dart';

@freezed
abstract class CreateHouseRequest with _$CreateHouseRequest {
  @JsonSerializable(
    includeIfNull: true,
  ) // Ensure nulls are sent if needed, or false if not
  const factory CreateHouseRequest({
    required String title,
    @JsonKey(name: 'image') int? image, // Assuming API accepts null or valid ID
    required double price,
    required String description,
    required String category,
    required bool available,
    @JsonKey(name: 'total_units') required int totalUnits,
    @JsonKey(name: 'is_active') required bool isActive,
    // Location IDs
    int? country,
    int? state,
    int? city,
    int? neighborhood,
  }) = _CreateHouseRequest;

  factory CreateHouseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHouseRequestFromJson(json);

  Map<String, dynamic> toJson();
}
