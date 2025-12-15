import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inn/presentation/controllers/explore_contoller/explore_controller.dart';
import 'package:inn/domain/repositories/house_repository.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHouseRepository mockHouseRepository;

  setUp(() {
    mockHouseRepository = MockHouseRepository();
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        houseRepositoryProvider.overrideWithValue(mockHouseRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('ExploreHouseController', () {
    test('initial build triggers fetching page 1', () async {
      when(
        mockHouseRepository.fetchHousesPage(1),
      ).thenAnswer((_) async => true);

      final container = makeContainer();
      // final listener = container.listen(
      //   exploreHouseControllerProvider,
      //   (_, _) {},
      // );

      // Wait for build
      await container.read(exploreHouseControllerProvider.future);

      // Since `build` launches a microtask to load page 1, we need to wait for it.
      // AsyncLoading should happen, then AsyncData(true/false).

      // Wait for microtasks
      await Future.delayed(Duration.zero);

      // Verify repository called
      verify(mockHouseRepository.fetchHousesPage(1)).called(1);
    });

    test('loadNextPage fetches page 2', () async {
      when(
        mockHouseRepository.fetchHousesPage(1),
      ).thenAnswer((_) async => true); // hasNext
      when(
        mockHouseRepository.fetchHousesPage(2),
      ).thenAnswer((_) async => true);

      final container = makeContainer();
      container.listen(exploreHouseControllerProvider, (_, _) {});

      // Wait for init
      await container.read(exploreHouseControllerProvider.future);
      await Future.delayed(Duration.zero);

      final controller = container.read(
        exploreHouseControllerProvider.notifier,
      );
      await controller.loadNextPage();

      verify(mockHouseRepository.fetchHousesPage(2)).called(1);
    });

    test(
      'loadNextPage does nothing if state is false (no more pages)',
      () async {
        when(
          mockHouseRepository.fetchHousesPage(1),
        ).thenAnswer((_) async => false); // No more pages

        final container = makeContainer();
        container.listen(exploreHouseControllerProvider, (_, _) {});

        await container.read(exploreHouseControllerProvider.future);
        await Future.delayed(Duration.zero);

        final controller = container.read(
          exploreHouseControllerProvider.notifier,
        );
        await controller.loadNextPage();

        // Should NOT call page 2
        verifyNever(mockHouseRepository.fetchHousesPage(2));
      },
    );
  });
}
