import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/util/MyAuthUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends KDHState<AuthPage> {
  late final AuthPageService s;
  late final AuthPageComponent c;

  @override
  bool isPage() => true;

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  Future<void> onLoad() async {
    s = AuthPageService(this);
    c = AuthPageComponent(this);
  }

  @override
  void mustRebuild() {
    widgetToBuild = () => c.body();
    rebuild();
  }

  @override
  Future<void> afterBuild() async {}
}

class AuthPageComponent {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: "imkim189371@gmail.com");
  final certificationNumberController = TextEditingController();
  AuthMode authMode = AuthMode.SEND_EMAIL;

  _AuthPageState state;

  String? emailValidationText = "인증 요청";
  String? nextButtonText;

  AuthPageComponent(this.state);

  AuthPageService get s => state.s;

  Widget body() {
    LogUtil.debug("body authMode:$authMode");

    List<Widget> elementList = [];
    if (authMode == AuthMode.LOGIN) {
      elementList.addAll([
        const SizedBox(height: 30),
        inputBox(
          label: "비밀번호",
          onChanged: (value) => _formKey.currentState?.validate(),
        ),
      ]);
    } else if (authMode == AuthMode.REGISTER) {
      elementList.addAll([
        const SizedBox(height: 30),
        inputBox(
          label: "비밀번호",
          onChanged: (value) => _formKey.currentState?.validate(),
        ),
        const SizedBox(height: 30),
        inputBox(
          label: "비밀번호 확인",
          onChanged: (value) => _formKey.currentState?.validate(),
        ),
      ]);
    }

    return Scaffold(
      bottomSheet: nextButtonText != null
          ? AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 1500),
              child: Container(
                height: 82,
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
                child: SizedBox.expand(
                  child: ElevatedButton(
                    child: Text(nextButtonText!),
                    style: ElevatedButton.styleFrom(primary: MyColors.deepBlue),
                    onPressed: s.loginOrRegister,
                  ),
                ),
              ),
            )
          : null,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 36),
              Text(
                "숨고 매니저",
                style: GoogleFonts.blackHanSans(
                  fontSize: 35,
                  color: MyColors.deepBlue,
                ),
              ),
              const SizedBox(height: 69),
              inputBox(
                label: "이메일",
                trailing: emailValidationText,
                onTrailingTap: s.sendEmailVerification,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || !EmailValidator.validate(value)) {
                    return "이메일 형식이 아닙니다.";
                  }
                  return null;
                },
                onChanged: (value) => _formKey.currentState?.validate(),
              ),
              ...elementList
            ],
          ),
        ),
      ),
    );
  }

  Widget inputBox({
    required String label,
    String? trailing,
    GestureTapCallback? onTrailingTap,
    TextEditingController? controller,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
  }) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 1200),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    validator: validator,
                    onChanged: onChanged,
                  ),
                ),
                ...trailing != null
                    ? [
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: InkWell(
                            onTap: onTrailingTap,
                            child: Text(
                              trailing,
                              style: GoogleFonts.gothicA1(
                                  color: MyColors.deepBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]
                    : [],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AuthPageService {
  _AuthPageState state;

  AuthPageService(this.state);

  AuthPageComponent get c => state.c;

  BuildContext get context => state.context;

  void sendEmailVerification() async {
    String email = c.emailController.text.trim();

    await MyComponents.showLoadingDialog(context);
    if (c.authMode == AuthMode.NEED_VERIFICATION) {
      User? user = await MyAuthUtil.loginWithEmail(email);
      if (user?.emailVerified ?? false) {
        c.authMode = AuthMode.REGISTER;
        c.emailValidationText = null;
        c.nextButtonText = "회원가입";
      } else {
        MyComponents.toastError(context, "이메일 인증이 필요합니다.");
      }
    } else {
      c.authMode = await MyAuthUtil.verifyBeforeUpdateEmail(email: email);

      switch (c.authMode) {
        case AuthMode.NEED_VERIFICATION:
          c.emailValidationText = "인증 확인";
          c.nextButtonText = null;
          break;
        case AuthMode.LOGIN:
          c.emailValidationText = null;
          c.nextButtonText = "로그인";
          break;
        default:
          c.emailValidationText = "인증 요청";
          c.nextButtonText = "null";
          break;
      }
    }
    await MyComponents.dismissLoadingDialog();

    state.rebuild();
  }

  void loginOrRegister() {
    //TODO: 여기만 구현하면됨.
    if (c.authMode == AuthMode.LOGIN) {

    } else if (c.authMode == AuthMode.REGISTER) {

    } else {
      MyComponents.toastError(
        context,
        "loginOrRegister에 에러가 있습니다. 회원가입, 로그인 상태가 아닙니다.",
      );
    }
  }
}
