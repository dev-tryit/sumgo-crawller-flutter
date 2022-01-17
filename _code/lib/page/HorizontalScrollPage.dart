import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/util/AppComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';

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
