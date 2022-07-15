import 'package:flutter/cupertino.dart';
import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/AuthUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/page/main/MainLayout.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';

class AuthStateManager {
  AuthState state;
  
  AuthStateManager() : state = AuthStateSendEmail();

  Future<void> handle(Map<String, dynamic> data) async {
    state = await state.handle(data);
  }
}

abstract class AuthState {

  AuthState();

  Future<AuthState> handle(Map<String, dynamic> data);
}

class AuthStateSendEmail implements AuthState {

  AuthStateSendEmail();

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];

    MyComponents.showLoadingDialog(context);
    NeededAuthBehavior neededAuthBehavior =
        await AuthUtil().sendEmailVerification(email: data['email']);
    LogUtil.info("AuthStateSendEmail handle neededAuthBehavior:$neededAuthBehavior");
    if (neededAuthBehavior == NeededAuthBehavior.NEED_LOGIN) {
      return AuthStateLogin();
    } else if (neededAuthBehavior == NeededAuthBehavior.NEED_REGISTRATION) {
      return AuthStateRegistration();
    } else if (neededAuthBehavior == NeededAuthBehavior.NEED_VERIFICATION) {
      return AuthStateNeedVerification();
    }
    MyComponents.dismissLoadingDialog();
    return this;
  }
}

class AuthStateNeedVerification implements AuthState {
  AuthStateNeedVerification();

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];

    MyComponents.showLoadingDialog(context);
    await AuthUtil().loginWithEmailDefaultPassword(data['email']);
    if (await AuthUtil().emailIsVerified()) {
      await AuthUtil().delete();
      MyComponents.dismissLoadingDialog();
      return AuthStateRegistration();
    } else {
      MyComponents.dismissLoadingDialog();
      MyComponents.toastError(data['context'], "이메일 인증이 필요합니다.");
      return this;
    }
  }
}

class AuthStateRegistration implements AuthState {
  AuthStateRegistration();

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];
    String email = data['email'];
    String password = data['password'];
    String passwordConfirm = data['passwordConfirm'];


    if (email.isEmpty) {
      MyComponents.toastError(context, "이메일이 비어있습니다");
      return this;
    }

    if (password.isEmpty) {
      MyComponents.toastError(context, "비밀번호가 비어있습니다");
      return this;
    }

    if (passwordConfirm.isEmpty) {
      MyComponents.toastError(context, "비밀번호 확인이 비어있습니다");
      return this;
    }

    if (password != passwordConfirm) {
      MyComponents.toastError(context, "비밀번호가 다릅니다.");
      return this;
    }

    MyComponents.showLoadingDialog(context);
    //다른 안내는 파이어베이스에서 해준다.
    try {
      await AuthUtil().registerWithEmail(email, password);
    } on CommonException catch (e) {
      MyComponents.dismissLoadingDialog();
      MyComponents.toastError(context, e.message);
      return this;
    }


    MyComponents.dismissLoadingDialog();
    MyComponents.toastInfo(context, "회원가입이 완료되었습니다.");
    PageUtil.movePage(context, MainLayout());
    return this;
  }
}

class AuthStateLogin implements AuthState {
  AuthStateLogin();

  @override
  Future<AuthState> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];
    String email = data['email'];
    String password = data['password'];

    if (email.isEmpty) {
      MyComponents.toastError(context, "이메일이 비어있습니다");
      return this;
    }

    if (password.isEmpty) {
      MyComponents.toastError(context, "비밀번호가 비어있습니다");
      return this;
    }

    MyComponents.showLoadingDialog(context);
    //다른 안내는 파이어베이스에서 해준다.
    try {
      await AuthUtil().loginWithEmail(email, password);
    } on CommonException catch (e) {
      MyComponents.dismissLoadingDialog();
      MyComponents.toastError(context, e.message);
      return this;
    }

    PageUtil.movePage(context, MainLayout());
    MyComponents.dismissLoadingDialog();
    return this;
  }
}
