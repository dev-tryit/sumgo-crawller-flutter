import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHStatelessWidget.dart';
import 'package:kdh_homepage/_common/util/PageUtil.dart';
import 'package:kdh_homepage/page/main/MainLayout.dart';
import 'package:kdh_homepage/util/MyColors.dart';

class LoadPage extends KDHStatelessWidget {
  @override
  Widget widgetToBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.deepBlue,
      body: Center(
        child: Text(
          "숨고 매니저",
          style: GoogleFonts.blackHanSans(
            fontSize: 35,
            color: MyColors.white,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> afterBuild(BuildContext context) async {
    //TODO: 로그인 되어 있으면,
    PageUtil.movePage(context, MainLayout());

    //TODO: 로그인 안되어 있으면,
    // PageUtil.movePage(context, AuthPage());
  }
}
