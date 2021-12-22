import 'package:flutter/material.dart';
import 'package:kdh_homepage/widget/PortpolioCard.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Widget> cardList = List.generate(10, (index) => PortpolioCard(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return cardList[index];
              },
              childCount: cardList.length,
            ),
          )
        ],
      ),
    );
  }
}