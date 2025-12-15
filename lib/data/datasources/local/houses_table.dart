import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:inn/data/models/house_model.dart';

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

class HousesTable extends Table {
  IntColumn get id => integer()();

  TextColumn get data => text().map(const HouseModelConverter())();

  TextColumn get category => text()();

  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
