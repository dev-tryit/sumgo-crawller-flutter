import 'package:firebase_auth/firebase_auth.dart';
import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseAuthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartAuthUtil.dart';

enum NeededAuthBehavior { NEED_LOGIN, NEED_VERIFICATION, NEED_REGISTRATION }

class MyAuthUtil {
  static const _password = "tempNewPassword";

  static Future<void> init() async {
    (!PlatformUtil.isComputer())
        ? await FirebaseAuthUtil.init()
        : await FiredartAuthUtil.init();
  }

  static Future<bool> isLogin() async {
    return (!PlatformUtil.isComputer())
        ? (FirebaseAuthUtil.getUser() != null)
        : (await FiredartAuthUtil.getUser() != null);
  }

  static Future<NeededAuthBehavior> sendEmailVerification(
      {required String email}) async {
    try {
      !PlatformUtil.isComputer()
          ? await FirebaseAuthUtil.loginWithEmail(email: email, password: _password)
          : await FiredartAuthUtil.loginWithEmail(email: email, password: _password);
    } on CommonException catch (e) {
      if (e.code == "user-token-expired") {
        return NeededAuthBehavior.NEED_LOGIN;
      }
    }

    try {
      !PlatformUtil.isComputer()
          ? await FirebaseAuthUtil.sendEmailVerification()
          : await FiredartAuthUtil.sendEmailVerification();

      return NeededAuthBehavior.NEED_VERIFICATION;
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return NeededAuthBehavior.NEED_LOGIN;
      } else {
        return NeededAuthBehavior.NEED_REGISTRATION;
      }
    } finally {
      !PlatformUtil.isComputer()
          ? await FirebaseAuthUtil.logout()
          : await FiredartAuthUtil.logout();
    }
  }

  static Future<void> logout() async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthUtil.logout()
        : await FiredartAuthUtil.logout();
  }

  static Future<void> loginWithEmailDefaultPassword(String email) async {
    !PlatformUtil.isComputer()
        ? FirebaseAuthUtil.loginWithEmail(email: email, password: _password)
        : FiredartAuthUtil.loginWithEmail(email: email, password: _password);
  }

  static Future<void> loginWithEmail(String email, String password) async {
    !PlatformUtil.isComputer()
        ? FirebaseAuthUtil.loginWithEmail(email: email, password: password)
        : FiredartAuthUtil.loginWithEmail(email: email, password: password);
  }

  static Future<void> delete() async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthUtil.delete()
        : await FiredartAuthUtil.delete();
    !PlatformUtil.isComputer()
        ? await FirebaseAuthUtil.logout()
        : await FiredartAuthUtil.logout();
  }

  static Future<void> registerWithEmail(String email, String password) async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthUtil.registerWithEmail(
            email: email, password: password)
        : await FiredartAuthUtil.registerWithEmail(
            email: email, password: password);
  }

  static Future<bool> emailIsVerified() async {
    return !PlatformUtil.isComputer()
        ? (FirebaseAuthUtil.getUser()?.emailVerified ?? false)
        : ((await FiredartAuthUtil.getUser())?.emailVerified ?? false);
  }
}
