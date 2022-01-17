import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';
import 'package:kdh_homepage/util/SizeUtil.dart';

class WidgetToGetSize {
  Widget widget;
  GlobalKey key = GlobalKey();
  Size? size;

  WidgetToGetSize(this.widget);

  void calculateSize() {
    size = SizeUtil.getSizeByKey(key);
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<WidgetToGetSize> widgetListToGetSize;

  Widget Function(BuildContext context)? lazyBuild; //lazyBuild가 채워지면 준비된거다.
  double containerWidth = 1024;
  late Size screenSize;

  //호출순서 : initState->build->afterBuild->onPrepare->build
  @override
  void initState() {
    print("initState");
    super.initState();

    widgetListToGetSize =
        [maxContainerToGetSize()].map((e) => WidgetToGetSize(e)).toList();

    Future(afterBuild);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    screenSize = MediaQueryUtil.getScreenSize(context);

    return lazyBuild != null
        ? lazyBuild!(context)
        : Stack(
            children: [
              ...(widgetListToGetSize.map((e) => e.widget)),
              AppComponents.loadingWidget(),
            ],
          );
  }

  Future<void> afterBuild() async {
    print("afterBuild");
    await prepareRealBuild();
  }

  Future<void> prepareRealBuild() async {
    print("prepareRealBuild");

    getSizeOfWidgetList();

    lazyBuild = realBuild;
    if (lazyBuild != null) {
      setState(() {});
    }
  }

  Widget realBuild(BuildContext context) {
    print("realBuild");
    if (screenSize.width > containerWidth) {
      return desktop(screenSize);
    }
    return mobile(screenSize);
  }

  Widget desktop(Size screenSize) {
    return AppComponents.webPage(
      screenSize: screenSize,
      containerWidth: 1024,
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

  final maxContainerKey = GlobalKey();
  Widget maxContainerToGetSize() {
    return Container(
      key: maxContainerKey,
      color: Colors.black,
    );
  }

  void getSizeOfWidgetList() {
    widgetListToGetSize.forEach((element) {
      element.calculateSize();
    });
  }
}
