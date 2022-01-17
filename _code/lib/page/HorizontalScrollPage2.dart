import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';

class HorizontalScrollPage2 extends StatefulWidget {
  const HorizontalScrollPage2({Key? key}) : super(key: key);

  @override
  _HorizontalScrollPage2State createState() => _HorizontalScrollPage2State();
}

class _HorizontalScrollPage2State extends State<HorizontalScrollPage2> {
  @override
  Widget build(BuildContext context) {
    LogUtil.info("app buildNumber : ${Setting.appBuildNumber}");

    Size screenSize = MediaQueryUtil.getScreenSize(context);
    LogUtil.info("screen size : $screenSize");

    return SafeArea(
      child: Scaffold(
        body: AppComponents.horizontalScroll2(
          screenSize: screenSize,
          children: [
            Image.network('https://picsum.photos/250?image=9'),
            Image.network('https://picsum.photos/250?image=9'),
            Image.network('https://picsum.photos/250?image=9'),
            Image.network('https://picsum.photos/250?image=9'),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
            AppComponents.text(text: "test"),
          ],
        ),
      ),
    );
  }
}
