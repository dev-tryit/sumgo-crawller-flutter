import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/MySetting.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/page/auth/AuthPage.dart';
import 'package:sumgo_crawller_flutter/page/main/MainLayout.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';

class LoadPage extends StatefulWidget {
  static const String staticClassName = "LoadPage";
  final className = staticClassName;

  const LoadPage({Key? key}) : super(key: key);

  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends KDHState<LoadPage> {
  @override
  bool isPage() => true;

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {}

  @override
  void mustRebuild() {
    widgetToBuild = () => Scaffold(body: body());
    rebuild();
  }

  @override
  Future<void> afterBuild() async {
    await moveNextPage();
  }

  Widget body() {
    return Container(
      width: 350,
      color: MyColors.deepBlue,
      alignment: Alignment.center,
      child: Text(
        MySetting.appName,
        style: MyFonts.blackHanSans(
          fontSize: 35,
          color: MyColors.white,
        ),
      ),
    );
  }

  Future<void> moveNextPage() async {
    await Future.delayed(const Duration(seconds: 1));
    PageUtil.replacementPage(
        context, await AuthUtil().isLogin() ? MainLayout() : AuthPage());
  }
}
