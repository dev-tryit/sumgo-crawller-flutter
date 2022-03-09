import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/page/LoadPage.dart';
import 'package:kdh_homepage/util/MyAuthUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyImage.dart';
import 'package:kdh_homepage/widget/MyMenu.dart';
import 'package:kdh_homepage/_common/util/PageUtil.dart';

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
              title(context),
              const Spacer(flex: 1),
              MyMenu(pageC: pageC),
              const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }

  Widget title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Opacity(opacity: 0, child: Icon(Icons.logout)),
          Text(
            "숨고 매니저",
            style: GoogleFonts.blackHanSans(
              fontSize: 28,
              color: MyColors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              await MyAuthUtil.logout();
              PageUtil.movePage(context, LoadPage());
            },
            child: const Opacity(
              opacity: 1,
              child: Icon(
                Icons.logout,
                color: MyColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
