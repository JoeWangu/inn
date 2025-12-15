import 'package:drift/drift.dart';

class FavoritesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get houseId => integer().unique()();

  IntColumn get apiFavoriteId => integer().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
