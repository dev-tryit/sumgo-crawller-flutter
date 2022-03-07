import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/util/MyColors.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 36),
            Text(
              "숨고 매니저",
              style: GoogleFonts.blackHanSans(
                fontSize: 35,
                color: MyColors.deepBlue,
              ),
            ),
            inputBox(),
          ],
        ),
      ),
    );
  }

  Widget inputBox() {
    return Column(
      children: [
        Text("휴대 전화번호"),
        Row(
          children: [
            Expanded(
              child: TextField(),
            ),
            Text("인증 요청"),
          ],
        ),
      ],
    );
  }
}
