

import 'package:floor/floor.dart';

abstract class BaseDao<T> {

  @Insert()
  Future<List<int>> insertDataList(List<T> dataList);

  @Insert()
  Future<int> insertData(T data);

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<int> insertDataRF(T data);

  @update
  Future<int> updateData(T data);

  @delete
  Future<int> deleteData(T data);

}