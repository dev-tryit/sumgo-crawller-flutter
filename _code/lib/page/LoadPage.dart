import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/page/auth/AuthPage.dart';
import 'package:sumgo_crawller_flutter/page/main/MainLayout.dart';
import 'package:sumgo_crawller_flutter/util/MyAuthUtil.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';

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
