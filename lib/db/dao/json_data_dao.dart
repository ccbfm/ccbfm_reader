
import 'package:ccbfm_reader/db/dao/base_dao.dart';
import 'package:ccbfm_reader/db/entity/json_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class JsonDataDao extends BaseDao<JsonData>{
  static const String tableName = "json_data";

  @Query("SELECT * FROM $tableName WHERE json_type = :type")
  Future<List<JsonData>> findAllByType(int type);

  @Query('DELETE FROM $tableName')
  Future<void> deleteAll();
}

