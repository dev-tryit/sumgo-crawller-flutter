import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';

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
        body: MyComponents.verticalScroll(
          children: [
            Image.network('https://picsum.photos/250?image=9'),
            Image.network('https://picsum.photos/250?image=9'),
            Image.network('https://picsum.photos/250?image=9'),
            Image.network('https://picsum.photos/250?image=9'),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
            MyComponents.text(text: "test"),
          ],
        ),
      ),
    );
  }
}
