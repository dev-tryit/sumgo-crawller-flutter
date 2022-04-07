import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHComponent.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHService.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/AnimationUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/repository/AnalysisItemRepository.dart';
import 'package:sumgo_crawller_flutter/repository/SettingRepository.dart';
import 'package:sumgo_crawller_flutter/util/MyBottomSheetUtil.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';
import 'package:sumgo_crawller_flutter/util/MyImage.dart';
import 'package:sumgo_crawller_flutter/widget/MyCard.dart';
import 'package:sumgo_crawller_flutter/widget/MyChart.dart';
import 'package:sumgo_crawller_flutter/widget/MyRedButton.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  _SettingDialogState createState() => _SettingDialogState();

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => SettingDialog());
  }
}

class _SettingDialogState extends KDHState<SettingDialog,
    SettingDialogComponent, SettingDialogService> {
  @override
  bool isPage() => false;

  @override
  makeComponent() => SettingDialogComponent(this);

  @override
  makeService() => SettingDialogService(this, c);

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {
    await s.onLoad();
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => c.body(s);
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}
}

class SettingDialogComponent extends KDHComponent<_SettingDialogState> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final chromeUrlController = TextEditingController();

  SettingDialogComponent(_SettingDialogState state) : super(state);

  Widget body(SettingDialogService s) {
    return Dialog(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 18, bottom: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title(s),
            const Divider(),
            const SizedBox(height: 20),
            textFieldWithLabel(label: "숨고 ID", controller: idController),
            const SizedBox(height: 30),
            textFieldWithLabel(
                label: "숨고 PW", controller: pwController, obscureText: true),
            const SizedBox(height: 30),
            textFieldWithLabel(
                label: "크롬 주소",
                controller: chromeUrlController,
                hintText: 'http://localhost:9222'),
            const SizedBox(height: 35),
            actions(s),
          ],
        ),
      ),
    );
  }

  Widget textFieldWithLabel(
      {required String label,
      TextEditingController? controller,
      bool obscureText = false,
      String? hintText}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: (hintText ?? "").isNotEmpty ? Colors.grey : null),
              isDense: true,
            ),
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget actions(SettingDialogService s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          child: const Text("저장"),
          onPressed: s.saveSetting,
          style: ElevatedButton.styleFrom(primary: MyColors.red),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          child: const Text("취소"),
          onPressed: s.cancel,
          style: ElevatedButton.styleFrom(primary: MyColors.red),
        ),
      ],
    );
  }

  Widget title(SettingDialogService s) {
    return Row(
      children: [
        Text(
          "크롤링 설정하기",
          style: MyFonts.gothicA1(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          child: const Text("로그아웃"),
          onPressed: s.logout,
          style: ElevatedButton.styleFrom(primary: MyColors.lightBlue),
        ),
      ],
    );
  }
}

class SettingDialogService
    extends KDHService<_SettingDialogState, SettingDialogComponent> {
  Setting? setting;

  SettingDialogService(_SettingDialogState state, SettingDialogComponent c)
      : super(state, c);

  Future<void> onLoad() async {
    setting = await SettingRepository().getOne();
    c.idController.text = setting?.sumgoId ?? "";
    c.pwController.text = setting?.sumgoPw ?? "";
    c.chromeUrlController.text = setting?.crallwerUrl ?? "";
  }

  Future<void> saveSetting() async {
    setting = (setting ?? Setting.empty())
      ..sumgoId = c.idController.text
      ..sumgoPw = c.pwController.text
      ..crallwerUrl = c.chromeUrlController.text;
    await SettingRepository().save(setting: setting!);
    PageUtil.back(context);
  }

  void cancel() {
    PageUtil.back(context);
  }

  void logout() {
    AuthUtil().logout(context: context);
  }
}
