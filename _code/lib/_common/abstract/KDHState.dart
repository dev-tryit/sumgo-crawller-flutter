import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';

abstract class KDHState<T extends StatefulWidget> extends State<T> {
  List<WidgetToGetSize> widgetListToGetSize = [];

  Widget Function(BuildContext context)? lazyBuild; //lazyBuild가 채워지면 준비된거다.
  late Size screenSize;

  //호출순서 : super.initState->super.build->super.afterBuild->super.prepareRealBuild
  //                                                       ->onLoad->build(realBuild)
  
  @override
  void initState() {
    LogUtil.debug("super.initState");
    super.initState();

    widgetListToGetSize = makeWidgetListToGetSize();

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

    return lazyBuild != null
        ? lazyBuild!(context)
        : Stack(
            children: [
              ...(widgetListToGetSize.map((w) => w.makeWidget())),
              AppComponents.loadingWidget(),
            ],
          );
  }

  Future<void> afterBuild() async {
    LogUtil.debug("super.afterBuild");
    await prepareRealBuild();
  }

  Future<void> prepareRealBuild() async {
    LogUtil.debug("super.prepareRealBuild");

    getSizeOfWidgetList();

    await onLoad();

    lazyBuild = realBuild;
    if (lazyBuild != null) {
      setState(() {});
    }
  }

  Future<void> onLoad();

  Widget realBuild(BuildContext context);

  Widget maxContainerToGetSize(GlobalKey key) {
    return Container(
      key: key,
      color: Colors.black,
    );
  }

  void getSizeOfWidgetList() {
    widgetListToGetSize.forEach((w) {
      w.calculateSize();
    });
  }
}
