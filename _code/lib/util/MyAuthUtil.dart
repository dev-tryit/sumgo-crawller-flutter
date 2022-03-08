import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';

enum AuthMode {
  SEND_EMAIL, NEED_VERIFICATION, REGISTER, LOGIN
}

class MyAuthUtil {
  static Future<bool> isLogin() async {
    User? user = FireauthUtil.getUser();
    return (user != null) && (user.emailVerified);
  }

  static Future<AuthMode> sendEmailVerification({required String email}) async {
    try {
      await FireauthUtil.loginAnonymously();
    } on CommonException catch (e) {
      LogUtil.error("예상치 못한 에러 발생 ${e.code}");
      return AuthMode.SEND_EMAIL;
    }

    try {
      await FireauthUtil.sendEmailVerification(email: email);
      return AuthMode.NEED_VERIFICATION;
    }
    on CommonException catch(e){
      return AuthMode.LOGIN;
    }
  }
}