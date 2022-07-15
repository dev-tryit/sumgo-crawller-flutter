import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/_common/widget/EasyKeyboardListener.dart';
import 'package:sumgo_crawller_flutter/repository/SettingRepository.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';

import '../provider/SettingDialogProvider.dart';

class SettingDialog extends StatefulWidget {
  static const String className = "SettingDialog";
  const SettingDialog({Key? key}) : super(key: key);

  @override
  _SettingDialogState createState() => _SettingDialogState();

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => SettingDialog());
  }
}

class _SettingDialogState extends KDHState<SettingDialog> {
  Setting? setting;

  @override
  bool isPage() => false;

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {
    setting = await SettingRepository().getOne();
    idController.text = setting?.sumgoId ?? "";
    pwController.text = setting?.sumgoPw ?? "";
    chromeUrlController.text = setting?.crallwerUrl ?? "";
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => body();
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}


  static const String debugString = "hiddenDebug";
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final chromeUrlController = TextEditingController();


  Widget body() {
    return EasyKeyboardListener(
      onValue: (value) {
        if (value.contains(debugString)) {
          LogUtil.setDebugLevel();
          SettingDialogProvider.read(context).showDebugTool();
          MyComponents.snackBar(context, "디버그 도구가 활성화되었습니다.");
        }
      },
      inputLimit: debugString.length,
      child: Dialog(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 25, right: 25, top: 18, bottom: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(),
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
              actions(),
            ],
          ),
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

  Widget actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          child: const Text("저장"),
          onPressed: saveSetting,
          style: ElevatedButton.styleFrom(primary: MyColors.red),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          child: const Text("취소"),
          onPressed: cancel,
          style: ElevatedButton.styleFrom(primary: MyColors.red),
        ),
      ],
    );
  }

  Widget title() {
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
          onPressed: logout,
          style: ElevatedButton.styleFrom(primary: MyColors.lightBlue),
        ),
      ],
    );
  }

  Future<void> saveSetting() async {
    setting = (setting ?? Setting(sumgoId: "",sumgoPw: "",crallwerUrl: ""))
      ..sumgoId = idController.text
      ..sumgoPw = pwController.text
      ..crallwerUrl = chromeUrlController.text;
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