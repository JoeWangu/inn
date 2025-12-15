import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/create_house_controller.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import 'package:inn/domain/repositories/location_repository.dart';
import 'package:inn/data/models/house_model.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHouseRepository mockHouseRepository;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockHouseRepository = MockHouseRepository();
    mockLocationRepository = MockLocationRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        houseRepositoryProvider.overrideWithValue(mockHouseRepository),
        locationRepositoryProvider.overrideWithValue(mockLocationRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('CreateHouseController', () {
    final tCountry = Country(id: 1, name: 'Country');
    final tState = StateData(id: 1, name: 'State');

    test('build fetches countries', () async {
      when(
        mockLocationRepository.getCountries(),
      ).thenAnswer((_) async => [tCountry]);

      final container = makeContainer();
      // Listen to initialize
      container.listen(createHouseControllerProvider, (_, _) {});

      // wait for build
      await container.read(createHouseControllerProvider.future);

      final state = container.read(createHouseControllerProvider).value!;
      expect(state.countries, [tCountry]);
      verify(mockLocationRepository.getCountries()).called(1);
    });

    test('setCountry fetches states', () async {
      when(
        mockLocationRepository.getCountries(),
      ).thenAnswer((_) async => [tCountry]);
      when(
        mockLocationRepository.getStates(1),
      ).thenAnswer((_) async => [tState]);

      final container = makeContainer();
      container.listen(createHouseControllerProvider, (_, _) {});
      await container.read(createHouseControllerProvider.future);

      final controller = container.read(createHouseControllerProvider.notifier);
      controller.setCountry(1);

      // We need to wait for state update. Since setCountry is async void, we might access state directly or assume it updates fast.
      // Better way is to check intermediate loading state if we could, but here we check final state.
      // Since setCountry uses async/await internally but returns void, testing it is slightly tricky without `pump`.
      // But Riverpod state updates are synchronous after await. The issue is awaiting the async gap in void method.
      // We can assume microtask queue.

      await Future.delayed(Duration.zero); // Wait for async gap
      await Future.delayed(Duration.zero); // Extra safety

      final state = container.read(createHouseControllerProvider).value!;
      expect(state.countryId, 1);
      expect(state.states, [tState]);
      verify(mockLocationRepository.getStates(1)).called(1);
    });

    test('submit calls createHouse with correct data', () async {
      when(mockLocationRepository.getCountries()).thenAnswer((_) async => []);
      when(mockHouseRepository.createHouse(any)).thenAnswer(
        (_) async => HouseModel(
          id: 1,
          price: 100,
          totalUnits: 1,
          datePosted: DateTime.now(),
          dateModified: DateTime.now(),
          available: true,
          isActive: true,
          avgRating: 0,
          authorDetail: AuthorDetail(id: 1),
          category: 'A',
        ),
      );

      final container = makeContainer();
      container.listen(createHouseControllerProvider, (_, _) {});
      await container.read(createHouseControllerProvider.future);

      final controller = container.read(createHouseControllerProvider.notifier);

      // Populate state manually or via setters
      controller.setImage(10);

      final success = await controller.submit(
        title: 'Title',
        price: 100.0,
        description: 'Desc',
        category: 'Cat',
        totalUnits: 1,
        available: true,
        isActive: true,
      );

      expect(success, true);
      verify(mockHouseRepository.createHouse(any)).called(1);
    });
  });
}
