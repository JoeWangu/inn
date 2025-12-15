import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/core/database/app_database.dart';
import 'package:inn/data/models/paginated_response.dart';
import 'package:inn/data/models/extra_image_model.dart';
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

  Stream<List<HouseModel>> watchHouses() {
    return _db.watchHouses();
  }

  Future<void> fetchRecentHouses() async {
    try {
      final initialResponse = await _api.fetchHouses(page: 1);

      final totalCount = initialResponse.count;
      final pageSize = 10;
      final totalPages = (totalCount / pageSize).ceil();

      int targetPage = totalPages - 1;
      if (targetPage < 1) targetPage = 1;

      List<HouseModel> housesToSave;

      if (targetPage == 1) {
        housesToSave = initialResponse.results;
      } else {
        final specificResponse = await _api.fetchHouses(page: targetPage);
        housesToSave = specificResponse.results;
      }

      await _db.insertHouses(housesToSave);
    } catch (e) {
      // print('Error fetching recent houses: $e');
      rethrow;
    }
  }

  Future<bool> fetchHousesPage(int page) async {
    try {
      final response = await _api.fetchHouses(page: page);

      if (response.results.isEmpty) return false;

      await _db.insertHouses(response.results);

      return response.next != null;
    } catch (e) {
      // print('Error fetching page $page: $e');
      rethrow;
    }
  }

  Future<bool> shouldFetchHomeData() async {
    final count = await _db.getHouseCount();
    if (count == 0) return true;

    final lastFetch = await _db.getLatestFetchTime();
    if (lastFetch == null) return true;

    final difference = DateTime.now().difference(lastFetch);
    return difference.inHours >= 24;
  }

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

  Stream<List<HouseModel>> watchMyProperties() {
    return _db.watchMyHouses();
  }

  Future<void> fetchMyProperties({bool forceRefresh = false}) async {
    try {
      if (forceRefresh) {
        await _fetchAndSaveMyProperties();
        return;
      }

      final count = await _db.getMyHousesCount();
      if (count == 0) {
        await _fetchAndSaveMyProperties();
        return;
      }

      final lastFetch = await _db.getLatestMyHouseFetchTime();
      if (lastFetch == null) {
        await _fetchAndSaveMyProperties();
        return;
      }

      final difference = DateTime.now().difference(lastFetch);
      if (difference.inHours >= 48) {
        await _fetchAndSaveMyProperties();
      }
    } catch (e) {
      // print('Error fetching my properties: $e');
      rethrow;
    }
  }

  Future<void> _fetchAndSaveMyProperties() async {
    final response = await _api.getMyHouses();
    await _db.insertMyHouses(response.results);
  }

  Future<HouseModel> createHouse(CreateHouseRequest house) async {
    final newHouse = await _api.createHouse(house);
    await _db.insertMyHouses([newHouse]);
    await _db.insertHouses([newHouse]);
    return newHouse;
  }

  Future<HouseModel> updateHouse(int id, CreateHouseRequest house) async {
    final updatedHouse = await _api.updateHouse(id, house);
    await _db.insertMyHouses([updatedHouse]);
    await _db.insertHouses([updatedHouse]);
    return updatedHouse;
  }

  Future<void> deleteRating(int id) async {
    await _api.deleteRating(id);
  }

  Future<List<ExtraImageModel>> getExtraImages({int? rentalId}) async {
    final response = await _api.getExtraImages(rentalId: rentalId);
    return response.results;
  }

  Future<List<ExtraImageModel>> uploadExtraImages(
    int rentalId,
    List<File> images,
  ) async {
    return _api.uploadExtraImages(rental: rentalId, images: images);
  }

  Future<void> deleteExtraImage(int id) async {
    await _api.deleteExtraImage(id);
  }

  Future<void> deleteHouse(int id) async {
    try {
      await _api.deleteHouse(id);
    } on DioException catch (e) {
      if (e.response?.statusCode != 404) {
        rethrow;
      }
    }
    await _db.deleteMyHouse(id);
  }
}
