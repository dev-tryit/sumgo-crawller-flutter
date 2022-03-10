import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:kdh_homepage/_common/config/MyCustomScrollBehavior.dart';
import 'package:kdh_homepage/_common/util/DesktopUtil.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';
import 'package:kdh_homepage/_common/util/PlatformUtil.dart';
import 'package:kdh_homepage/page/LoadPage.dart';
import 'package:kdh_homepage/page/main/MainLayout.dart';
import 'package:kdh_homepage/util/MyComponents.dart';
import 'package:kdh_homepage/util/MyTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!PlatformUtil.isComputer()) {
    await FireauthUtil.init();
  }
  if (PlatformUtil.isComputer()) {
    DesktopUtil.setSize(
      size: const Size(350, 800),
      minimumSize: const Size(350, 800),
      maximumSize: const Size(350, 800),
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Setting.appName,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: MyTheme.backgroundColor,
        // primaryColor: Colors.lightBlue[800],
        // Define the default font family.
        // fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: const TextTheme(d
        //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
      builder: (context, child) {
        child =
            FittedBox(child: SizedBox(width: 350,height: 700, child: child!));
        child = MyComponents.easyLoadingBuilder()(context, child);
        return child;
      },
      initialRoute: "/",
      home: LoadPage(),
    );
  }
}
