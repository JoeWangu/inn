import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'explore_controller.g.dart';

// ==========================================================
// EXPLORE CONTROLLER (Pagination Logic)
// ==========================================================
@riverpod
class ExploreHouseController extends _$ExploreHouseController {
  int _currentPage = 1;

  @override
  FutureOr<bool> build() {
    // Initial state: true (We assume there are items to load)
    // We trigger the first load immediately after build
    Future.microtask(() => _loadPage(1));
    return true;
  }

  Future<void> loadNextPage() async {
    // 1. Check if safe to load
    // If already loading or no more data (value is false), stop.
    if (state.isLoading || state.value == false) return;

    await _loadPage(_currentPage + 1);
  }

  Future<void> _loadPage(int page) async {
    // 2. Set Loading State (FIX IS HERE)
    // We add <bool> to explicitly match the state type.
    state = const AsyncLoading<bool>();
    // .copyWithPrevious(state);

    final newState = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);

      // Fetch data
      final hasNext = await repository.fetchHousesPage(page);

      // Only update page index if successful
      _currentPage = page;

      return hasNext; // Returns bool, matching FutureOr<bool>
    });

    if (ref.mounted) {
      state = newState;
    }
  }
}
