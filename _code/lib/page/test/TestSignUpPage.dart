import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestSignUpPage extends StatefulWidget {
  const TestSignUpPage({Key? key}) : super(key: key);

  @override
  _TestSignUpPageState createState() => _TestSignUpPageState();
}

class _TestSignUpPageState extends State<TestSignUpPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final pwConfirmController = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입 페이지"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: "아이디를 입력해주세요"),
          ),
          TextField(
            controller: pwController,
            obscureText: true,
            decoration: InputDecoration(hintText: "비밀번호를 입력해주세요"),
          ),
          TextField(
            controller: pwConfirmController,
            obscureText: true,
            decoration: InputDecoration(hintText: "비밀번호 확인을 입력해주세요"),
          ),
          ElevatedButton(
            onPressed: onRegisterButtonPressed,
            child: Text("회원가입"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message),
            ],
          ),
        ],
      ),
    );
  }

  void onRegisterButtonPressed() async {
    String email = idController.text;
    String pw = pwController.text;
    String pwConfirm = pwConfirmController.text;

    if (email.isEmpty || !EmailValidator.validate(email)) {
      showMessage(context, "이메일 형식이 잘못되었습니다. 다시 입력해주세요.");
      return;
    }

    if (pw.length <= 8) {
      showMessage(context, "비밀번호가 8글자 이하여서, 다시 입력해주세요.");
      return;
    }

    if (pw != pwConfirm) {
      showMessage(context, "비밀번호 확인이 다릅니다. 다시 입력해주세요.");
      return;
    }

    await saveMyAccount(email, pw);
  }

  Future<void> saveMyAccount(String email, String pw) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pw);
      showMessage(context, "회원가입 완료되었습니다");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMessage(context, "비밀번호 형식이 안전하지 않습니다");
      } else if (e.code == 'email-already-in-use') {
        showMessage(context, "이미 ID가 있습니다");
      } else if (e.code == 'invalid-email') {
        showMessage(context, "이메일이 형식이 잘못되었습니다");
      } else if (e.code == 'too-many-requests') {
        showMessage(context, "잠시 후에 다시 시도해주세요");
      } else if (e.code == 'network-request-failed') {
        showMessage(context, "네트워크 요청이 실패하였습니다");
      } else if (e.code == 'internal-error') {
        showMessage(context, "에러가 발생하였습니다");
      } else {
        showMessage(context, "에러가 발생하였습니다 ${e.code}");
      }
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
