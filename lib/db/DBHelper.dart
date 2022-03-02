
//

import 'package:ccbfm_reader/db/database.dart';
import 'package:ccbfm_reader/db/entity/json_data.dart';

class DBConfig {
  static const String dbName = "ccbfm_reader.db";
  static const int dbVersion = 1;
  static const List<Type> entities = [JsonData];
}

class DBHelper {

  static Future<AppDatabase> build() async {
    return await $FloorAppDatabase.databaseBuilder(DBConfig.dbName).build();
  }
}
