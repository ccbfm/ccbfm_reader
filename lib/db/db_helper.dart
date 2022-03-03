//

import 'package:ccbfm_reader/db/database.dart';
import 'package:ccbfm_reader/db/entity/json_data.dart';
import 'package:ccbfm_reader/util/log_utils.dart';

class DBConfig {
  static const String dbName = "ccbfm_reader.db";
  static const int dbVersion = 1;
  static const List<Type> entities = [JsonData];
}

class DBHelper {
  static const String _tag = "DBHelper";
  static const bool _out = false;

  late final Future<AppDatabase> _database;

  DBHelper._internal() {
    _database = build();
  }

  factory DBHelper() => _instance;

  static final DBHelper _instance = DBHelper._internal();

  Future<AppDatabase> build() async {
    return await $FloorAppDatabase.databaseBuilder(DBConfig.dbName).build();
  }

  Future<AppDatabase> get initializationDone => _database;

  static Future<AppDatabase> db() async {
    DBHelper dbHelper = DBHelper();
    LogUtils.v(_out, _tag, "db-dbHelper=${dbHelper.hashCode}");
    LogUtils.v(_out, _tag, "db-dbHelper-_database-1=${dbHelper._database.hashCode}");
    await dbHelper.initializationDone;
    LogUtils.v(_out, _tag, "db-dbHelper-_database-2=${dbHelper._database.hashCode}");
    return dbHelper._database;
  }
}
