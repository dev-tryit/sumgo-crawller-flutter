import 'package:firebase_auth/firebase_auth.dart';
import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FireauthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/FirestoreUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/state/auth/AuthState.dart';

enum NeededAuthBehavior { NEED_LOGIN, NEED_VERIFICATION, NEED_REGISTRATION }

class MyAuthUtil {
  static const _password = "tempNewPassword";

  static Future<bool> isLogin() async {
    return (FireauthUtil.getUser() != null);
  }

  static Future<NeededAuthBehavior> verifyBeforeUpdateEmail(
      {required String email}) async {
    try {
      await FireauthUtil.loginAnonymously(password: _password);
    } on CommonException catch (e) {
      if (e.code == "user-token-expired") {
        return NeededAuthBehavior.NEED_LOGIN;
      }
    }

    try {
      await FireauthUtil.verifyBeforeUpdateEmail(email: email);
      return NeededAuthBehavior.NEED_VERIFICATION;
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return NeededAuthBehavior.NEED_LOGIN;
      } else {
        return NeededAuthBehavior.NEED_REGISTRATION;
      }
    } finally {
      await FireauthUtil.logout();
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

  static Future<User?> registerWithEmail(String email, String password) async {
    return await FireauthUtil.registerWithEmail(
        email: email, password: password);
  }
}
