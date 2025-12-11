import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
// Import the table & model
import 'package:inn/data/datasources/local/houses_table.dart';
import 'package:inn/data/models/house_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@DriftDatabase(tables: [HousesTable]) // <--- Add it here
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- DAO METHODS ---

  // 1. Insert or Replace (Upsert)
  // Saves a list of houses to the DB. If one exists, it updates it.
  Future<void> insertHouses(List<HouseModel> houses) async {
    await batch((batch) {
      for (final house in houses) {
        batch.insert(
          housesTable,
          HousesTableCompanion.insert(
            id: Value(house.id),
            data: house, // The converter handles this automatically!
            category: house.category,
            fetchedAt: Value(DateTime.now()),
          ),
          mode: InsertMode.insertOrReplace, 
        );
      }
    });
  }

  // 2. Get All Houses (Reactive Stream)
  // Returns a stream that automatically updates when 'insertHouses' is called.
  Stream<List<HouseModel>> watchHouses() {
    return (select(housesTable)
          // You might want to order by datePosted from inside the JSON, 
          // but for now, we order by when we fetched it.
          ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])) 
        .map((row) => row.data) // Extract the HouseModel object
        .watch();
  }
  
  // 3. Clear Cache (Optional, good for pull-to-refresh)
  Future<void> clearHouses() => delete(housesTable).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}