import 'package:drift/drift.dart';

class FavoritesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  // We reference the house ID.
  // In a more complex app, we might enforce foreign key, but here just storing ID is fine
  // provided we ensure we save the house data in HousesTable.
  IntColumn get houseId => integer().unique()();

  // The ID returned by the API for this favorite entry.
  // Nullable because a locally-created favorite might not have sunk yet.
  IntColumn get apiFavoriteId => integer().nullable()();

  // Whether this favorite is synced with the backend.
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
