import 'package:flutter/material.dart';

/*
로그아웃


              await AuthUtil().logout(context: context);
 */
class SettingDialog extends StatelessWidget {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text("다이어로그"),
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SettingDialog()
    );
  }
}
