import 'package:inn/data/datasources/remote/houses_api.dart';
import 'package:inn/data/models/rating_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ratings_repository.g.dart';

@Riverpod(keepAlive: true)
RatingsRepository ratingsRepository(Ref ref) {
  return RatingsRepository(ref.read(housesApiProvider));
}

class RatingsRepository {
  final HousesApi _api;

  RatingsRepository(this._api);

  Future<List<RatingModel>> getUserRatings() async {
    // API returns paginated response, we just get results for now
    final response = await _api.getRatings();
    return response.results;
  }

  Future<RatingModel> addRating({
    required int houseId,
    required int stars,
    String? reason,
  }) async {
    return _api.addRating({
      'rental': houseId,
      'stars': stars,
      'rating_reason': reason ?? '',
    });
  }

  Future<RatingModel> updateRating({
    required int ratingId,
    required int houseId,
    required int stars,
    String? reason,
  }) async {
    return _api.updateRating(ratingId, {
      'rental': houseId,
      'stars': stars,
      'rating_reason': reason ?? '',
    });
  }

  Future<void> deleteRating(int ratingId) async {
    return _api.deleteRating(ratingId);
  }
}
