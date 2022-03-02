//

import 'package:ccbfm_reader/db/database.dart';
import 'package:ccbfm_reader/db/entity/json_data.dart';

class DBConfig {
  static const String dbName = "ccbfm_reader.db";
  static const int dbVersion = 1;
  static const List<Type> entities = [JsonData];
}

class DBHelper {
  late final Future<AppDatabase> _database;

  DBHelper._internal() {
    _database = build();
  }

  factory DBHelper() => _instance;

  static final DBHelper _instance = DBHelper._internal();

  Future<AppDatabase> build() async {
    return await $FloorAppDatabase.databaseBuilder(DBConfig.dbName).build();
  }

  Future get initializationDone => _database;

  static Future<AppDatabase> db() async {
    DBHelper dbHelper = DBHelper();
    await dbHelper.initializationDone;
    return dbHelper._database;
  }
}
