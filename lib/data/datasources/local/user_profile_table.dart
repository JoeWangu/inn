import 'package:drift/drift.dart';

// Table to store the user profile. We'll store it as a single row.
// Since the model is complex (nested objects), storing as JSON text is the most robust simple strategy
// without creating 5 different tables.
class UserProfileTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jsonData => text()();
  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();
}

// Converter to handle JSON serialization automatically if we wanted (optional)
// But for now, we can just read/write string in DAO.
