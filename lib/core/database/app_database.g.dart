// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HousesTableTable extends HousesTable
    with TableInfo<$HousesTableTable, HousesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HousesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HouseModel, String> data =
      GeneratedColumn<String>(
        'data',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HouseModel>($HousesTableTable.$converterdata);
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, data, category, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'houses_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HousesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HousesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HousesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      data: $HousesTableTable.$converterdata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        )!,
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $HousesTableTable createAlias(String alias) {
    return $HousesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<HouseModel, String> $converterdata =
      const HouseModelConverter();
}

class HousesTableData extends DataClass implements Insertable<HousesTableData> {
  final int id;
  final HouseModel data;
  final String category;
  final DateTime fetchedAt;
  const HousesTableData({
    required this.id,
    required this.data,
    required this.category,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['data'] = Variable<String>(
        $HousesTableTable.$converterdata.toSql(data),
      );
    }
    map['category'] = Variable<String>(category);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  HousesTableCompanion toCompanion(bool nullToAbsent) {
    return HousesTableCompanion(
      id: Value(id),
      data: Value(data),
      category: Value(category),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory HousesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HousesTableData(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<HouseModel>(json['data']),
      category: serializer.fromJson<String>(json['category']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<HouseModel>(data),
      'category': serializer.toJson<String>(category),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  HousesTableData copyWith({
    int? id,
    HouseModel? data,
    String? category,
    DateTime? fetchedAt,
  }) => HousesTableData(
    id: id ?? this.id,
    data: data ?? this.data,
    category: category ?? this.category,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  HousesTableData copyWithCompanion(HousesTableCompanion data) {
    return HousesTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
      category: data.category.present ? data.category.value : this.category,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HousesTableData(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('category: $category, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data, category, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HousesTableData &&
          other.id == this.id &&
          other.data == this.data &&
          other.category == this.category &&
          other.fetchedAt == this.fetchedAt);
}

class HousesTableCompanion extends UpdateCompanion<HousesTableData> {
  final Value<int> id;
  final Value<HouseModel> data;
  final Value<String> category;
  final Value<DateTime> fetchedAt;
  const HousesTableCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.category = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  HousesTableCompanion.insert({
    this.id = const Value.absent(),
    required HouseModel data,
    required String category,
    this.fetchedAt = const Value.absent(),
  }) : data = Value(data),
       category = Value(category);
  static Insertable<HousesTableData> custom({
    Expression<int>? id,
    Expression<String>? data,
    Expression<String>? category,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (category != null) 'category': category,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  HousesTableCompanion copyWith({
    Value<int>? id,
    Value<HouseModel>? data,
    Value<String>? category,
    Value<DateTime>? fetchedAt,
  }) {
    return HousesTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      category: category ?? this.category,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $HousesTableTable.$converterdata.toSql(data.value),
      );
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HousesTableCompanion(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('category: $category, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $MyHousesTableTable extends MyHousesTable
    with TableInfo<$MyHousesTableTable, MyHousesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyHousesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HouseModel, String> data =
      GeneratedColumn<String>(
        'data',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HouseModel>($MyHousesTableTable.$converterdata);
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, data, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_houses_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyHousesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyHousesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyHousesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      data: $MyHousesTableTable.$converterdata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        )!,
      ),
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $MyHousesTableTable createAlias(String alias) {
    return $MyHousesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<HouseModel, String> $converterdata =
      const HouseModelConverter();
}

class MyHousesTableData extends DataClass
    implements Insertable<MyHousesTableData> {
  final int id;
  final HouseModel data;
  final DateTime fetchedAt;
  const MyHousesTableData({
    required this.id,
    required this.data,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['data'] = Variable<String>(
        $MyHousesTableTable.$converterdata.toSql(data),
      );
    }
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  MyHousesTableCompanion toCompanion(bool nullToAbsent) {
    return MyHousesTableCompanion(
      id: Value(id),
      data: Value(data),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory MyHousesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyHousesTableData(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<HouseModel>(json['data']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<HouseModel>(data),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  MyHousesTableData copyWith({
    int? id,
    HouseModel? data,
    DateTime? fetchedAt,
  }) => MyHousesTableData(
    id: id ?? this.id,
    data: data ?? this.data,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  MyHousesTableData copyWithCompanion(MyHousesTableCompanion data) {
    return MyHousesTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyHousesTableData(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyHousesTableData &&
          other.id == this.id &&
          other.data == this.data &&
          other.fetchedAt == this.fetchedAt);
}

class MyHousesTableCompanion extends UpdateCompanion<MyHousesTableData> {
  final Value<int> id;
  final Value<HouseModel> data;
  final Value<DateTime> fetchedAt;
  const MyHousesTableCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  MyHousesTableCompanion.insert({
    this.id = const Value.absent(),
    required HouseModel data,
    this.fetchedAt = const Value.absent(),
  }) : data = Value(data);
  static Insertable<MyHousesTableData> custom({
    Expression<int>? id,
    Expression<String>? data,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  MyHousesTableCompanion copyWith({
    Value<int>? id,
    Value<HouseModel>? data,
    Value<DateTime>? fetchedAt,
  }) {
    return MyHousesTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $MyHousesTableTable.$converterdata.toSql(data.value),
      );
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyHousesTableCompanion(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HousesTableTable housesTable = $HousesTableTable(this);
  late final $MyHousesTableTable myHousesTable = $MyHousesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    housesTable,
    myHousesTable,
  ];
}

typedef $$HousesTableTableCreateCompanionBuilder =
    HousesTableCompanion Function({
      Value<int> id,
      required HouseModel data,
      required String category,
      Value<DateTime> fetchedAt,
    });
typedef $$HousesTableTableUpdateCompanionBuilder =
    HousesTableCompanion Function({
      Value<int> id,
      Value<HouseModel> data,
      Value<String> category,
      Value<DateTime> fetchedAt,
    });

class $$HousesTableTableFilterComposer
    extends Composer<_$AppDatabase, $HousesTableTable> {
  $$HousesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HouseModel, HouseModel, String> get data =>
      $composableBuilder(
        column: $table.data,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HousesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HousesTableTable> {
  $$HousesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HousesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HousesTableTable> {
  $$HousesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HouseModel, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$HousesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HousesTableTable,
          HousesTableData,
          $$HousesTableTableFilterComposer,
          $$HousesTableTableOrderingComposer,
          $$HousesTableTableAnnotationComposer,
          $$HousesTableTableCreateCompanionBuilder,
          $$HousesTableTableUpdateCompanionBuilder,
          (
            HousesTableData,
            BaseReferences<_$AppDatabase, $HousesTableTable, HousesTableData>,
          ),
          HousesTableData,
          PrefetchHooks Function()
        > {
  $$HousesTableTableTableManager(_$AppDatabase db, $HousesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HousesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HousesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HousesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<HouseModel> data = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => HousesTableCompanion(
                id: id,
                data: data,
                category: category,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required HouseModel data,
                required String category,
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => HousesTableCompanion.insert(
                id: id,
                data: data,
                category: category,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HousesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HousesTableTable,
      HousesTableData,
      $$HousesTableTableFilterComposer,
      $$HousesTableTableOrderingComposer,
      $$HousesTableTableAnnotationComposer,
      $$HousesTableTableCreateCompanionBuilder,
      $$HousesTableTableUpdateCompanionBuilder,
      (
        HousesTableData,
        BaseReferences<_$AppDatabase, $HousesTableTable, HousesTableData>,
      ),
      HousesTableData,
      PrefetchHooks Function()
    >;
typedef $$MyHousesTableTableCreateCompanionBuilder =
    MyHousesTableCompanion Function({
      Value<int> id,
      required HouseModel data,
      Value<DateTime> fetchedAt,
    });
typedef $$MyHousesTableTableUpdateCompanionBuilder =
    MyHousesTableCompanion Function({
      Value<int> id,
      Value<HouseModel> data,
      Value<DateTime> fetchedAt,
    });

class $$MyHousesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MyHousesTableTable> {
  $$MyHousesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HouseModel, HouseModel, String> get data =>
      $composableBuilder(
        column: $table.data,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MyHousesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MyHousesTableTable> {
  $$MyHousesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MyHousesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MyHousesTableTable> {
  $$MyHousesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HouseModel, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$MyHousesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MyHousesTableTable,
          MyHousesTableData,
          $$MyHousesTableTableFilterComposer,
          $$MyHousesTableTableOrderingComposer,
          $$MyHousesTableTableAnnotationComposer,
          $$MyHousesTableTableCreateCompanionBuilder,
          $$MyHousesTableTableUpdateCompanionBuilder,
          (
            MyHousesTableData,
            BaseReferences<
              _$AppDatabase,
              $MyHousesTableTable,
              MyHousesTableData
            >,
          ),
          MyHousesTableData,
          PrefetchHooks Function()
        > {
  $$MyHousesTableTableTableManager(_$AppDatabase db, $MyHousesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MyHousesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MyHousesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MyHousesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<HouseModel> data = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => MyHousesTableCompanion(
                id: id,
                data: data,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required HouseModel data,
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => MyHousesTableCompanion.insert(
                id: id,
                data: data,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MyHousesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MyHousesTableTable,
      MyHousesTableData,
      $$MyHousesTableTableFilterComposer,
      $$MyHousesTableTableOrderingComposer,
      $$MyHousesTableTableAnnotationComposer,
      $$MyHousesTableTableCreateCompanionBuilder,
      $$MyHousesTableTableUpdateCompanionBuilder,
      (
        MyHousesTableData,
        BaseReferences<_$AppDatabase, $MyHousesTableTable, MyHousesTableData>,
      ),
      MyHousesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HousesTableTableTableManager get housesTable =>
      $$HousesTableTableTableManager(_db, _db.housesTable);
  $$MyHousesTableTableTableManager get myHousesTable =>
      $$MyHousesTableTableTableManager(_db, _db.myHousesTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'8c69eb46d45206533c176c88a926608e79ca927d';
