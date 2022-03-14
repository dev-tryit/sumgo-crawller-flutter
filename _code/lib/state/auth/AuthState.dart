import 'package:flutter/cupertino.dart';
import 'package:sumgo_crawller_flutter/_common/model/exception/CommonException.dart';
import 'package:sumgo_crawller_flutter/_common/util/LogUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/PageUtil.dart';
import 'package:sumgo_crawller_flutter/_common/util/StringUtil.dart';
import 'package:sumgo_crawller_flutter/page/main/MainLayout.dart';
import 'package:sumgo_crawller_flutter/util/MyAuthUtil.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';

class AuthStateManager<COMPONENT> {
  AuthState<COMPONENT> state;
  COMPONENT c;

  AuthStateManager(this.c) : state = AuthStateSendEmail<COMPONENT>(c);

  Future<void> handle(Map<String, dynamic> data) async {
    state = await state.handle(data);
  }
}

abstract class AuthState<COMPONENT> {
  COMPONENT c;

  AuthState(this.c);

  Future<AuthState<COMPONENT>> handle(Map<String, dynamic> data);
}

class AuthStateSendEmail<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateSendEmail(this.c);

  @override
  Future<AuthState<COMPONENT>> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];

    MyComponents.showLoadingDialog(context);
    NeededAuthBehavior neededAuthBehavior =
        await MyAuthUtil.sendEmailVerification(email: data['email']);
    LogUtil.info("AuthStateSendEmail handle neededAuthBehavior:$neededAuthBehavior");
    if (neededAuthBehavior == NeededAuthBehavior.NEED_LOGIN) {
      return AuthStateLogin<COMPONENT>(c);
    } else if (neededAuthBehavior == NeededAuthBehavior.NEED_REGISTRATION) {
      return AuthStateRegistration<COMPONENT>(c);
    } else if (neededAuthBehavior == NeededAuthBehavior.NEED_VERIFICATION) {
      return AuthStateNeedVerification<COMPONENT>(c);
    }
    MyComponents.dismissLoadingDialog();
    return this;
  }
}

class AuthStateNeedVerification<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateNeedVerification(this.c);

  @override
  Future<AuthState<COMPONENT>> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];

    MyComponents.showLoadingDialog(context);
    await MyAuthUtil.loginWithEmailDefaultPassword(data['email']);
    if (await MyAuthUtil.emailIsVerified()) {
      await MyAuthUtil.delete();
      MyComponents.dismissLoadingDialog();
      return AuthStateRegistration<COMPONENT>(c);
    } else {
      MyComponents.dismissLoadingDialog();
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
  Future<AuthState<COMPONENT>> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];
    String email = data['email'];
    String password = data['password'];
    String passwordConfirm = data['passwordConfirm'];

    print("test");

    if (StringUtil.isNullOrEmpty(email)) {
      print("test2");
      MyComponents.toastError(context, "이메일이 비어있습니다");
      return this;
    }

    if (StringUtil.isNullOrEmpty(password)) {
      print("test3");
      MyComponents.toastError(context, "비밀번호가 비어있습니다");
      return this;
    }

    if (StringUtil.isNullOrEmpty(passwordConfirm)) {
      print("test4");
      MyComponents.toastError(context, "비밀번호 확인이 비어있습니다");
      return this;
    }

    if (password != passwordConfirm) {
      print("test5");
      MyComponents.toastError(context, "비밀번호가 다릅니다.");
      return this;
    }

    MyComponents.showLoadingDialog(context);
    //다른 안내는 파이어베이스에서 해준다.
    try {
      await MyAuthUtil.registerWithEmail(email, password);
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

class AuthStateLogin<COMPONENT> implements AuthState<COMPONENT> {
  @override
  COMPONENT c;

  AuthStateLogin(this.c);

  @override
  Future<AuthState<COMPONENT>> handle(Map<String, dynamic> data) async {
    BuildContext context = data['context'];
    String email = data['email'];
    String password = data['password'];

    if (StringUtil.isNullOrEmpty(email)) {
      MyComponents.toastError(context, "이메일이 비어있습니다");
      return this;
    }

    if (StringUtil.isNullOrEmpty(password)) {
      MyComponents.toastError(context, "비밀번호가 비어있습니다");
      return this;
    }

    MyComponents.showLoadingDialog(context);
    //다른 안내는 파이어베이스에서 해준다.
    try {
      await MyAuthUtil.loginWithEmail(email, password);
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
