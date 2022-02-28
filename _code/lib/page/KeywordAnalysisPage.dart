import 'package:flutter/material.dart';
import 'package:kdh_homepage/Layout.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyImage.dart';
import 'package:kdh_homepage/widget/MyCard.dart';
import 'package:kdh_homepage/widget/MyChart.dart';
import 'package:kdh_homepage/widget/MyRedButton.dart';

class KeywordAnalysisPage extends StatefulWidget {
  const KeywordAnalysisPage({Key? key}) : super(key: key);

  @override
  _KeywordAnalysisPageState createState() => _KeywordAnalysisPageState();
}

class _KeywordAnalysisPageState extends State<KeywordAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          MyCard(
            title: "키워드 분류",
            button: MyRedButton("생성하기"),
            contents: [
              cardListTile("연령 분류", "학업, 취미/자기개발, 학업, 취미/자기개발"),
              cardListTile(
                  "의뢰 목적 분류", "학업, 취미/자기개발, 학업, 취미/자기개발, 학업, 취미/자리..."),
            ],
          ),
          MyCard(title: "연령 분석", contents: [
            MyChart(),
          ]),
          MyCard(title: "연령 분석", contents: [
            MyChart(),
          ]),
        ],
      ),
    );
  }

  ListTile cardListTile(String title, String subtitle) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(top: 6),
        child: Image(image: MyImage.boxIcon),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      horizontalTitleGap: 6,
      title: MyComponents.text(text: title),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      dense: true,
    );
  }
}
