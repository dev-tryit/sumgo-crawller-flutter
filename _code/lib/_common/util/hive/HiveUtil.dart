
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartAuthSingleton.dart';

class HiveUtil {
  static Future<void> init() async {
    Hive.initFlutter();
    if(PlatformUtil.isComputer()) {
      Hive.registerAdapter(TokenAdapter()); //FiredartAuthUtil를 위해서 Adapter 추가.
    }
  }
}
