

import 'package:floor/floor.dart';

abstract class BaseDao<T> {

  @insert
  Future<List<int>> insertDataList(List<T> dataList);

  @insert
  Future<int> insertData(T data);

  @update
  Future<int> updateData(T data);

  @delete
  Future<int> deleteData(T data);

}