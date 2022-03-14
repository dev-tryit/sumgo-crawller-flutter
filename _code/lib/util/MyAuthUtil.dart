import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/PlatformUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firebase/FirebaseAuthSingleton.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartAuthSingleton.dart';

enum NeededAuthBehavior { NEED_LOGIN, NEED_VERIFICATION, NEED_REGISTRATION }

class MyAuthUtil {
  static late final _firebaseAuthUtilInterface;
  static const _password = "tempNewPassword";

  static Future<void> init() async {
    _firebaseAuthUtilInterface = (!PlatformUtil.isComputer())
        ? FirebaseAuthSingleton()
        : FiredartAuthSingleton();

    _firebaseAuthUtilInterface.init();
  }

  static Future<bool> isLogin() async {
    //TODO: 인증했는지 플래그를 두어야 한다.
    //TODO: 기본 비밀번호 로그인이 되었는지 또는, 파이어베이스 저장소를 통해서 해결 가능
    return (await _firebaseAuthUtilInterface.getUser() != null);
  }

  static Future<NeededAuthBehavior> sendEmailVerification(
      {required String email}) async {
    try {
      await _firebaseAuthUtilInterface
          .registerWithEmail(email: email, password: _password);
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
      await _firebaseAuthUtilInterface.sendEmailVerification();
    } on CommonException catch (e) {
      if (e.code == 'email-already-in-use') {
        return NeededAuthBehavior.NEED_LOGIN;
      } else {
        return NeededAuthBehavior.NEED_REGISTRATION;
      }
    }

    await _firebaseAuthUtilInterface.logout();
    return NeededAuthBehavior.NEED_VERIFICATION;
  }

  static Future<void> logout() async {
    await _firebaseAuthUtilInterface.logout();
  }

  static Future<void> loginWithEmailDefaultPassword(String email) async {
    await _firebaseAuthUtilInterface
        .loginWithEmail(email: email, password: _password);
  }

  static Future<void> loginWithEmail(String email, String password) async {
    await _firebaseAuthUtilInterface
        .loginWithEmail(email: email, password: password);
  }

  static Future<void> delete() async {
    await _firebaseAuthUtilInterface.delete();
    await _firebaseAuthUtilInterface.logout();
  }

  static Future<void> registerWithEmail(String email, String password) async {
    await _firebaseAuthUtilInterface.registerWithEmail(email: email, password: password);
  }

  static Future<bool> emailIsVerified() async {
    return ((await _firebaseAuthUtilInterface.getUser())?.emailVerified ?? false);
  }
}
