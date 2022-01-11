import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/page/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/util/DebugUtil.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Setting.appVersion = await DebugUtil.getAppVersion();
  Setting.appBuildNumber = await DebugUtil.getBuildNumber();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
