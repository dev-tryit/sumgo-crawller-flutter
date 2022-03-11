import 'dart:io';

import 'package:hive/hive.dart';

class HiveUtil {
  static Future<void> init() async {
    var path = Directory.current.path;
    Hive
      ..init(path);
      // ..registerAdapter(PersonAdapter());
  }
}
