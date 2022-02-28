import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyImage.dart';
import 'package:kdh_homepage/widget/MyMenu.dart';

class MyHeader extends StatelessWidget {
  final PageController pageC;
  const MyHeader(this.pageC, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 4,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          const Image(image: MyImage.backgroundTop, fit: BoxFit.fill),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 19),
              title(),
              const Spacer(flex: 1),
              MyMenu(pageC: pageC),
              const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Text("숨고 매니저",
        style: GoogleFonts.blackHanSans(
          fontSize: 28,
          color: MyColors.white,
        ));
  }
}
