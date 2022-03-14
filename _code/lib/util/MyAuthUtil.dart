import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseAuthSingleton.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartAuthSingleton.dart';
enum NeededAuthBehavior { NEED_LOGIN, NEED_VERIFICATION, NEED_REGISTRATION }

class MyAuthUtil {
  static const _password = "tempNewPassword";

  static Future<void> init() async {
    (!PlatformUtil.isComputer())
        ? await FirebaseAuthSingleton().init()
        : await FiredartAuthSingleton().init();
  }

  static Future<bool> isLogin() async {
    //TODO: 인증했는지 플래그를 두어야 한다.
    //TODO: 기본 비밀번호 로그인이 되었는지 또는, 파이어베이스 저장소를 통해서 해결 가능
    return (!PlatformUtil.isComputer())
        ? (FirebaseAuthSingleton().getUser() != null)
        : (await FiredartAuthSingleton().getUser() != null);
  }

  static Future<NeededAuthBehavior> sendEmailVerification(
      {required String email}) async {
    try {
      !PlatformUtil.isComputer()
          ? await FirebaseAuthSingleton().registerWithEmail(
              email: email, password: _password)
          : await FiredartAuthSingleton().registerWithEmail(
              email: email, password: _password);
    } on CommonException catch (e) {
      if (e.code == "email-already-in-use") {
        try {
          await loginWithEmailDefaultPassword(email);
        } on CommonException catch (e2) {
          if (e2.code == "wrong-password") {
            return NeededAuthBehavior.NEED_LOGIN;
          }
        }
      }
    }

    try {
      !PlatformUtil.isComputer()
          ? await FirebaseAuthSingleton().sendEmailVerification()
          : await FiredartAuthSingleton().sendEmailVerification();
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return NeededAuthBehavior.NEED_LOGIN;
      } else {
        return NeededAuthBehavior.NEED_REGISTRATION;
      }
    }

    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().logout()
        : await FiredartAuthSingleton().logout();
    return NeededAuthBehavior.NEED_VERIFICATION;
  }

  static Future<void> logout() async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().logout()
        : await FiredartAuthSingleton().logout();
  }

  static Future<void> loginWithEmailDefaultPassword(String email) async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().loginWithEmail(
            email: email, password: _password)
        : await FiredartAuthSingleton().loginWithEmail(
            email: email, password: _password);
  }

  static Future<void> loginWithEmail(String email, String password) async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().loginWithEmail(
            email: email, password: password)
        : await FiredartAuthSingleton().loginWithEmail(
            email: email, password: password);
  }

  static Future<void> delete() async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().delete()
        : await FiredartAuthSingleton().delete();
    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().logout()
        : await FiredartAuthSingleton().logout();
  }

  static Future<void> registerWithEmail(String email, String password) async {
    !PlatformUtil.isComputer()
        ? await FirebaseAuthSingleton().registerWithEmail(
            email: email, password: password)
        : await FiredartAuthSingleton().registerWithEmail(
            email: email, password: password);
  }

  static Future<bool> emailIsVerified() async {
    return !PlatformUtil.isComputer()
        ? (FirebaseAuthSingleton().getUser()?.emailVerified ?? false)
        : ((await FiredartAuthSingleton().getUser())?.emailVerified ?? false);
  }
}
