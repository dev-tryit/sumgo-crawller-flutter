
import 'package:firedart/auth/exceptions.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:sumgo_crawller_flutter/Setting.dart';
import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/firebase/firedart/FiredartStore.dart';

class FiredartAuthUtil {
  static bool _haveEverInit = false;

  static FirebaseAuth get _instance => FirebaseAuth.instance;

  static Future<void> init() async {
    if (!_haveEverInit) {
      _haveEverInit = true;


      FirebaseAuth.initialize(Setting.firebaseApiKey, await HiveStore.create());
      // _instance.signInState.listen((state) {
      //   print("Signed ${state ? "in" : "out"}");
      // });
    }
  }

  static Future<User?> getUser() async {
    try {
      return await _instance.getUser();
    } on SignedOutException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> loginAnonymously() async {
    try {
      await _instance.signInAnonymously();
      return await getUser();
    } on AuthException catch (e) {
      var code = e.errorCode;
      if (code == 'weak-password') {
        throw CommonException(message: "비밀번호 형식이 안전하지 않습니다", code: code);
      } else if (code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: code);
      } else if (code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: code);
      } else if (code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: code);
      } else if (code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: code);
      } else if (code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: code);
      } else {
        throw CommonException(code: code);
      }
    }
  }

  static Future<User?> registerWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.signUp(email, password);
      return await getUser();
    } on AuthException catch (e) {
      var code = e.errorCode;
      if (code == 'weak-password') {
        throw CommonException(message: "비밀번호 형식이 안전하지 않습니다", code: code);
      } else if (code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: code);
      } else if (code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: code);
      } else if (code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: code);
      } else if (code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: code);
      } else if (code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: code);
      } else {
        throw CommonException(code: code);
      }
    }
  }

  static Future<void> sendEmailVerification() async {
    User? user = await getUser();
    if (user == null) {
      LogUtil.error("user is null");
      return;
    }

    try {
      await _instance.requestEmailVerification();
    } on AuthException catch (e) {
      var code = e.errorCode;
      if (code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: code);
      } else {
        LogUtil.error("FireauthUtil.sendEmailVerification ${code}");
      }
    }
  }

  static Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.signUp(email, password);
      return await getUser();
    } on AuthException catch (e) {
      var code = e.errorCode;
      if (code == 'user-not-found') {
        return null;
      } else if (code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: code);
      } else if (code == 'wrong-password') {
        throw CommonException(message: "비밀번호가 틀렸습니다", code: code);
      } else if (code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: code);
      } else if (code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: code);
      } else if (code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: code);
      } else {
        throw CommonException(code: code);
      }
    }
  }

  static Future<void> logout() async {
    _instance.signOut();
  }

  static Future<void> delete() async {
    try {
      User? user = await getUser();
      if (user != null) {
        await _instance.deleteAccount();
      }
    } catch (e) {
      LogUtil.error("FireauthUtil.delete error $e");
    }
  }
}
