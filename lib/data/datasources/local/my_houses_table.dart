import 'package:drift/drift.dart';
import 'package:inn/data/datasources/local/houses_table.dart'; // Reuse the converter

// A separate table for "My Properties" to keep them distinct from the Explore feed
class MyHousesTable extends Table {
  // Primary Key from Server
  IntColumn get id => integer()();

  // Store the full object as JSON
  TextColumn get data => text().map(const HouseModelConverter())();

  // For cache invalidation logic
  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
