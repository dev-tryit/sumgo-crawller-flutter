import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/TValue.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/page/resume/MyMenu.dart';
import 'package:kdh_homepage/_common/widget/Menu.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/_common/util/ImageUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:unsplash_client/unsplash_client.dart';

enum W {
  maxContainer,
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends KDHState<MainPage> with TickerProviderStateMixin {
  final double maxMobileSize = 1024;
  late final Size maxSize;
  late final MainPageComponent component;

  //screenSize, w, widgetToBuild를 잘 사용해야 한다.
  //makeWidgetListToGetSize->onLoad->mustRebuild->super.build

  @override
  void initState() {
    component = MainPageComponent(this);

    super.initState();
  }

  @override
  bool isPage() {
    return true;
  }

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() {
    return [
      WidgetToGetSize(
        W.maxContainer,
        (key) => Container(
          key: key,
          color: Colors.transparent,
        ),
      ),
    ];
  }

  @override
  Future<void> onLoad() async {
    LogUtil.info("${Setting.appBuildNumber} 빌드 버전");
    maxSize = widgetMap[W.maxContainer]!.size;
  }

  @override
  void mustRebuild() {
    widgetToBuild = () {
      if (screenSize.width > maxMobileSize) {
        return desktop(screenSize);
      }
      return mobile(screenSize);
    };
    rebuild();
  }

  Widget desktop(Size screenSize) {
    return MyComponents.scaffold(
      body: Row(
        children: [
          Container(
            color: MyColors.black,
            width: 91,
            child: component.leftMenu(),
          ),
          Container(
            color: MyColors.gray,
            width: 404,
            child: component.desktopProfile(),
          ),
          Expanded(
            child: component.content(),
          ),
        ],
      ),
      // screenSize: screenSize,
      // widgetList: [
      //   Container(
      //     width: double.infinity,
      //     alignment: Alignment.center,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         widgetMap[W.space1]!.make(),
      //         widgetMap[W.headerText1]!.make(),
      //         widgetMap[W.space2]!.make(),
      //         widgetMap[W.headerText2]!.make(),
      //       ],
      //     ),
      //   ),
      //   SizedBox(height: sizableHeight),
      //   widgetMap[W.mainListView]!.make(),
      //   widgetMap[W.space3]!.make(),
      // ],
    );
  }

  Widget mobile(Size screenSize) {
    return MyComponents.scaffold(
      body: SizedBox.expand(child: component.content()),
    );
  }
}

enum PageEnum { mainPage, profilePage }

class MainPageComponent {
  static const selectedColor = MyColors.lightBlue;
  static const unselectedColor = MyColors.ligthGray;
  final pageController = PageController();
  final _MainPageState state;
  final TabController tabController;
  final itemList = [
    MyMenuItem("", "트라잇",
        selectedColor: selectedColor, unselectedColor: unselectedColor),
    MyMenuItem("", "소개",
        selectedColor: selectedColor, unselectedColor: unselectedColor),
    MyMenuItem("", "이력서",
        selectedColor: selectedColor, unselectedColor: unselectedColor),
    MyMenuItem("", "포트폴리오",
        selectedColor: selectedColor, unselectedColor: unselectedColor),
    MyMenuItem("", "연락하기",
        selectedColor: selectedColor, unselectedColor: unselectedColor),
  ];

  MainPageComponent(this.state)
      : tabController = TabController(length: 3, vsync: state);

  Map<PageEnum, Widget> pages = {
    PageEnum.mainPage: Container(
      color: MyColors.black,
      child: Column(
        children: const [
          Text("MainPage"),
        ],
      ),
    ),
    PageEnum.profilePage: Container(
      color: MyColors.black,
      child: Column(
        children: const [
          Text("ProfilePage"),
        ],
      ),
    ),
  };

  Widget leftMenu() {
    return Menu<MyMenuItem>(
      itemList: itemList,
      itemWidgetBuilder: (item) => MyMenu(item),
      menuWidgetBuilder: (itemWidgetList) {
        return Padding(
          padding: const EdgeInsets.only(top: 13.0),
          child: Column(children: itemWidgetList),
        );
      },
    );
  }

  Widget desktopProfile() {
    return Column(
      children: const [],
    );
  }

  Widget content() {
    // Timer(Duration(seconds: 2), () {
    //   pageController.animateToPage(
    //     1,
    //     duration: Duration(seconds: 1),
    //     curve: Curves.ease,
    //   );
    // });
    return PageView(
      controller: pageController,
      children: pages.values.toList(),
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
