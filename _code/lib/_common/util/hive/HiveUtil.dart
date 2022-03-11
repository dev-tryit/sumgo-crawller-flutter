import 'dart:io';

import 'package:hive/hive.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartStore.dart';

class HiveUtil {
  static Future<void> init() async {
    var path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter(TokenAdapter()); //FiredartAuthUtil를 위해서 Adapter 추가.
  }
}
