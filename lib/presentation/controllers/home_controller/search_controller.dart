import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'search_controller.g.dart';

@riverpod
class SearchHouseController extends _$SearchHouseController {
  Timer? _debounceTimer;

  @override
  FutureOr<List<HouseModel>> build() {
    return []; // Start with empty list
  }

  void search(String query) {
    // cancel any pending search
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      state = const AsyncData([]);
      return;
    }

    // Wait 500ms before hitting the API
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);
      return repository.searchHouses(query);
    });
  }
}
