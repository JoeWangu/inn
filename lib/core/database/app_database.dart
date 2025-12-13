import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
// Import the table & model
import 'package:inn/data/datasources/local/houses_table.dart';
import 'package:inn/data/datasources/local/my_houses_table.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@DriftDatabase(tables: [HousesTable, MyHousesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // We added the MyHousesTable in version 2
          await m.createTable(myHousesTable);
        }
      },
    );
  }

  // --- DAO METHODS ---

  // Insert or Replace (Upsert)
  // Saves a list of houses to the DB. If one exists, it updates it.
  Future<void> insertHouses(List<HouseModel> houses) async {
    await batch((batch) {
      for (final house in houses) {
        batch.insert(
          housesTable,
          HousesTableCompanion.insert(
            id: Value(house.id),
            data: house, // The converter handles this automatically!
            category: house.category ?? '',
            fetchedAt: Value(DateTime.now()),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  // Get All Houses (Reactive Stream)
  // Returns a stream that automatically updates when 'insertHouses' is called.
  Stream<List<HouseModel>> watchHouses() {
    return (select(housesTable)
          // You might want to order by datePosted from inside the JSON,
          // but for now, we order by when we fetched it.
          // ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)]))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .map((row) => row.data) // Extract the HouseModel object
        .watch();
  }

  // Clear Cache (Optional, good for pull-to-refresh)
  Future<void> clearHouses() => delete(housesTable).go();

  // Check if DB is empty
  Future<int> getHouseCount() {
    final countExp = housesTable.id.count();
    final query = selectOnly(housesTable)..addColumns([countExp]);
    return query.map((row) => row.read(countExp)!).getSingle();
  }

  // Get the timestamp of the most recently saved item
  Future<DateTime?> getLatestFetchTime() {
    return (select(housesTable)
          ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)]) // Newest first
          ..limit(1)) // Only need one
        .map((row) => row.fetchedAt)
        .getSingleOrNull();
  }

  // --- MY HOUSES DAO ---

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
