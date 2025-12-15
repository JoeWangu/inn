import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'house_controller.g.dart';

@riverpod
Stream<List<HouseModel>> houseStream(Ref ref) {
  final repository = ref.watch(houseRepositoryProvider);
  return repository.watchHouses();
}

@riverpod
class HomeHouseController extends _$HomeHouseController {
  @override
  FutureOr<void> build() async {
    _fetchInitial();
    return null;
  }

  Future<void> _fetchInitial() async {
    try {
      final repository = ref.read(houseRepositoryProvider);

      final shouldFetch = await repository.shouldFetchHomeData();

      if (shouldFetch) {
        // print("Cache stale or empty. Fetching from API...");
        await repository.fetchRecentHouses();
      } else {
        // print("Cache fresh. Using Database.");
      }
    } catch (e) {
      // print('Home fetch failed: $e');
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);
      await repository.fetchRecentHouses();
    });

    if (ref.mounted) {
      state = newState;
    }
  }
}
