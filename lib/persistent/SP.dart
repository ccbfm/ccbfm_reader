
import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static Future<String?> getString(key) async {
    return getStringHasDefault(key, null);
  }

  static Future<String> getStringHasDefault(key, defValue) async {
    final prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    if(result == null){
      return defValue;
    }
    return result;
  }

  static Future<bool> setString(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}
