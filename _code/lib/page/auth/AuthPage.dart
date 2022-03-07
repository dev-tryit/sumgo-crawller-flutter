import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/_common/abstract/KDHState.dart';
import 'package:kdh_homepage/_common/model/TValue.dart';
import 'package:kdh_homepage/_common/model/WidgetToGetSize.dart';
import 'package:kdh_homepage/util/MyColors.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends KDHState<AuthPage> {
  @override
  bool isPage() => true;

  @override
  List<WidgetToGetSize> makeWidgetListToGetSize() => [];

  @override
  void mustRebuild() {
    widgetToBuild = () {
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
                label: "휴대 전화번호",
                trailing: "인증 요청",
                onTrailingTap: () {
                  print("a");
                },
              ),
              const SizedBox(height: 30),
              inputBox(
                label: "인증번호",
                trailing: "인증 확인",
                onTrailingTap: () {
                  print("a");
                },
              ),
              const SizedBox(height: 30),
              inputBox(
                label: "비밀번호",
                onTrailingTap: () {
                  print("a");
                },
              ),
              const SizedBox(height: 30),
              inputBox(
                label: "비밀번호 확인",
                onTrailingTap: () {
                  print("a");
                },
              ),
            ],
          ),
        ),
      );
    };
    rebuild();
  }

  Widget inputBox({
    required String label,
    String? trailing,
    GestureTapCallback? onTrailingTap,
    TValue<double>? opacity,
  }) {
    return AnimatedOpacity(
      opacity: opacity?.v ?? 0,
      duration: const Duration(seconds: 2),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(child: TextField()),
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

  @override
  Future<void> afterBuild() async {}

  @override
  Future<void> onLoad() async {}
}
