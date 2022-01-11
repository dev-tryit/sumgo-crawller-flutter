import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/page/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/util/AppColors.dart';
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
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: AppColors.backgroundColor,
        // primaryColor: Colors.lightBlue[800],
        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
      home: MainPage(),
    );
  }
}
