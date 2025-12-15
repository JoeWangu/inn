import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/domain/repositories/house_repository.dart';

part 'search_controller.g.dart';

@riverpod
class SearchHouseController extends _$SearchHouseController {
  Timer? _debounceTimer;
  int _currentPage = 1;
  bool _hasMore = true;

  String _lastQuery = '';
  num? _lastMinPrice;
  num? _lastMaxPrice;
  String? _lastCity;
  String? _lastCategory;

  @override
  FutureOr<List<HouseModel>> build() {
    return [];
  }

  void search(
    String query, {
    num? minPrice,
    num? maxPrice,
    String? city,
    String? category,
  }) {
    _debounceTimer?.cancel();

    if (query.trim().isEmpty &&
        minPrice == null &&
        maxPrice == null &&
        city == null &&
        category == null) {
      state = const AsyncData([]);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(
        query,
        minPrice: minPrice,
        maxPrice: maxPrice,
        city: city,
        category: category,
        isNewSearch: true,
      );
    });
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !_hasMore) return;

    await _performSearch(
      _lastQuery,
      minPrice: _lastMinPrice,
      maxPrice: _lastMaxPrice,
      city: _lastCity,
      category: _lastCategory,
      isNewSearch: false,
    );
  }

  Future<void> _performSearch(
    String query, {
    num? minPrice,
    num? maxPrice,
    String? city,
    String? category,
    required bool isNewSearch,
  }) async {
    if (isNewSearch) {
      state = const AsyncLoading();
      _currentPage = 1;
      _hasMore = true;
      _lastQuery = query;
      _lastMinPrice = minPrice;
      _lastMaxPrice = maxPrice;
      _lastCity = city;
      _lastCategory = category;
    }

    final newState = await AsyncValue.guard(() async {
      final repository = ref.read(houseRepositoryProvider);
      final response = await repository.searchHouses(
        query,
        page: _currentPage,
        minPrice: minPrice,
        maxPrice: maxPrice,
        city: city,
        category: category,
      );

      if (response.next == null) {
        _hasMore = false;
      } else {
        _currentPage++;
      }

      if (isNewSearch) {
        return response.results;
      } else {
        return [...?state.value, ...response.results];
      }
    });

    state = newState;
  }
}
