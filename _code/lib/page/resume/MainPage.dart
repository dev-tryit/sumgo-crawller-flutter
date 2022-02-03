import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
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

class _MainPageState extends KDHState<MainPage> {
  final double maxMobileSize = 1024;
  late final Size maxSize;

  //screenSize, w, widgetToBuild를 잘 사용해야 한다.
  //makeWidgetListToGetSize->onLoad->mustRebuild->super.build

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
    return AppComponents.scaffold(
      body: Row(
        children: [
          Container(
            color: MyColors.black,
            width: 91,
            child: Column(
              children: [],
            ),
          ),
          Container(
            color: MyColors.gray,
            width: 404,
            child: Column(
              children: [],
            ),
          ),
          Expanded(
            child: MainPageComponent.content(),
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
    return AppComponents.scaffold(
      body: SizedBox.expand(child: MainPageComponent.content()),
    );
  }
}

class MainPageComponent {
  static Widget content() {
    return Container(
      color: MyColors.black,
      child: Column(
        children: [],
      ),
    );
  }
}
