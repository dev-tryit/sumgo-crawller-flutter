import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    LogUtil.info("app buildNumber : ${Setting.appBuildNumber}");

    Size screenSize = MediaQueryUtil.getScreenSize(context);
    LogUtil.info("screen size : $screenSize");

    return SafeArea(
      child: Scaffold(
        body: AppComponents.verticalScroll(
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
          screenSize: screenSize,
        ),
      ),
    );
  }
}
