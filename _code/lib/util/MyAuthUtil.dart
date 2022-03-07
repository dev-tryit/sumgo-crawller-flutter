import 'package:kdh_homepage/_common/util/FireauthUtil.dart';

class MyAuthUtil {
  static Future<bool> isLogin() async {
    return FireauthUtil.isLogin();
  }
}