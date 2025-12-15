import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'explore_controller.g.dart';

@riverpod
class ExploreHouseController extends _$ExploreHouseController {
  int _currentPage = 1;

  @override
  FutureOr<bool> build() {
    Future.microtask(() => _loadPage(1));
    return true;
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.value == false) return;

    await _loadPage(_currentPage + 1);
  }

  Future<void> _loadPage(int page) async {
    state = const AsyncLoading<bool>();

    final newState = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);

      final hasNext = await repository.fetchHousesPage(page);

      _currentPage = page;

      return hasNext;
    });

    if (ref.mounted) {
      state = newState;
    }
  }
}
