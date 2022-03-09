
import 'package:floor/floor.dart';

@Entity(tableName: "book")
class Book {
  @PrimaryKey()
  @ColumnInfo(name: "name")
  final String name;

  @ColumnInfo(name: "path")
  final String path;

  @ColumnInfo(name: "create_time")
  final int createTime = DateTime.now().millisecondsSinceEpoch;

  @ColumnInfo(name: "last_time")
  final int lastTime = DateTime.now().millisecondsSinceEpoch;

  @ColumnInfo(name: "type")
  final int type;

  Book(this.name, this.path, this.type);

}

class BookType {
  static const int unknown = 0;
  static const int txt = 1;

  static int getType(String name){
    if(name.contains(".txt")){
      return txt;
    }
    return unknown;
  }
}