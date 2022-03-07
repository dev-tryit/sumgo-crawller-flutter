import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHStatelessWidget.dart';
import 'package:kdh_homepage/_common/util/PageUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/page/auth/AuthPage.dart';
import 'package:kdh_homepage/page/main/MainLayout.dart';
import 'package:kdh_homepage/util/MyAuthUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';

class LoadPage extends KDHStatelessWidget {
  LoadPageComponent c = LoadPageComponent();

  @override
  Widget widgetToBuild(BuildContext context) {
    return Scaffold(body: PlatformUtil.isMobile() ? mobile() : desktop());
  }

  Widget desktop() {
    return Center(child: c.body());
  }

  Widget mobile() {
    return c.body();
  }

  @override
  Future<void> afterBuild(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    PageUtil.movePage(
        context, await MyAuthUtil.isLogin() ? MainLayout() : AuthPage());
  }
}

class LoadPageComponent {
  Widget body() {
    return Container(
      width: 350,
      color: MyColors.deepBlue,
      alignment: Alignment.center,
      child: Text(
        "숨고 매니저",
        style: GoogleFonts.blackHanSans(
          fontSize: 35,
          color: MyColors.white,
        ),
      ),
    );
  }
}
