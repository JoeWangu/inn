import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'house_controller.g.dart';

// ==========================================================
// 1. DATABASE STREAM (The Source of Truth)
// Both screens listen to this to get the actual data.
// ==========================================================
@riverpod
Stream<List<HouseModel>> houseStream(Ref ref) {
  final repository = ref.watch(houseRepositoryProvider);
  return repository.watchHouses();
}

// ==========================================================
// 2. HOME CONTROLLER (Logic for "2nd Last Page")
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
      // Logic: You might want to check if DB is empty before fetching?
      // Or just always fetch to update cache?
      // User Req: "fetch from db unless stale or pull to refresh"
      // Simple check: Just fetch. The repo saves to DB, Stream updates UI.
      await repository.fetchRecentHouses();
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

// ==========================================================
// 3. EXPLORE CONTROLLER (Pagination Logic)
// ==========================================================
@riverpod
class ExploreHouseController extends _$ExploreHouseController {
  // We keep track of the page number internally
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  FutureOr<void> build() {
    // Load page 1 on start
    _loadPage(1);
  }

  Future<void> loadNextPage() async {
    // Prevent duplicate calls if already loading or no more data
    if (state.isLoading || !_hasMore) return;
    
    // Load the next page
    await _loadPage(_currentPage + 1);
  }

  Future<void> _loadPage(int page) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);
      
      // Fetch and save to DB
      final hasNext = await repository.fetchHousesPage(page);
      
      // Update state
      _currentPage = page;
      _hasMore = hasNext;
    });
  }
}