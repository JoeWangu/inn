import 'package:drift/drift.dart';

class UserProfileTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jsonData => text()();
  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();
}
