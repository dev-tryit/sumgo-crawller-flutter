import 'package:logger/logger.dart';

class Setting {
  // DateTime
  static const int timeZoneOffset = 9;

  // App
  static const String appName = "TRY_IT";

  // Log
  static const Level LogLevel = Level.info;
  static bool showLog = true;

  //Firebase
  static const String firebaseApiKey = "AIzaSyC1LzWmL9H4z1r4SyBewiLyzWbEvBjVBtw";

  // 중복 클릭 방지 시간
  static int milliSecondsForPreventingMultipleClicks = 300;

// static String appVersion = "";
//
// static String appBuildNumber = "";
}
