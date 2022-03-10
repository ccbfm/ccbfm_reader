import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class Md5 {
  // md5 加密
  static const Utf8Encoder _utf8encoder = Utf8Encoder();
  static String generateMd5(String data) {
    var content = _utf8encoder.convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}