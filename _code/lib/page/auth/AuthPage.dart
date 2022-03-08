import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/TValue.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/UUIDUtil.dart';
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

  TValue<double> checkCertificationNumberOpacity = TValue(0.0);

  final emailController = TextEditingController(text: "imkim189371@gmail.com");
  final certificationNumberController = TextEditingController();
  AuthMode authMode = AuthMode.SEND_EMAIL;

  _AuthPageState state;


  AuthPageComponent(this.state);

  AuthPageService get s => state.s;

  Widget body() {
    print("body authMode:$authMode");
    List<Widget> elementList = [];
    if(authMode == AuthMode.LOGIN) {
      elementList.addAll([
        const SizedBox(height: 30),
        inputBox(
          label: "비밀번호",
          onChanged: (value) => _formKey.currentState?.validate(),
        ),
      ]);
    }
    else if(authMode == AuthMode.NEED_VERIFICATION) {
      elementList.addAll([
        const SizedBox(height: 30),
        inputBox(
          label: "인증번호",
          trailing: "인증 확인",
          onTrailingTap: s.checkCertificationNumber,
          controller: certificationNumberController,
          keyboardType: TextInputType.number,
          onChanged: (value) => _formKey.currentState?.validate(),
        ),
      ]);
    }
    else if(authMode == AuthMode.REGISTER) {
      elementList.addAll([
        const SizedBox(height: 30),
        inputBox(
          label: "인증번호",
          trailing: "인증 확인",
          onTrailingTap: s.checkCertificationNumber,
          controller: certificationNumberController,
          onChanged: (value) => _formKey.currentState?.validate(),
        ),
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
      bottomSheet: Container(
        height: 82,
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
        child: SizedBox.expand(
          child: ElevatedButton(
            child: const Text("로그인"),
            style: ElevatedButton.styleFrom(primary: MyColors.deepBlue),
            onPressed: () {},
          ),
        ),
      ),
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
                trailing: "인증 요청",
                onTrailingTap: s.sendEmailVerification,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || !EmailValidator.validate(value)) {
                    return "이메일 형식이 아닙니다.";
                  }
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
    await MyComponents.showLoadingDialog(context);
    String email = c.emailController.text.trim();
    c.authMode = await MyAuthUtil.verifyBeforeUpdateEmail(email: email);
    //LOGIN이면,, 인증요청 글자 삭제 후에, 로그인 글자로 바꿈.
    //VERIFY_EMAIL이면, 인증확인을 위한 타이머 작동.
    await MyComponents.dismissLoadingDialog();

    state.rebuild();
  }

  void checkCertificationNumber() {
    //TODO:인증확인면 REGISTER 모드로 변경시킴.
    state.rebuild();
  }
}
