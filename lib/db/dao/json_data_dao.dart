
import 'package:ccbfm_reader/db/entity/json_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class JsonDataDao {
  static const String tableName = "json_data";

  @Query("SELECT * FROM $tableName WHERE json_type = :type")
  Future<List<JsonData>> findAllByType(int type);

  @insert
  Future<List<int>> insertDataList(List<JsonData> dataList);

  @insert
  Future<int> insertData(JsonData data);

  @update
  Future<int> updateData(JsonData data);

  @delete
  Future<int> deleteData(JsonData data);

  @Query('DELETE FROM $tableName')
  Future<void> deleteAllData();
}