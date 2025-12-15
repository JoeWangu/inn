import 'package:drift/drift.dart';
import 'package:inn/data/datasources/local/houses_table.dart';

class MyHousesTable extends Table {
  IntColumn get id => integer()();

  TextColumn get data => text().map(const HouseModelConverter())();

  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
