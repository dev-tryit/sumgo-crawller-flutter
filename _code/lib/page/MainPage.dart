import 'package:flutter/material.dart';
import 'package:kdh_homepage/util/MyImage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyImage.blueBackgroundImage,
      ),
    );
  }
}
