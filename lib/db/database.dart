import 'dart:async';

import 'package:ccbfm_reader/db/DBHelper.dart';
import 'package:ccbfm_reader/db/dao/json_data_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entity/json_data.dart';

part 'database.g.dart';

/// 运行代码生成器
/// 使用 运行生成器
/// flutter packages pub run build_runner build。
/// 要在文件更改时自动运行它，请使用
/// flutter packages pub run build_runner watch.
///
@Database(version: DBConfig.dbVersion, entities: DBConfig.entities)
abstract class AppDatabase extends FloorDatabase {
  JsonDataDao get jsonDataDao;
}
