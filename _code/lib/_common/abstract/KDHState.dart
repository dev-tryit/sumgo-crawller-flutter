import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';

abstract class KDHState<T extends StatefulWidget> extends State<T> {
  List<WidgetToGetSize> _widgetListToGetSize = [];
  Map<String, WidgetToGetSize> w = {};

  Widget Function()? widgetToBuild;
  late Size screenSize;

  //호출순서 : super.initState->super.build->super.afterBuild->super.prepareRebuild
  //                                                       ->onLoad->mustRebuild->super.build

  void rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    LogUtil.debug("super.initState");
    super.initState();

    _widgetListToGetSize = makeWidgetListToGetSize();

    Future(afterBuild);
  }

  /*
  [
    WidgetToGetSize("maxContainer", maxContainerToGetSize)
  ];
  */
  List<WidgetToGetSize> makeWidgetListToGetSize();

  @override
  Widget build(BuildContext context) {
    LogUtil.debug("super.build");
    screenSize = MediaQueryUtil.getScreenSize(context);

    return widgetToBuild != null
        ? widgetToBuild!()
        : Scaffold(
            body: Stack(
              children: [
                ...(_widgetListToGetSize.map((w) => Opacity(
                      opacity: 0,
                      child: w.makeWidget(),
                    ))),
                AppComponents.loadingWidget(),
              ],
            ),
          );
  }

  Future<void> afterBuild() async {
    LogUtil.debug("super.afterBuild");
    await prepareRebuild();
  }

  Future<void> prepareRebuild() async {
    LogUtil.debug("super.prepareRebuild");

    getSizeOfWidgetList();

    await onLoad();

    mustRebuild(context);
  }

  Future<void> onLoad();

  void mustRebuild(BuildContext context);

  void getSizeOfWidgetList() {
    w.clear();
    for (var e in _widgetListToGetSize) {
      e.calculateSize();
      w[e.label] = e;
    }
  }
}
