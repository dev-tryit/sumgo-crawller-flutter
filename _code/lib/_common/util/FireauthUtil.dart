import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';

class FireauthUtil {
  static bool _haveEverInit = false;

  static FirebaseAuth get _instance => FirebaseAuth.instance;

  static Future<void> init() async {
    if (!_haveEverInit) {
      _haveEverInit = true;
      await _instance.setLanguageCode('ko'); //이메일 보낼 때 한국어로 보냄

      //setPersistence를 통해서, 웹의 경우, 로그인 유지를 시킬지, 세션에만 시킬지, 안시킬지 결정할 수 있다.

      //IOS는 앱을 재설치하면, 로그인 정보가 남아 있을 수 있다. IOS는 키체인에 데이터를 저장하는데, 키체인이 앱삭제시 유지되기도 함.

      //authStateChanges는 회원가입, 로그인, 로그아웃까지.
      //idTokenChanges는 authStateChanges + 토큰 변경까지. (ADMIN SDK에 의한것은 감지 X)
      //userChanges는 idTokenChanges는 + currentUser의 내용이 변경되는 함수가 호출될 때 (ADMIN SDK에 의한것은 감지 X)
      //이 부분에서 이메일 인증을 체크할 수 없다.
      // _instance.idTokenChanges().listen((User? user) {
      //   //변경사항 체크하는 곳이다. 절대, user를 주는곳이 아니라는 것을 알아야 한다.
      // });
    }
  }

  static User? getUser() {
    return _instance.currentUser;
  }

  static Future<User?> loginAnonymously({String? password}) async {
    try {
      await _instance.signInAnonymously();
      User? user = getUser();
      if (password != null) {
        await user?.updatePassword(password);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CommonException(message: "비밀번호 형식이 안전하지 않습니다", code: e.code);
      } else if (e.code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: e.code);
      } else if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: e.code);
      } else if (e.code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: e.code);
      } else if (e.code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: e.code);
      } else {
        throw CommonException(code: e.code);
      }
    }
  }

  static Future<void> registerWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CommonException(message: "비밀번호 형식이 안전하지 않습니다", code: e.code);
      } else if (e.code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: e.code);
      } else if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: e.code);
      } else if (e.code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: e.code);
      } else if (e.code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: e.code);
      } else {
        throw CommonException(code: e.code);
      }
    }
  }

  static Future<void> verifyBeforeUpdateEmail({required String email}) async {
    User? user = getUser();
    if (user == null) {
      LogUtil.error("user is null");
      return;
    }

    try {
      await user.verifyBeforeUpdateEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw CommonException(message: "이미 ID가 있습니다", code: e.code);
      } else {
        LogUtil.error("FireauthUtil.verifyBeforeUpdateEmail ${e.code}");
      }
    }
  }

  static Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      return getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      } else if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'wrong-password') {
        throw CommonException(message: "비밀번호가 틀렸습니다", code: e.code);
      } else if (e.code == 'too-many-requests') {
        throw CommonException(message: "잠시 후에 다시 시도해주세요", code: e.code);
      } else if (e.code == 'network-request-failed') {
        throw CommonException(message: "네트워크 요청이 실패하였습니다", code: e.code);
      } else if (e.code == 'internal-error') {
        throw CommonException(message: "에러가 발생하였습니다", code: e.code);
      } else {
        throw CommonException(code: e.code);
      }
    }
  }

  static Future<void> logout() async {
    await _instance.signOut();
  }
}
