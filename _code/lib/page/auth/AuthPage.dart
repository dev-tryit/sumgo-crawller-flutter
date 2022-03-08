import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/TValue.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/_common/model/exception/CommonException.dart';
import 'package:kdh_homepage/_common/util/FireauthUtil.dart';
import 'package:kdh_homepage/_common/util/LogUtil.dart';
import 'package:kdh_homepage/_common/util/UUIDUtil.dart';
import 'package:kdh_homepage/util/MyColors.dart';

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
  TValue<double> checkCertificationNumberOpacity = TValue(0.0);
  TValue<double> passwordOpacity = TValue(0.0);
  TValue<double> passwordConfirmOpacity = TValue(0.0);

  final emailController = TextEditingController(text:"imkim189371@gmail.com");
  final certificationNumberController = TextEditingController();

  _AuthPageState state;

  AuthPageComponent(this.state);

  AuthPageService get s => state.s;

  Widget body() {
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
      body: SingleChildScrollView(
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
                onTrailingTap: s.sendCertificationNumber,
                controller: emailController),
            const SizedBox(height: 30),
            inputBox(
                label: "인증번호",
                trailing: "인증 확인",
                onTrailingTap: s.checkCertificationNumber,
                opacity: checkCertificationNumberOpacity,
                controller: certificationNumberController),
            const SizedBox(height: 30),
            inputBox(label: "비밀번호", opacity: passwordOpacity),
            const SizedBox(height: 30),
            inputBox(label: "비밀번호 확인", opacity: passwordConfirmOpacity),
          ],
        ),
      ),
    );
  }

  Widget inputBox({
    required String label,
    String? trailing,
    GestureTapCallback? onTrailingTap,
    TValue<double>? opacity,
    TextEditingController? controller,
  }) {
    return AnimatedOpacity(
      opacity: opacity?.v ?? 1,
      duration: const Duration(milliseconds: 1200),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: TextField(controller: controller, )),
                ...trailing != null
                    ? [
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
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
  bool sendEmail = false;

  _AuthPageState state;

  AuthPageService(this.state);

  AuthPageComponent get c => state.c;

  void sendCertificationNumber() async {
    if(sendEmail) return;
    sendEmail = true;

    String email = c.emailController.text;

    bool haveAlreadyEmail = false;
    try {
      await FireauthUtil.register(email: email, password: UUIDUtil.makeUuid());
    } on CommonException catch (e) {
      if (e.code == "email-already-in-use") {
        haveAlreadyEmail = true;
      }
      else {
        LogUtil.error("예상치 못한 에러 발생 ${e.code}");
        return;
      }
    }

    if(haveAlreadyEmail) {
      //로그인 시키기
      LogUtil.info("로그인하도록 UI 컨트롤");
      return;
    }

    await FireauthUtil.sendEmailVerification();

    c.checkCertificationNumberOpacity.v = 1.0;
    state.rebuild();
  }

  void checkCertificationNumber() {
    //TODO: 로직 넣기 필요
    c.passwordOpacity.v = 1.0;
    c.passwordConfirmOpacity.v = 1.0; //회원가입이면 같이 보여줌
    state.rebuild();
  }
}
