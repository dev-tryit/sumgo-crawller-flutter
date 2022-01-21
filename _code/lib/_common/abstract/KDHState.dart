import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';

abstract class KDHState<T extends StatefulWidget> extends State<T> {
  bool whenBuildCalledFirst = true;
  List<WidgetToGetSize> _widgetListToGetSize = [];
  Map<dynamic, WidgetToGetSize> w = {};

  Widget Function()? widgetToBuild;
  late Size screenSize;

  //호출순서 : super.initState->super.build->super.afterBuild->super.prepareRebuild
  //                                                       ->onLoad->mustRebuild->super.build

  bool isPage();

  void rebuild() {
    //Flutter는 중간에 state를 제거해놓기도 한다. 추후에 build로 다시 생성하지만..
    //이 때, setState가 불리면, 에러가 발생한다. 따라서, mounted 여부 체크가 필요하다.
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    // LogUtil.debug("super.initState");
    super.initState();

    _widgetListToGetSize = makeWidgetListToGetSize();
  }

  /*
  [
    WidgetToGetSize("maxContainer", maxContainerToGetSize)
  ];
  */
  List<WidgetToGetSize> makeWidgetListToGetSize();

  @override
  Widget build(BuildContext context) {
    // LogUtil.debug("super.build");
    screenSize = MediaQueryUtil.getScreenSize(context);

    if (whenBuildCalledFirst) {
      whenBuildCalledFirst = false;
      Future(() async {
        await afterBuild();
      });
    }

    bool existWidgetToBuild = widgetToBuild != null;
    if (existWidgetToBuild) {
      return widgetToBuild!();
    }

    Widget returnWidget = Stack(
      children: [
        ...(_widgetListToGetSize.isNotEmpty
            ? _widgetListToGetSize.map((w) => Opacity(
                  opacity: 0,
                  child: w.makeWidget(),
                ))
            : []),
        AppComponents.loadingWidget(),
      ],
    );

    if (isPage()) {
      returnWidget = Scaffold(
        body: returnWidget,
      );
    }

    return returnWidget;
  }

  Future<void> afterBuild() async {
    // LogUtil.debug("super.afterBuild");
    await prepareRebuild();
  }

  Future<void> prepareRebuild() async {
    // LogUtil.debug("super.prepareRebuild");

    getSizeOfWidgetList();

    await onLoad();

    mustRebuild();
  }

  Future<void> onLoad();

  void mustRebuild();

  void getSizeOfWidgetList() {
    w.clear();
    for (var e in _widgetListToGetSize) {
      e.calculateSize();
      w[e.key] = e;
    }
  }

  @override
  void dispose() {
    // LogUtil.debug("super.dispose");
    super.dispose();
  }
}
