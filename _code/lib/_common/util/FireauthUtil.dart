import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';

class FireauthUtil {
  // static User? _user;
  // static bool _setAuthStateChanges = false;
  static FirebaseAuth get _instance => FirebaseAuth.instance;

  static void init() {
    //setPersistence를 통해서, 웹의 경우, 로그인 유지를 시킬지, 세션에만 시킬지, 안시킬지 결정할 수 있다.

    //IOS는 앱을 재설치하면, 로그인 정보가 남아 있을 수 있다. IOS는 키체인에 데이터를 저장하는데, 키체인이 앱삭제시 유지되기도 함.

    //authStateChanges는 회원가입, 로그인, 로그아웃까지.
    //idTokenChanges는 authStateChanges + 토큰 변경까지. (ADMIN SDK에 의한것은 감지 X)
    //userChanges는 idTokenChanges는 + currentUser의 내용이 변경되는 함수가 호출될 때 (ADMIN SDK에 의한것은 감지 X)
    // if(!_setAuthStateChanges) {
    //   _setAuthStateChanges = true;
    //   _instance.idTokenChanges().listen((User? user) {
    //     if(user != null) {
    //       //로그인함.
    //     }
    //     else {
    //       //로그아웃함.
    //     }
    //     // FireauthUtil._user = user;
    //   });
    // }
  }

  static User? getUser() {
    return _instance.currentUser;
  }

  static Future<bool> isLogin() async {
    return getUser() != null;
  }

  static Future<void> register(
      {required String email, required String password}) async {
    //회원가입했을 때, _instance.currentUser로 유저를 알 수 없음.
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

  static Future<void> sendEmailVerification() async {
    User? user = getUser();
    if (user == null) {
      LogUtil.error("해당 유저로 회원가입이 필요합니다.");
      return;
    }

    await user.sendEmailVerification();
  }

  static Future<void> login(
      {required String email, required String password}) async {
    try {
      await _instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw CommonException(message: "이메일이 형식이 잘못되었습니다", code: e.code);
      } else if (e.code == 'user-not-found') {
        throw CommonException(message: "해당 유저가 없습니다.", code: e.code);
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
