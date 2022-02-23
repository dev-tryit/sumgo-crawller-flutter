import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String id;
  String pw;
  double height;
  List habitList;
  String ageRange;
  bool isMan;

  User(
      this.id, this.pw, this.height, this.habitList, this.ageRange, this.isMan);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pw = json['pw'],
        height = json['height'],
        habitList = json['habitList'],
        ageRange = json['ageRange'],
        isMan = json['isMan'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pw': pw,
      'height': height,
      'habitList': habitList,
      'ageRange': ageRange,
      'isMan': isMan,
    };
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  String? id;
  String? pw;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '아이디를 입력해주세요',
                ),
                keyboardType: TextInputType.number, // 숫자 입력만
                onChanged: (value) {
                  id = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: pwController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '비밀번호를 입력해주세요',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  pw = value;
                },
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    String id = idController.text.trim();
                    String pw = pwController.text.trim();

                    if (id.isEmpty || pw.isEmpty) {
                      showMessage(context, "아이디 및 비밀번호를 입력해주세요");
                      return;
                    }

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    String key = "id_" + id;
                    if (prefs.containsKey(key)) {
                      String json = prefs.getString(key) ?? "{}";
                      User user = User.fromJson(jsonDecode(json));

                      setState(() {});
                      if (user.id == id && user.pw == pw) {
                        showMessage(context, "로그인 성공하였습니다.");
                        goPage(context, MainPage());
                      } else {
                        showMessage(context, "로그인 실패하였습니다.");
                      }
                    }
                  },
                  child: Text('로그인하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void goPage(BuildContext context, Widget child) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => child,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("mainPage"),
    );
  }
}