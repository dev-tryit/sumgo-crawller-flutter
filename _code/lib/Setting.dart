import 'package:logger/logger.dart';

class Setting {
  // App
  static const String appName = "KDH_HOMEPAGE";

  // Log
  static const Level LogLevel = Level.verbose;
  static bool showLog = true;

  // 중복 클릭 방지 시간
  static int milliSecondsForPreventingMultipleClicks = 300;
}