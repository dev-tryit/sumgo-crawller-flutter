import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';

class MainPage extends StatelessWidget {
  double containerWidth = 1024;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQueryUtil.getScreenSize(context);

    return screen(size);
  }

  Widget screen(Size screenSize) {
    LogUtil.info("screen size : $screenSize");

    if (screenSize.width > containerWidth) {
      return desktop();
    }
    return mobile();
  }

  Widget desktop() {
    return AppComponents.webPage(
      widgetList: [
        const Spacer(flex: 43),
        AppComponents.text(
          fontSize: 52,
          text: "${Setting.appBuildNumber}, Fullstack Developer, 김동현입니다.",
        ),
        const Spacer(flex: 14),
        AppComponents.text(
          fontSize: 39,
          text: "플루터 웹, 앱을 제작합니다. 스타트업의 시작을 도와드리겠습니다.",
        ),
        const Spacer(flex: 73),
        const Placeholder(strokeWidth: 1, fallbackHeight: 426),
        const Spacer(flex: 35),
      ],
    );
  }

  Widget mobile() {
    return desktop();
  }
}
