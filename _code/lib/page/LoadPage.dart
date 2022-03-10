import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/PageUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/page/auth/AuthPage.dart';
import 'package:kdh_homepage/page/main/MainLayout.dart';
import 'package:kdh_homepage/util/MyAuthUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends KDHState<LoadPage> {
  LoadPageComponent c = LoadPageComponent();

  @override
  bool isPage() => true;

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  void mustRebuild() {
    widgetToBuild =
        () => Scaffold(body: c.body());
    rebuild();
  }

  @override
  Future<void> afterBuild() async {
    await Future.delayed(const Duration(seconds: 1));
    PageUtil.movePage(
        context, await MyAuthUtil.isLogin() ? MainLayout() : AuthPage());
  }

  @override
  Future<void> onLoad() async {}
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
