import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';

class SettingDialog extends StatelessWidget {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final chromeUrlController = TextEditingController();

  SettingDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => SettingDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 18, bottom: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                  onPressed: () => AuthUtil().logout(context: context),
                  style: ElevatedButton.styleFrom(primary: MyColors.lightBlue),
                ),
              ],
            ),
            const Divider(),
            textFieldWithLabel(label: "숨고 ID", controller: idController),
            const SizedBox(height: 10),
            textFieldWithLabel(label: "숨고 PW", controller: pwController),
            const SizedBox(height: 10),
            textFieldWithLabel(label: "크롬 주소", controller: chromeUrlController),
            const SizedBox(height: 35),
            actions(),
          ],
        ),
      ),
    );
  }

  Widget textFieldWithLabel(
      {required String label, TextEditingController? controller}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: controller,
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: MyColors.red),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          child: const Text("취소"),
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: MyColors.red),
        ),
      ],
    );
  }
}
