import 'package:flutter/foundation.dart';

class LogUtils {
  static void d(Object? object) {
    v(true, "", object);
  }

  static void dt(String tag, Object? object) {
    v(true, tag, object);
  }

  static void v(bool out, String tag, Object? object) {
    if (!out) {
      return;
    }
    if (kDebugMode) {
      if (tag.isEmpty) {
        print(object);
      } else {
        print("$tag>>>$object");
      }
    }
  }
}
