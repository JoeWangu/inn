import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'house_controller.g.dart';

// ==========================================================
// DATABASE STREAM (The Source of Truth)
// Both screens listen to this to get the actual data.
// ==========================================================
@riverpod
Stream<List<HouseModel>> houseStream(Ref ref) {
  final repository = ref.watch(houseRepositoryProvider);
  return repository.watchHouses();
}

// ==========================================================
// HOME CONTROLLER (Logic for "2nd Last Page")
// ==========================================================
@riverpod
class HomeHouseController extends _$HomeHouseController {
  @override
  FutureOr<void> build() async {
    // On initialization, check if we need to fetch data
    // We don't await this because we want to show DB data immediately if it exists.
    _fetchInitial();
  }

  Future<void> _fetchInitial() async {
    try {
      final repository = ref.read(houseRepositoryProvider);

      // ✅ CHECK LOGIC BEFORE FETCHING
      final shouldFetch = await repository.shouldFetchHomeData();

      if (shouldFetch) {
        print("Cache stale or empty. Fetching from API...");
        await repository.fetchRecentHouses();
      } else {
        print("Cache fresh. Using Database.");
      }
    } catch (e) {
      print('Home fetch failed: $e');
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);
      await repository.fetchRecentHouses();
    });
  }
}
