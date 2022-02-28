import 'package:flutter/material.dart';
import 'package:kdh_homepage/Layout.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyImage.dart';
import 'package:kdh_homepage/widget/MyCard.dart';
import 'package:kdh_homepage/widget/MyChart.dart';
import 'package:kdh_homepage/widget/MyRedButton.dart';
import 'package:kdh_homepage/widget/MyWhiteButton.dart';

class RequestRemovalPage extends StatefulWidget {
  const RequestRemovalPage({Key? key}) : super(key: key);

  @override
  _RequestRemovalPageState createState() => _RequestRemovalPageState();
}

class _RequestRemovalPageState extends State<RequestRemovalPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          MyCard(
            title: "정리 조건",
            rightButton: const MyRedButton("생성하기"),
            contents: [
              cardListTile("[최우선키워드] Flutter"),
              cardListTile("[최우선키워드] Flutter"),
              cardListTile("[포함] Flutter"),
              cardListTile("[포함] Flutter"),
              cardListTile("[포함] Flutter", isPlusIcon: false),
              cardListTile("[제외] Flutter", isPlusIcon: false),
              cardListTile("[제외] Flutter", isPlusIcon: false),
            ],
            bottomButton: const MyWhiteButton("요청 정리하기"),
          ),
        ],
      ),
    );
  }

  ListTile cardListTile(String title, {bool isPlusIcon=true}) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(top: 6),
        child: Image(image: (isPlusIcon ? MyImage.plusIcon : MyImage.minusIcon)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      horizontalTitleGap: 6,
      title: MyComponents.text(text: title),
      dense: true,
    );
  }
}
