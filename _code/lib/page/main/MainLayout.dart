import 'package:flutter/material.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHComponent.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHService.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/dialog/SettingDialog.dart';
import 'package:sumgo_crawller_flutter/page/main/KeywordAnalysisPage.dart';
import 'package:sumgo_crawller_flutter/page/main/RequestRemovalPage.dart';
import 'package:sumgo_crawller_flutter/provider/SettingDialogProvider.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyImage.dart';
import 'package:sumgo_crawller_flutter/widget/MyHeader.dart';

class MainLayout extends StatefulWidget {
  static const String staticClassName= "MainLayout";
  final className = staticClassName;
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState
    extends KDHState<MainLayout, MainLayoutComponent, MainLayoutService> {
  @override
  bool isPage() {
    return true;
  }

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() {
    return [];
  }

  @override
  MainLayoutComponent makeComponent() => MainLayoutComponent(this);

  @override
  MainLayoutService makeService() => MainLayoutService(this, c);

  @override
  Future<void> onLoad() async {
    List<Future> loadList = [];
    loadList.add(precacheImage(MyImage.backgroundTop, context));
    loadList.add(precacheImage(MyImage.boxIcon, context));
    loadList.add(precacheImage(MyImage.plusIcon, context));
    loadList.add(precacheImage(MyImage.minusIcon, context));

    await Future.wait(loadList);
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => Scaffold(body: c.body(s));
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}
}

class MainLayoutComponent extends KDHComponent<_MainLayoutState> {
  final PageController pageC;

  MainLayoutComponent(_MainLayoutState state)
      : pageC = PageController(),
        super(state);

  Widget body(MainLayoutService s) {
    return SettingDialogProvider.consumer(builder: (context, provider, child) {
      return SizedBox.expand(
        child: Stack(
          children: [
            Positioned(top: 150, bottom: 0, left: 0, right: 0, child: content(s)),
            MyHeader(pageC, ()=>SettingDialog.show(context)),
            ...(provider.isShownDebugTool
                ? [
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  backgroundColor: MyColors.red,
                  child: const Icon(Icons.bug_report),
                  onPressed: () => LogConsole.openLogConsole(context),
                ),
              )
            ]
                : []),
          ],
        ),
      );
    });
  }

  Widget content(MainLayoutService s) {
    return PageView(
      controller: pageC,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        KeywordAnalysisPage(),
        RequestRemovalPage()
      ],
    );
  }
}

class MainLayoutService
    extends KDHService<_MainLayoutState, MainLayoutComponent> {

  MainLayoutService(_MainLayoutState state, MainLayoutComponent c)
      : super(state, c);

}
