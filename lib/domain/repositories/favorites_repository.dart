import 'package:drift/drift.dart';
import 'package:inn/core/database/app_database.dart';
import 'package:inn/data/datasources/remote/houses_api.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository.g.dart';

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) {
  return FavoritesRepository(
    ref.read(housesApiProvider),
    ref.read(appDatabaseProvider),
  );
}

class FavoritesRepository {
  final HousesApi _api;
  final AppDatabase _db;

  FavoritesRepository(this._api, this._db);

  Stream<List<HouseModel>> watchFavorites() {
    return _db.watchFavorites();
  }

  Stream<List<int>> watchFavoriteIds() {
    return _db.watchFavoriteIds();
  }

  Future<void> syncFavorites() async {
    try {
      final Set<int> validApiHouseIds = {};

      bool hasNext = true;

      while (hasNext) {
        final response = await _api.getFavorites();

        for (final fav in response.results) {
          validApiHouseIds.add(fav.rental);

          final existingHouseCount = await (_db.select(
            _db.housesTable,
          )..where((t) => t.id.equals(fav.rental))).get();

          if (existingHouseCount.isEmpty) {
            try {
              final house = await _api.getHouse(fav.rental);
              await _db.insertHouses([house]);
            } catch (e) {
              // print("Error fetching house ${fav.rental} for favorite: $e");
              continue;
            }
          }

          await _db
              .into(_db.favoritesTable)
              .insert(
                FavoritesTableCompanion.insert(
                  houseId: fav.rental,
                  apiFavoriteId: Value(fav.id),
                  isSynced: const Value(true),
                ),
                mode: InsertMode.insertOrReplace,
              );
        }

        if (response.next == null) {
          hasNext = false;
        } else {
          hasNext = false;
        }
      }

      final localFavorites = await (_db.select(_db.favoritesTable)).get();
      for (final local in localFavorites) {
        if (local.isSynced && !validApiHouseIds.contains(local.houseId)) {
          await _db.deleteFavorite(local.houseId);
        }
      }
    } catch (e) {
      // print("Sync Favorites Error: $e");
    }
  }

  Future<void> toggleFavorite(HouseModel house) async {
    final isFav = await _db.isHouseFavorite(house.id);
    if (isFav) {
      await _removeFavorite(house.id);
    } else {
      await _addFavorite(house);
    }
  }

  Future<void> _addFavorite(HouseModel house) async {
    await _db.insertFavorite(house: house, isSynced: false);

    try {
      final response = await _api.addFavorite({'rental': house.id});

      await _db.insertFavorite(
        house: house,
        apiId: response.id,
        isSynced: true,
      );
    } catch (e) {
      await _db.deleteFavorite(house.id);
      rethrow;
    }
  }

  Future<void> _removeFavorite(int houseId) async {
    final fav = await (_db.select(
      _db.favoritesTable,
    )..where((t) => t.houseId.equals(houseId))).getSingleOrNull();

    if (fav == null) return;

    await _db.deleteFavorite(houseId);

    if (fav.apiFavoriteId != null) {
      try {
        await _api.deleteFavorite(fav.apiFavoriteId!);
      } catch (e) {
        // print("Remove favorite failed: $e");

        final houseData = await (_db.select(
          _db.housesTable,
        )..where((t) => t.id.equals(houseId))).getSingleOrNull();

        if (houseData != null) {
          await _db.insertFavorite(
            house: houseData.data,
            apiId: fav.apiFavoriteId,
            isSynced: true,
          );
        }
        rethrow;
      }
    }
  }
}
