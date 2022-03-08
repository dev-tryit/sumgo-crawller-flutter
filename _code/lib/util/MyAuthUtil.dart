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

  static Future<AuthMode> verifyBeforeUpdateEmail({required String email}) async {
    try {
      await FireauthUtil.verifyBeforeUpdateEmail(email: email);
      return AuthMode.NEED_VERIFICATION;
    }
    on CommonException catch(e){
      LogUtil.warn("이메일 업데이트 에러 : $e");
      return AuthMode.LOGIN;
    }
  }
}