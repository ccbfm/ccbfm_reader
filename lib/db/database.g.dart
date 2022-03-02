// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  JsonDataDao? _jsonDataDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `json_data` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `json_type` INTEGER NOT NULL, `json_string` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  JsonDataDao get jsonDataDao {
    return _jsonDataDaoInstance ??= _$JsonDataDao(database, changeListener);
  }
}

class _$JsonDataDao extends JsonDataDao {
  _$JsonDataDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _jsonDataInsertionAdapter = InsertionAdapter(
            database,
            'json_data',
            (JsonData item) => <String, Object?>{
                  'id': item.id,
                  'json_type': item.type,
                  'json_string': item.jsonString
                }),
        _jsonDataUpdateAdapter = UpdateAdapter(
            database,
            'json_data',
            ['id'],
            (JsonData item) => <String, Object?>{
                  'id': item.id,
                  'json_type': item.type,
                  'json_string': item.jsonString
                }),
        _jsonDataDeletionAdapter = DeletionAdapter(
            database,
            'json_data',
            ['id'],
            (JsonData item) => <String, Object?>{
                  'id': item.id,
                  'json_type': item.type,
                  'json_string': item.jsonString
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<JsonData> _jsonDataInsertionAdapter;

  final UpdateAdapter<JsonData> _jsonDataUpdateAdapter;

  final DeletionAdapter<JsonData> _jsonDataDeletionAdapter;

  @override
  Future<List<JsonData>> findAllByType(int type) async {
    return _queryAdapter.queryList(
        'SELECT * FROM json_data WHERE json_type = ?1',
        mapper: (Map<String, Object?> row) => JsonData(row['id'] as int?,
            row['json_type'] as int, row['json_string'] as String),
        arguments: [type]);
  }

  @override
  Future<void> deleteAllData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM json_data');
  }

  @override
  Future<List<int>> insertDataList(List<JsonData> dataList) {
    return _jsonDataInsertionAdapter.insertListAndReturnIds(
        dataList, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertData(JsonData data) {
    return _jsonDataInsertionAdapter.insertAndReturnId(
        data, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateData(JsonData data) {
    return _jsonDataUpdateAdapter.updateAndReturnChangedRows(
        data, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteData(JsonData data) {
    return _jsonDataDeletionAdapter.deleteAndReturnChangedRows(data);
  }
}
