import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/page/main/KeywordAnalysisPage.dart';
import 'package:kdh_homepage/page/main/RequestRemovalPage.dart';
import 'package:kdh_homepage/util/MyImage.dart';
import 'package:kdh_homepage/widget/MyHeader.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends KDHState<MainLayout> {
  late final MainLayoutComponent c;

  @override
  bool isPage() {
    return true;
  }

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() {
    return [];
  }

  @override
  Future<void> onLoad() async {
    c = MainLayoutComponent(this);

    List<Future> loadList = [];
    loadList.add(precacheImage(MyImage.backgroundTop, context));
    loadList.add(precacheImage(MyImage.boxIcon, context));
    loadList.add(precacheImage(MyImage.plusIcon, context));
    loadList.add(precacheImage(MyImage.minusIcon, context));

    await Future.wait(loadList);
  }

  @override
  void mustRebuild() {
    widgetToBuild =
        () => Scaffold(body: c.body());
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}
}

class MainLayoutComponent {
  final PageController pageC;
  final _MainLayoutState _state;

  MainLayoutComponent(this._state) : pageC = PageController();

  Widget body() {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(top: 150, bottom: 0, left: 0, right: 0, child:content()),
          MyHeader(pageC),
        ],
      ),
    );
  }

  Widget content() {
    return PageView(
      controller: pageC,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        KeywordAnalysisPage(),
        RequestRemovalPage(),
      ],
    );
  }
}
