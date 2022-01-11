import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';

class MainPage extends StatelessWidget {
  double containerWidth = 1024;

  @override
  Widget build(BuildContext context) {
    LogUtil.info("app buildNumber : ${Setting.appBuildNumber}");

    Size screenSize = MediaQueryUtil.getScreenSize(context);
    LogUtil.info("screen size : $screenSize");

    if (screenSize.width > containerWidth) {
      return desktop(screenSize);
    }
    return mobile(screenSize);
  }

  Widget desktop(Size screenSize) {
    return AppComponents.webPage(
      screenSize: screenSize,
      containerWidth: containerWidth,
      widgetList: [
        const Spacer(flex: 43),
        AppComponents.text(
          fontSize: 52,
          text: "${Setting.appBuildNumber}, Fullstack Developer, 김동현입니다.",
        ),
        const Spacer(flex: 14),
      ],
    );
  }

  Widget mobile(Size screenSize) {
    return desktop(screenSize);
  }
}
