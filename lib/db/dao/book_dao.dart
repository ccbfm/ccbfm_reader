
import 'package:ccbfm_reader/db/dao/base_dao.dart';
import 'package:ccbfm_reader/db/entity/book.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookDao extends BaseDao<Book>{
  static const String tableName = "book";

  @Query("SELECT * FROM $tableName")
  Future<List<Book>> findAll();

  @Query("SELECT * FROM $tableName WHERE type = :type")
  Future<List<Book>> findAllByType(int type);

  @Query('DELETE FROM $tableName')
  Future<void> deleteAll();
}

