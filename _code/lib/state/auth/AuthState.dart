import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/PageUtil.dart';
import 'package:kdh_homepage/page/main/MainLayout.dart';
import 'package:kdh_homepage/util/MyAuthUtil.dart';
import 'package:kdh_homepage/util/MyComponents.dart';

abstract class AuthState<COMPONENT> {
  COMPONENT c;

  AuthState(this.c);

  Future<AuthState> handle(Map<String, dynamic> data);
}

class AuthStateSendEmail<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateSendEmail(this.c);

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    NeededAuthBehavior neededAuthBehavior =
        await MyAuthUtil.verifyBeforeUpdateEmail(email: data['email']);
    if (neededAuthBehavior == NeededAuthBehavior.NEED_LOGIN) {
      return AuthStateLogin(c);
    } else if (neededAuthBehavior == NeededAuthBehavior.NEED_REGISTRATION) {
      return AuthStateRegistration(c);
    } else if (neededAuthBehavior == NeededAuthBehavior.NEED_VERIFICATION) {
      return AuthStateNeedVerfication(c);
    }
    return this;
  }
}

class AuthStateNeedVerfication<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateNeedVerfication(this.c);

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    User? user = await MyAuthUtil.loginWithEmailDefaultPassword(data['email']);
    if (user?.emailVerified ?? false) {
      await MyAuthUtil.delete();
      return AuthStateRegistration<COMPONENT>(c);
    } else {
      MyComponents.toastError(data['context'], "이메일 인증이 필요합니다.");
      return this;
    }
  }
}

class AuthStateRegistration<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateRegistration(this.c);

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];
    String email = data['email'];
    String password = data['password'];
    String passwordConfirm = data['passwordConfirm'];

    //TODO: 비밀번호 유효성 검사 구문 필요 (비어있거나, 개수)
    if (password != passwordConfirm) {
      MyComponents.toastError(context, "비밀번호가 다릅니다.");
      return this;
    }

    try {
      await MyAuthUtil.registerWithEmail(email, password);
    } on CommonException catch (e) {
      MyComponents.toastError(context, e.message);
      return this;
    }

    MyComponents.toastInfo(context, "회원가입이 완료되었습니다.");
    PageUtil.movePage(context, MainLayout());
    return this;
  }
}

class AuthStateLogin<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateLogin(this.c);

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];
    String email = data['email'];
    String password = data['password'];

    //TODO: 비밀번호 유효성 검사 구문 필요 (비어있거나, 개수)

    try {
      await MyAuthUtil.loginWithEmail(email, password);
    } on CommonException catch (e) {
      MyComponents.toastError(context, e.message);
      return this;
    }

    PageUtil.movePage(context, MainLayout());
    return this;
  }
}
