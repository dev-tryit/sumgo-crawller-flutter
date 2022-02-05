import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
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
  int _selectedIndex = 0;
  final pageController = PageController();
  final _MainPageState state;
  final TabController tabController;

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
    return Column(
      children: const [
        const SizedBox(height: 13),
        const EachMenu("", "트라잇"),
        const EachMenu("", "소개"),
        const EachMenu("", "이력서"),
        const EachMenu("", "포트폴리오"),
        const EachMenu("", "연락하기"),
      ],
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

class EachMenu extends StatefulWidget {
  final String iconPath;
  final String label;
  const EachMenu(this.iconPath, this.label, {Key? key}) : super(key: key);

  @override
  _EachMenuState createState() => _EachMenuState();
}

class _EachMenuState extends State<EachMenu> {
  Color eachMenuIconColor = MyColors.ligthGray;
  @override
  Widget build(BuildContext context) {
    Widget returnWidget = Container(
      width: 91,
      height: 91,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyColors.white, width: 0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: eachMenuIconColor,
              backgroundImage: AssetImage(widget.iconPath),
            ),
          ),
          SizedBox(height: 7),
          MyComponents.text(
              text: widget.label, fontSize: 12, color: MyColors.white),
        ],
      ),
    );

    returnWidget = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: returnWidget,
      onHover: (event) {
        eachMenuIconColor = MyColors.lightBlue;
        rebuild();
      },
      onExit: (event) {
        eachMenuIconColor = MyColors.ligthGray;
        rebuild();
      },
    );

    return returnWidget;
  }

  void rebuild() {
    setState(() {});
  }
}
