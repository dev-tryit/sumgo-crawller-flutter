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

  //화면을 바꿀 수 있을 때 사용, 주의!!! dispose가 마음대로 불릴 수 있음.
  //호출순서 : super.initState->super.build->super.afterBuild->super.prepareRebuild
  //                                                       ->onLoad->mustRebuild->super.build

  bool isPage();

  void rebuild() {
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
}
