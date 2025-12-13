// import 'package:drift/drift.dart'; // For 'Value'
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/database/app_database.dart';
// import 'package:inn/core/errors/error_handler.dart'; // Optional, for logging
import 'package:inn/data/models/paginated_response.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:inn/data/models/create_house_request.dart';
import 'package:inn/data/datasources/remote/houses_api.dart';

part 'house_repository.g.dart';

@riverpod
HouseRepository houseRepository(Ref ref) {
  return HouseRepository(
    ref.read(housesApiProvider),
    ref.read(appDatabaseProvider),
  );
}

class HouseRepository {
  final HousesApi _api;
  final AppDatabase _db;

  HouseRepository(this._api, this._db);

  // ==========================================================
  // DATA STREAM (Single Source of Truth)
  // The UI listens to this. It updates automatically when we save to DB.
  // ==========================================================
  Stream<List<HouseModel>> watchHouses() {
    return _db.watchHouses();
  }

  // ==========================================================
  // HOME PAGE LOGIC (Fetch 2nd Last Page)
  // ==========================================================
  Future<void> fetchRecentHouses() async {
    try {
      // Step A: We need to know the 'count' to calculate pages.
      // We fetch Page 1 metadata first.
      final initialResponse = await _api.fetchHouses(page: 1);

      final totalCount = initialResponse.count;
      final pageSize = 10; // Assuming API returns 10 per page
      final totalPages = (totalCount / pageSize).ceil();

      // Step B: Calculate "2nd Last Page"
      // If totalPages is 5, we want page 4.
      // If totalPages is 1, we want page 1.
      int targetPage = totalPages - 1;
      if (targetPage < 1) targetPage = 1;

      List<HouseModel> housesToSave;

      // Step C: Optimization
      // If target is Page 1, we already have the data! No need to fetch again.
      if (targetPage == 1) {
        housesToSave = initialResponse.results;
      } else {
        // Fetch the specific target page
        final specificResponse = await _api.fetchHouses(page: targetPage);
        housesToSave = specificResponse.results;
      }

      // Step D: Save to DB (UI updates automatically)
      // We clear old cache first to ensure "Home" shows only these specific ones?
      // Or we just append? Usually for "Recent", we might want to clear old junk.
      // Let's upsert (Insert or Replace).
      await _db.insertHouses(housesToSave);
    } catch (e) {
      // Log error, but don't crash. UI will just show old DB data if available.
      print('Error fetching recent houses: $e');
      rethrow; // Pass error up if Controller wants to show a SnackBar
    }
  }

  // ==========================================================
  // EXPLORE PAGE LOGIC (Pagination)
  // ==========================================================
  // Returns 'true' if there are more pages, 'false' if we reached the end.
  Future<bool> fetchHousesPage(int page) async {
    try {
      final response = await _api.fetchHouses(page: page);

      if (response.results.isEmpty) return false;

      // Save to DB
      await _db.insertHouses(response.results);

      // Check if there is a 'next' URL. If null, we are done.
      return response.next != null;
    } catch (e) {
      print('Error fetching page $page: $e');
      rethrow;
    }
  }

  // ==========================================================
  // HOME SHOULD FETCH?(returns true or false based on the set rules.)
  // ==========================================================
  Future<bool> shouldFetchHomeData() async {
    // Rule 1: Is DB Empty?
    final count = await _db.getHouseCount();
    if (count == 0) return true;

    // Rule 2: Is Data Stale (> 24 hours)?
    final lastFetch = await _db.getLatestFetchTime();
    if (lastFetch == null) return true; // Safety fallback

    final difference = DateTime.now().difference(lastFetch);
    return difference.inHours >= 24;
  }

  // ==========================================================
  // SEARCH
  // ==========================================================
  Future<PaginatedResponse<HouseModel>> searchHouses(
    String query, {
    int page = 1,
    num? minPrice,
    num? maxPrice,
    String? city,
    String? category,
  }) async {
    return _api.fetchHouses(
      page: page,
      search: query,
      minPrice: minPrice,
      maxPrice: maxPrice,
      city: city,
      category: category,
    );
  }

  // ==========================================================
  // MY PROPERTIES (Manage Rentals)
  // ==========================================================

  Stream<List<HouseModel>> watchMyProperties() {
    // This stream comes from the separate 'MyHousesTable'
    return _db.watchMyHouses();
  }

  Future<void> fetchMyProperties({bool forceRefresh = false}) async {
    try {
      // Rule 1: Force Refresh
      if (forceRefresh) {
        await _fetchAndSaveMyProperties();
        return;
      }

      // Rule 2: Is DB Empty?
      final count = await _db.getMyHousesCount();
      if (count == 0) {
        await _fetchAndSaveMyProperties();
        return;
      }

      // Rule 3: Is Data Stale (> 48 hours)?
      final lastFetch = await _db.getLatestMyHouseFetchTime();
      if (lastFetch == null) {
        // Should not happen if count > 0, but safety check
        await _fetchAndSaveMyProperties();
        return;
      }

      final difference = DateTime.now().difference(lastFetch);
      if (difference.inHours >= 48) {
        await _fetchAndSaveMyProperties();
      }

      // If none of the above, we do nothing. UI shows DB data.
    } catch (e) {
      print('Error fetching my properties: $e');
      rethrow;
    }
  }

  Future<void> _fetchAndSaveMyProperties() async {
    final response = await _api.getMyHouses();
    await _db.insertMyHouses(response.results);
  }

  Future<HouseModel> createHouse(CreateHouseRequest house) async {
    final newHouse = await _api.createHouse(house);
    // Insert into 'MyHousesTable' immediately so UI updates
    await _db.insertMyHouses([newHouse]);
    return newHouse;
  }

  Future<HouseModel> updateHouse(int id, CreateHouseRequest house) async {
    final updatedHouse = await _api.updateHouse(id, house);
    // Update 'MyHousesTable'
    await _db.insertMyHouses([updatedHouse]);
    return updatedHouse;
  }

  Future<void> deleteHouse(int id) async {
    try {
      await _api.deleteHouse(id);
    } on DioException catch (e) {
      // If 404, it means it's already deleted on server.
      // We should proceed to delete it locally.
      if (e.response?.statusCode != 404) {
        rethrow;
      }
    }
    // Remove from local DB immediately
    await _db.deleteMyHouse(id);
  }
}
