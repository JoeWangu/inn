import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'dart:convert';
import 'package:inn/data/models/user_profile_model.dart';

import 'package:inn/data/datasources/local/favorites_table.dart';
import 'package:inn/data/datasources/local/houses_table.dart';
import 'package:inn/data/datasources/local/my_houses_table.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:inn/data/datasources/local/user_profile_table.dart';

part 'app_database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@DriftDatabase(
  tables: [HousesTable, MyHousesTable, FavoritesTable, UserProfileTable],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(myHousesTable);
        }
        if (from < 3) {
          await m.createTable(favoritesTable);
        }
        if (from < 4) {
          await m.createTable(userProfileTable);
        }
      },
    );
  }

  Future<void> insertHouses(List<HouseModel> houses) async {
    await batch((batch) {
      for (final house in houses) {
        batch.insert(
          housesTable,
          HousesTableCompanion.insert(
            id: Value(house.id),
            data: house,
            category: house.category ?? '',
            fetchedAt: Value(DateTime.now()),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Stream<List<HouseModel>> watchHouses() {
    return (select(
      housesTable,
    )..orderBy([(t) => OrderingTerm.asc(t.id)])).map((row) => row.data).watch();
  }

  Future<void> clearHouses() => delete(housesTable).go();

  Future<int> getHouseCount() {
    final countExp = housesTable.id.count();
    final query = selectOnly(housesTable)..addColumns([countExp]);
    return query.map((row) => row.read(countExp)!).getSingle();
  }

  Future<DateTime?> getLatestFetchTime() {
    return (select(housesTable)
          ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
          ..limit(1))
        .map((row) => row.fetchedAt)
        .getSingleOrNull();
  }

  Future<void> insertMyHouses(List<HouseModel> houses) async {
    await batch((batch) {
      for (final house in houses) {
        batch.insert(
          myHousesTable,
          MyHousesTableCompanion.insert(
            id: Value(house.id),
            data: house,
            fetchedAt: Value(DateTime.now()),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Stream<List<HouseModel>> watchMyHouses() {
    return (select(myHousesTable)..orderBy([(t) => OrderingTerm.desc(t.id)]))
        .map((row) => row.data)
        .watch();
  }

  Future<int> getMyHousesCount() {
    final countExp = myHousesTable.id.count();
    final query = selectOnly(myHousesTable)..addColumns([countExp]);
    return query.map((row) => row.read(countExp)!).getSingle();
  }

  Future<DateTime?> getLatestMyHouseFetchTime() {
    return (select(myHousesTable)
          ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
          ..limit(1))
        .map((row) => row.fetchedAt)
        .getSingleOrNull();
  }

  Future<void> deleteMyHouse(int id) {
    return (delete(myHousesTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> insertFavorite({
    required HouseModel house,
    int? apiId,
    bool isSynced = true,
  }) async {
    return transaction(() async {
      await insertHouses([house]);

      await into(favoritesTable).insert(
        FavoritesTableCompanion.insert(
          houseId: house.id,
          apiFavoriteId: Value(apiId),
          isSynced: Value(isSynced),
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteFavorite(int houseId) {
    return (delete(
      favoritesTable,
    )..where((t) => t.houseId.equals(houseId))).go();
  }

  Future<void> deleteFavoriteByApiId(int apiId) {
    return (delete(
      favoritesTable,
    )..where((t) => t.apiFavoriteId.equals(apiId))).go();
  }

  Stream<List<HouseModel>> watchFavorites() {
    final query = select(favoritesTable).join([
      innerJoin(housesTable, housesTable.id.equalsExp(favoritesTable.houseId)),
    ]);

    query.orderBy([OrderingTerm.desc(favoritesTable.createdAt)]);

    return query
        .map((row) {
          return row.readTable(housesTable).data;
        })
        .watch()
        .map((houses) => houses.map((h) => h).toList());
  }

  Future<int?> getFavoriteApiId(int houseId) {
    return (select(favoritesTable)..where((t) => t.houseId.equals(houseId)))
        .map((row) => row.apiFavoriteId)
        .getSingleOrNull();
  }

  Stream<List<int>> watchFavoriteIds() {
    return (select(favoritesTable)).map((row) => row.houseId).watch();
  }

  Future<bool> isHouseFavorite(int houseId) async {
    final count = await (select(
      favoritesTable,
    )..where((t) => t.houseId.equals(houseId))).get();
    return count.isNotEmpty;
  }

  Future<void> insertUserProfile(UserProfileModel profile) async {
    await delete(userProfileTable).go();
    await into(userProfileTable).insert(
      UserProfileTableCompanion.insert(
        jsonData: jsonEncode(profile.toJson()),
        fetchedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<UserProfileModel?> getUserProfile() async {
    final row = await select(userProfileTable).getSingleOrNull();
    if (row != null) {
      return UserProfileModel.fromJson(jsonDecode(row.jsonData));
    }
    return null;
  }

  Future<void> clearUserProfile() => delete(userProfileTable).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
