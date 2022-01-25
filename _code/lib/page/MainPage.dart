import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/ImageUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:unsplash_client/unsplash_client.dart';

enum W {
  maxContainer,
  space1,
  headerText1,
  space2,
  headerText2,
  mainListView,
  space3,
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends KDHState<MainPage> {
  late Size maxSize;
  double maxMobileSize = 1024;
  ScrollController scrollController = ScrollController();

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
      WidgetToGetSize(
        W.space1,
        (key) => SizedBox(key: key, height: 43),
      ),
      WidgetToGetSize(
        W.headerText1,
        (key) => AppComponents.text(
          key: key,
          fontSize: 52,
          text: "Fullstack Developer, 김동현입니다.",
        ),
      ),
      WidgetToGetSize(
        W.space2,
        (key) => SizedBox(key: key, height: 14),
      ),
      WidgetToGetSize(
        W.headerText2,
        (key) => AppComponents.text(
          key: key,
          fontSize: 37,
          text: "플루터 웹, 앱을 제작합니다. 스타트업의 시작을 도와드리겠습니다.",
        ),
      ),
      WidgetToGetSize(
        W.space3,
        (key) => SizedBox(key: key, height: 100),
      ),
      WidgetToGetSize(
        W.mainListView,
        (key) => SizedBox(
          key: key,
          height: 426,
          child: AppComponents.horizontalScroll(
              useWheelScrool: true,
              children:
                  List.generate(7, (index) => EachWorkCard("파섹홈페이지 $index"))),
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
    double sizableHeight = -1 +
        widgetMap[W.maxContainer]!.h -
        (widgetMap[W.space1]!.h +
            widgetMap[W.headerText1]!.h +
            widgetMap[W.space2]!.h +
            widgetMap[W.headerText2]!.h +
            widgetMap[W.mainListView]!.h +
            widgetMap[W.space3]!.h);

    return AppComponents.webPage(
      screenSize: screenSize,
      widgetList: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widgetMap[W.space1]!.make(),
              widgetMap[W.headerText1]!.make(),
              widgetMap[W.space2]!.make(),
              widgetMap[W.headerText2]!.make(),
            ],
          ),
        ),
        SizedBox(height: sizableHeight),
        widgetMap[W.mainListView]!.make(),
        widgetMap[W.space3]!.make(),
      ],
    );
  }

  Widget mobile(Size screenSize) {
    return desktop(screenSize);
  }
}

class EachWorkCard extends StatefulWidget {
  String title;
  EachWorkCard(this.title, {Key? key}) : super(key: key);

  @override
  _EachWorkCardState createState() => _EachWorkCardState();
}

class _EachWorkCardState extends KDHState<EachWorkCard> {
  late Photo photo;

  @override
  bool isPage() {
    return false;
  }

  @override
  Widget loadingWidget() {
    return const SizedBox.shrink();
  }

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() {
    return [];
  }

  @override
  Future<void> onLoad() async {
    photo = await ImageUtil.getRandomImage();
  }

  @override
  void mustRebuild() {
    bool isPortrait = photo.ratio > 1;
    widgetToBuild = () {
      return Padding(
        padding: const EdgeInsets.only(left: 27, right: 27),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              photo.urls.regular.toString(),
              height: isPortrait ? 210 : 290,
            ),
            const SizedBox(height: 22),
            AppComponents.text(text: widget.title),
            AppComponents.text(text: "포토그래퍼 포트폴리오용 홈페이지"),
            const SizedBox(height: 16),
            AppComponents.text(text: "500,000원"),
          ],
        ),
      );
    };
    rebuild();
  }
}
