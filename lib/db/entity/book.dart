import 'package:ccbfm_reader/util/md5.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "book")
class Book {
  @PrimaryKey()
  @ColumnInfo(name: "key")
  final String key;

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

  Book(this.key, this.name, this.path, this.type);

  @ignore
  static Book createBook(String name, String path) {
    return Book(Md5.generateMd5(path), name, path, BookType.getType(name));
  }

  @override
  String toString() {
    return 'Book{name: $name, path: $path}';
  }
}

class BookType {
  static const int unknown = 0;
  static const int txt = 1;

  static int getType(String name) {
    if (name.contains(".txt")) {
      return txt;
    }
    return unknown;
  }
}
