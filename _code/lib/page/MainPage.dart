import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';

enum MainPageWidget {
  maxContainer,
  headerText1,
  headerText2,
  mainListView,
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends KDHState<MainPage> {
  late Size maxSize;
  double containerWidth = 1024;

  //screenSize, w, widgetToBuild를 잘 사용해야 한다.
  //makeWidgetListToGetSize->onLoad->mustRebuild->super.build

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() {
    return [
      WidgetToGetSize(
        MainPageWidget.maxContainer,
        (key) => Container(
          key: key,
          color: Colors.transparent,
        ),
      ),
      WidgetToGetSize(
        MainPageWidget.headerText1,
        (key) => AppComponents.text(
          key: key,
          fontSize: 52,
          text: "${Setting.appBuildNumber}, Fullstack Developer, 김동현입니다.",
        ),
      ),
      WidgetToGetSize(
        MainPageWidget.headerText2,
        (key) => AppComponents.text(
          key: key,
          fontSize: 37,
          text: "플루터 웹, 앱을 제작합니다. 스타트업의 시작을 도와드리겠습니다.",
        ),
      ),
      WidgetToGetSize(
        MainPageWidget.mainListView,
        (key) => Container(
          color: Colors.amberAccent,
          height: 426,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Image.network('https://picsum.photos/250?image=9'),
              Image.network('https://picsum.photos/250?image=9'),
              Image.network('https://picsum.photos/250?image=9'),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Future<void> onLoad() async {
    LogUtil.debug("onLoad");
    maxSize = w[MainPageWidget.maxContainer]!.size;
  }

  @override
  void mustRebuild(BuildContext context) {
    LogUtil.debug("mustRebuild");

    widgetToBuild = () {
      if (screenSize.width > containerWidth) {
        return desktop(screenSize);
      }
      return mobile(screenSize);
    };
    rebuild();
  }

  Widget desktop(Size screenSize) {
    double sizableHeight = -1 +
        w[MainPageWidget.maxContainer]!.height -
        (43 +
            14 +
            200 +
            426 +
            w["MainPageWidget.headerText1"]!.height +
            w["MainPageWidget.headerText2"]!.height +
            w["MainPageWidget.MainPageWidget.listView"]!.height);

    return AppComponents.webPage(
      screenSize: screenSize,
      containerWidth: containerWidth,
      widgetList: [
        const SizedBox(height: 43),
        w["MainPageWidget.headerText1"]!.makeWidget(),
        const SizedBox(height: 14),
        w["MainPageWidget.headerText2"]!.makeWidget(),
        Container(color: Colors.blue, height: sizableHeight),
        w["MainPageWidget.MainPageWidget.listView"]!.makeWidget(),
        const SizedBox(height: 200),
      ],
    );
  }

  Widget mobile(Size screenSize) {
    return desktop(screenSize);
  }
}
