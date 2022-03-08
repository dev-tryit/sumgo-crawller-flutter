import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';

class MyAuthUtil {
  static Future<bool> isLogin() async {
    User? user = FireauthUtil.getUser();
    return (user != null) && (user.emailVerified);
  }
}