// import 'package:drift/drift.dart'; // For 'Value'
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/database/app_database.dart';
// import 'package:inn/core/errors/error_handler.dart'; // Optional, for logging
import 'package:inn/data/models/house_model.dart';
import 'package:inn/data/datasources/remote/houses_api.dart';

part 'house_repository.g.dart';

@riverpod
HouseRepository houseRepository(Ref ref) {
  return HouseRepository(
    ref.read(housesApiProvider),
    ref.read(appDatabaseProvider), // Assuming you exposed the DB as a provider
  );
}

class HouseRepository {
  final HousesApi _api;
  final AppDatabase _db;

  HouseRepository(this._api, this._db);

  // ==========================================================
  // 1. DATA STREAM (Single Source of Truth)
  // The UI listens to this. It updates automatically when we save to DB.
  // ==========================================================
  Stream<List<HouseModel>> watchHouses() {
    return _db.watchHouses();
  }

  // ==========================================================
  // 2. HOME PAGE LOGIC (Fetch 2nd Last Page)
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
  // 3. EXPLORE PAGE LOGIC (Pagination)
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
}
