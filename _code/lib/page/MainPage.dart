import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/util/AppColors.dart';
import 'package:kdh_homepage/util/AppComponents.dart';
import 'package:kdh_homepage/util/DebugUtil.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 92),
            AppComponents.text(
                text: "${Setting.appBuildNumber}, Fullstack Developer, 김동현입니다.", fontSize: 52),
            const Spacer(flex: 14),
            AppComponents.text(
                text: "플루터 웹, 앱을 제작합니다. 스타트업의 시작을 도와드리겠습니다.", fontSize: 40),
            const Spacer(flex: 73),
            const Placeholder(strokeWidth: 1, fallbackHeight: 426),
            const Spacer(flex: 67),
          ],
        ),
      ),
    );
  }
}
