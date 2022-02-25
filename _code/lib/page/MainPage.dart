import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyImage.dart';

class MainPage extends StatelessWidget {
  final MainPageComponent c;

  MainPage({Key? key})
      : this.c = MainPageComponent(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQueryUtil.getScreenSize(context);
    LogUtil.info("size : $size");
    if (PlatformUtil.isMobile()) {
      return Scaffold(body: mobile());
    } else {
      return Scaffold(body: desktop());
    }
  }

  Widget desktop() {
    return Center(
      child: SizedBox(
        width: 350,
        height: double.infinity,
        child: c.body(),
      ),
    );
  }

  Widget mobile() {
    return c.body();
  }
}

class MainPageComponent {
  Widget body() {
    return Column(
      children: [header(), Expanded(child: content())],
    );
  }

  Widget menuItem(String text) {
    return Container(
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: MyColors.deepBlue,
      ),
      child: MyComponents.text(
        text: text,
        color: MyColors.white,
      ),
    );
  }

  Widget header() {
    return AspectRatio(
      aspectRatio: 6 / 4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: MyImage.blueBackgroundImage,
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 19,
                ),
                MyComponents.text(text: "숨고 매니저", color: MyColors.white),
                Spacer(flex: 1),
                Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: MyColors.lightBlue,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      menuItem("키워드 분석"),
                      menuItem("요청 정리"),
                    ],
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Text("content"),
          ),
        ],
      ),
    );
  }
}
