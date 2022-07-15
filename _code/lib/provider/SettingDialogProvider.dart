
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../_common/interface/ConsumerBuilderType.dart';

class SettingDialogProvider extends ChangeNotifier {
  bool isShownDebugTool = false;

  BuildContext context;

  SettingDialogProvider(this.context);

  static ChangeNotifierProvider get provider =>
      ChangeNotifierProvider<SettingDialogProvider>(
          create: (context) => SettingDialogProvider(context));

  static Widget consumer(
          {required ConsumerBuilderType<SettingDialogProvider> builder}) =>
      Consumer<SettingDialogProvider>(builder: builder);

  static SettingDialogProvider read(BuildContext context) =>
      context.read<SettingDialogProvider>();


  void showDebugTool(){
    isShownDebugTool = true;
    notifyListeners();
  }


}
