import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/LogUtil.dart';
import 'package:kdh_homepage/util/MediaQueryUtil.dart';

class VerticalScrollPage extends StatefulWidget {
  const VerticalScrollPage({Key? key}) : super(key: key);

  @override
  _VerticalScrollPageState createState() => _VerticalScrollPageState();
}

class _VerticalScrollPageState extends State<VerticalScrollPage> {
  @override
  Widget build(BuildContext context) {
    LogUtil.info("app buildNumber : ${Setting.appBuildNumber}");

    Size screenSize = MediaQueryUtil.getScreenSize(context);
    LogUtil.info("screen size : $screenSize");

    return SafeArea(
      child: Scaffold(
        body: AppComponents.verticalScroll(
          screenSize: screenSize,
          
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
