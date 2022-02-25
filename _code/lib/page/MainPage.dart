import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/MediaQueryUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyImage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

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
        child: mobile(),
      ),
    );
  }

  Widget mobile() {
    Widget header = AspectRatio(
      aspectRatio: 6 / 4,
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: MyImage.blueBackgroundImage,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyComponents.text(text: "숨고 매니저"),
              Spacer(),
            ],
          ),
        ],
      ),
    );

    Widget content = SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: Text("content"),
          ),
        ],
      ),
    );

    return Column(
      children: [header, Expanded(child: content)],
    );
  }
}
