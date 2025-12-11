import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:inn/data/models/house_model.dart';

// 1. The Converter
// This tells Drift how to store our complex HouseModel object as a simple String
class HouseModelConverter extends TypeConverter<HouseModel, String> {
  const HouseModelConverter();

  @override
  HouseModel fromSql(String fromDb) {
    return HouseModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(HouseModel value) {
    return json.encode(value.toJson());
  }
}

// 2. The Table
class HousesTable extends Table {
  // We use the ID from the server as the primary key
  IntColumn get id => integer()();
  
  // We store the whole object as a JSON string using the converter
  TextColumn get data => text().map(const HouseModelConverter())();
  
  // We store the 'category' separately just in case you want to filter by category locally later
  TextColumn get category => text()();
  
  // Useful for ordering
  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}