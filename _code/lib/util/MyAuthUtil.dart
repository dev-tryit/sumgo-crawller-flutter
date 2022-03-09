import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';
import 'package:kdh_homepage/_common/util/FirestoreUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';

enum AuthMode { SEND_EMAIL, NEED_VERIFICATION, REGISTER, LOGIN }

class MyAuthUtil {
  static const _password = "tempNewPassword";

  static Future<bool> isLogin() async {
    return (FireauthUtil.getUser() != null);
  }

  static Future<AuthMode> verifyBeforeUpdateEmail(
      {required String email}) async {
    try {
      User? user = await FireauthUtil.loginAnonymously(password: _password);
    } on CommonException catch (e) {
      if (e.code == "user-token-expired") {
        return AuthMode.LOGIN;
      }
    }

    try {
      await FireauthUtil.verifyBeforeUpdateEmail(email: email);
      return AuthMode.NEED_VERIFICATION;
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return AuthMode.LOGIN;
      } else {
        return AuthMode.REGISTER;
      }
    }
  }

  static Future<void> logout() async {
    await FireauthUtil.logout();
  }

  static Future<User?> loginWithEmailDefaultPassword(String email) async {
    return FireauthUtil.loginWithEmail(email: email, password: _password);
  }

  static Future<User?> loginWithEmail(String email, String password) async {
    return FireauthUtil.loginWithEmail(email: email, password: password);
  }

  static Future<void> delete() async {
    await FireauthUtil.delete();
    await FireauthUtil.logout();
  }

  static Future<User?> registerWithEmail(String email,String password) async {
    return await FireauthUtil.registerWithEmail(email: email, password: password);
  }
}
