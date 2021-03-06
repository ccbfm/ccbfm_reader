
import 'package:floor/floor.dart';

@Entity(tableName: "json_data")
class JsonData{
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: "json_type")
  final int type;

  @ColumnInfo(name: "json_string")
  final String jsonString;

  JsonData(this.type, this.jsonString, {this.id});
}

class JsonDataType {
  static const int book = 1;
}