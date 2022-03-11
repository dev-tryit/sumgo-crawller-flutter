import 'package:firebase_auth/firebase_auth.dart';
import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseAuthUtil.dart';

enum NeededAuthBehavior { NEED_LOGIN, NEED_VERIFICATION, NEED_REGISTRATION }

class MyAuthUtil {
  static const _password = "tempNewPassword";

  static Future<bool> isLogin() async {
    return (FirebaseAuthUtil.getUser() != null);
  }

  static Future<NeededAuthBehavior> verifyBeforeUpdateEmail(
      {required String email}) async {
    try {
      await FirebaseAuthUtil.loginAnonymously(password: _password);
    } on CommonException catch (e) {
      if (e.code == "user-token-expired") {
        return NeededAuthBehavior.NEED_LOGIN;
      }
    }

    try {
      await FirebaseAuthUtil.verifyBeforeUpdateEmail(email: email);
      return NeededAuthBehavior.NEED_VERIFICATION;
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return NeededAuthBehavior.NEED_LOGIN;
      } else {
        return NeededAuthBehavior.NEED_REGISTRATION;
      }
    } finally {
      await FirebaseAuthUtil.logout();
    }
  }

  static Future<void> logout() async {
    await FirebaseAuthUtil.logout();
  }

  static Future<User?> loginWithEmailDefaultPassword(String email) async {
    return FirebaseAuthUtil.loginWithEmail(email: email, password: _password);
  }

  static Future<User?> loginWithEmail(String email, String password) async {
    return FirebaseAuthUtil.loginWithEmail(email: email, password: password);
  }

  static Future<void> delete() async {
    await FirebaseAuthUtil.delete();
    await FirebaseAuthUtil.logout();
  }

  static Future<User?> registerWithEmail(String email, String password) async {
    return await FirebaseAuthUtil.registerWithEmail(
        email: email, password: password);
  }
}
