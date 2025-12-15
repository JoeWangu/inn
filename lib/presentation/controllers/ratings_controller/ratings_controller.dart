import 'package:inn/data/models/rating_model.dart';
import 'package:inn/domain/repositories/ratings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ratings_controller.g.dart';

@riverpod
class RatingsController extends _$RatingsController {
  @override
  Future<List<RatingModel>> build() async {
    final repo = ref.read(ratingsRepositoryProvider);
    return repo.getUserRatings();
  }

  Future<void> addRating({
    required int houseId,
    required int stars,
    String? reason,
  }) async {
    final repo = ref.read(ratingsRepositoryProvider);
    final newRating = await repo.addRating(
      houseId: houseId,
      stars: stars,
      reason: reason,
    );

    if (ref.mounted) {
      final previous = state.value ?? [];
      state = AsyncData([...previous, newRating]);
    }
  }

  Future<void> updateRating({
    required int ratingId,
    required int houseId,
    required int stars,
    String? reason,
  }) async {
    final repo = ref.read(ratingsRepositoryProvider);
    final updated = await repo.updateRating(
      ratingId: ratingId,
      houseId: houseId,
      stars: stars,
      reason: reason,
    );

    if (ref.mounted) {
      final previous = state.value ?? [];
      state = AsyncData([
        for (final r in previous)
          if (r.id == ratingId) updated else r,
      ]);
    }
  }

  Future<void> deleteRating(int ratingId) async {
    final repo = ref.read(ratingsRepositoryProvider);
    await repo.deleteRating(ratingId);

    if (ref.mounted) {
      final previous = state.value ?? [];
      state = AsyncData([
        for (final r in previous)
          if (r.id != ratingId) r,
      ]);
    }
  }
}
