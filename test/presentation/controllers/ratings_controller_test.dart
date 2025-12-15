import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/ratings_controller/ratings_controller.dart';
import 'package:inn/domain/repositories/ratings_repository.dart';
import 'package:inn/data/models/rating_model.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRatingsRepository mockRatingsRepository;

  setUp(() {
    mockRatingsRepository = MockRatingsRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        ratingsRepositoryProvider.overrideWithValue(mockRatingsRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  const tRatingId = 1;
  const tHouseId = 101;
  final tRatingModel = RatingModel(
    id: tRatingId,
    rental: tHouseId,
    stars: 5,
    ratingReason: 'Good',
  );

  group('RatingsController', () {
    test('build fetches ratings', () async {
      when(
        mockRatingsRepository.getUserRatings(),
      ).thenAnswer((_) async => [tRatingModel]);

      final container = makeContainer();
      // final listener = container.listen(ratingsControllerProvider, (_, _) {});

      await container.read(ratingsControllerProvider.future);

      expect(container.read(ratingsControllerProvider).value, [tRatingModel]);
      verify(mockRatingsRepository.getUserRatings()).called(1);
    });

    test('addRating calls repo and updates state', () async {
      when(
        mockRatingsRepository.getUserRatings(),
      ).thenAnswer((_) async => []); // Start empty
      when(
        mockRatingsRepository.addRating(
          houseId: anyNamed('houseId'),
          stars: anyNamed('stars'),
          reason: anyNamed('reason'),
        ),
      ).thenAnswer((_) async => tRatingModel);

      final container = makeContainer();
      // initialize
      await container.read(ratingsControllerProvider.future);

      final controller = container.read(ratingsControllerProvider.notifier);
      await controller.addRating(houseId: tHouseId, stars: 5, reason: 'Good');

      expect(container.read(ratingsControllerProvider).value, [tRatingModel]);
      verify(
        mockRatingsRepository.addRating(
          houseId: tHouseId,
          stars: 5,
          reason: 'Good',
        ),
      ).called(1);
    });

    test('updateRating calls repo and updates state', () async {
      final initialList = [tRatingModel];
      final updatedRating = tRatingModel.copyWith(stars: 4);

      when(
        mockRatingsRepository.getUserRatings(),
      ).thenAnswer((_) async => initialList);
      when(
        mockRatingsRepository.updateRating(
          ratingId: anyNamed('ratingId'),
          houseId: anyNamed('houseId'),
          stars: anyNamed('stars'),
          reason: anyNamed('reason'),
        ),
      ).thenAnswer((_) async => updatedRating);

      final container = makeContainer();
      await container.read(ratingsControllerProvider.future);

      final controller = container.read(ratingsControllerProvider.notifier);
      await controller.updateRating(
        ratingId: tRatingId,
        houseId: tHouseId,
        stars: 4,
        reason: 'Good',
      );

      final state = container.read(ratingsControllerProvider).value!;
      expect(state.first.stars, 4);
      verify(
        mockRatingsRepository.updateRating(
          ratingId: tRatingId,
          houseId: tHouseId,
          stars: 4,
          reason: 'Good',
        ),
      ).called(1);
    });

    test('deleteRating calls repo and updates state', () async {
      final initialList = [tRatingModel];

      when(
        mockRatingsRepository.getUserRatings(),
      ).thenAnswer((_) async => initialList);
      when(
        mockRatingsRepository.deleteRating(tRatingId),
      ).thenAnswer((_) async => {});

      final container = makeContainer();
      await container.read(ratingsControllerProvider.future);

      final controller = container.read(ratingsControllerProvider.notifier);
      await controller.deleteRating(tRatingId);

      expect(container.read(ratingsControllerProvider).value, isEmpty);
      verify(mockRatingsRepository.deleteRating(tRatingId)).called(1);
    });
  });
}
