import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';

enum AuthMode { SEND_EMAIL, NEED_VERIFICATION, REGISTER, LOGIN }

class MyAuthUtil {
  static const _password = "tempNewPassword";

  static Future<bool> isLogin() async {
    User? user = FireauthUtil.getUser();
    return (user != null) && (user.emailVerified);
  }

  static Future<AuthMode> verifyBeforeUpdateEmail(
      {required String email}) async {
    try {
      await FireauthUtil.loginAnonymously(password: _password);
    } on CommonException catch (e) {
      if(e.code == "user-token-expired") {
        return AuthMode.LOGIN;
      }
    }

    try {
      await FireauthUtil.verifyBeforeUpdateEmail(email: email);
      return AuthMode.NEED_VERIFICATION;
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return AuthMode.LOGIN;
      }
      else {
        return AuthMode.REGISTER;
      }
    }
  }

  static Future<void> logout() async {
    await FireauthUtil.logout();
  }

  static Future<User?> loginWithEmail(String email) async {
    return FireauthUtil.loginWithEmail(email: email, password: _password);
  }
}
