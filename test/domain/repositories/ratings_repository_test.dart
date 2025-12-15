import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:inn/domain/repositories/ratings_repository.dart';
import 'package:inn/data/models/rating_model.dart';
import 'package:inn/data/models/paginated_response.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHousesApi mockHousesApi;
  late RatingsRepository ratingsRepository;

  setUp(() {
    mockHousesApi = MockHousesApi();
    ratingsRepository = RatingsRepository(mockHousesApi);
  });

  const tRatingId = 1;
  const tHouseId = 101;
  final tRatingModel = RatingModel(
    id: tRatingId,
    rental: tHouseId,
    stars: 5,
    ratingReason: 'Great',
  );

  group('getUserRatings', () {
    test('should return list of ratings from API', () async {
      // arrange
      final tResponse = PaginatedResponse<RatingModel>(
        count: 1,
        results: [tRatingModel],
      );
      when(mockHousesApi.getRatings()).thenAnswer((_) async => tResponse);

      // act
      final result = await ratingsRepository.getUserRatings();

      // assert
      expect(result, [tRatingModel]);
      verify(mockHousesApi.getRatings());
    });
  });

  group('addRating', () {
    test('should return created rating from API', () async {
      // arrange
      when(mockHousesApi.addRating(any)).thenAnswer((_) async => tRatingModel);

      // act
      final result = await ratingsRepository.addRating(
        houseId: tHouseId,
        stars: 5,
        reason: 'Great',
      );

      // assert
      expect(result, tRatingModel);
      verify(
        mockHousesApi.addRating({
          'rental': tHouseId,
          'stars': 5,
          'rating_reason': 'Great',
        }),
      );
    });
  });

  group('updateRating', () {
    test('should return updated rating from API', () async {
      // arrange
      when(
        mockHousesApi.updateRating(any, any),
      ).thenAnswer((_) async => tRatingModel);

      // act
      final result = await ratingsRepository.updateRating(
        ratingId: tRatingId,
        houseId: tHouseId,
        stars: 5,
        reason: 'Great',
      );

      // assert
      expect(result, tRatingModel);
      verify(
        mockHousesApi.updateRating(tRatingId, {
          'rental': tHouseId,
          'stars': 5,
          'rating_reason': 'Great',
        }),
      );
    });
  });

  group('deleteRating', () {
    test('should call delete API', () async {
      // arrange
      when(mockHousesApi.deleteRating(any)).thenAnswer((_) async => {});

      // act
      await ratingsRepository.deleteRating(tRatingId);

      // assert
      verify(mockHousesApi.deleteRating(tRatingId));
    });
  });
}
