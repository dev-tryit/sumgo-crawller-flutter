import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';
import 'package:kdh_homepage/_common/util/SizeUtil.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends KDHState<MainPage> {
  double containerWidth = 1024;

  //makeWidgetListToGetSize->onLoad->build(realBuild)
  
  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() {
    return [
      WidgetToGetSize("maxContainer", maxContainerToGetSize)
    ];
  }

  @override
  Future<void> onLoad() async {
    LogUtil.debug("onLoad");
  }

  @override
  Widget realBuild(BuildContext context) {
    LogUtil.debug("realBuild");
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
        Container(color: Colors.brown, height: 43),
        AppComponents.text(
          fontSize: 52,
          text: "${Setting.appBuildNumber}, Fullstack Developer, 김동현입니다.",
        ),
        Container(color: Colors.yellow, height: 14),
        AppComponents.text(
          fontSize: 37,
          text: "플루터 웹, 앱을 제작합니다. 스타트업의 시작을 도와드리겠습니다.",
        ),
        Container(color: Colors.blue, height: 73),
        const Placeholder(strokeWidth: 1, fallbackHeight: 426),
        Container(color: Colors.red, height: 35),
      ],
    );
  }

  Widget mobile(Size screenSize) {
    return desktop(screenSize);
  }

}
