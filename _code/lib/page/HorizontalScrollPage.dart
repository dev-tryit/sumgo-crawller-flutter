import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';

class HorizontalScrollPage extends StatefulWidget {
  const HorizontalScrollPage({Key? key}) : super(key: key);

  @override
  _HorizontalScrollPageState createState() => _HorizontalScrollPageState();
}

class _HorizontalScrollPageState extends State<HorizontalScrollPage> {
  @override
  Widget build(BuildContext context) {
    LogUtil.info("app buildNumber : ${Setting.appBuildNumber}");

    Size screenSize = MediaQueryUtil.getScreenSize(context);
    LogUtil.info("screen size : $screenSize");

    return SafeArea(
      child: Scaffold(
        body: AppComponents.horizontalScroll(
          screenSize: screenSize,
          containerWidth:100,
          children: [
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
