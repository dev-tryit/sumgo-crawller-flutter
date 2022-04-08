import 'dart:ui';

import 'package:logger/logger.dart';

class Setting {
  static const bool isRelease = true;

  //Lang
  static const Locale defaultLocale = Locale('ko', 'kr');

  // DateTime
  static const int timeZoneOffset = 9;

  // App
  static const String appName = "TRY_IT";

  // 중복 클릭 방지 시간
  static int milliSecondsForPreventingMultipleClicks = 300;

// static String appVersion = "";
//
// static String appBuildNumber = "";
}
