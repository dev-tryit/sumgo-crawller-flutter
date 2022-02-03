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

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  String message = "";

  bool isMan = false;
  String ageRange = "";
  double height = 100.0;
  List<String> habitList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("MainPage")),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              makeTextFieldWithLabel("아이디", idController),
              makeTextFieldWithLabel("비밀번호", pwController),
              makeHobby(),
              makeAge(),
              makeSex(),
              makeHeight(),
              ElevatedButton(
                child: Text("회원가입하기"),
                onPressed: () async {
                  String id = idController.text;
                  String pw = pwController.text;

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  String key = "id_" + id;
                  if (!prefs.containsKey(key)) {
                    prefs.setString(
                        key,
                        jsonEncode(
                            User(id, pw, height, habitList, ageRange, isMan)
                                .toJson()));
                  } else {
                    String json = prefs.getString(key) ?? "{}";
                    print(json);
                    User user = User.fromJson(jsonDecode(json));

                    message = "이미 해당 회원이 존재합니다.";
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 30),
              Text(message, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeHeight() {
    return makeWidgetWithLabel(
      "키",
      Slider(
        value: height,
        min: 100.0,
        max: 210.0,
        onChanged: (value) {
          height = value;
          setState(() {});
        },
      ),
    );
  }

  Widget makeSex() {
    return makeWidgetWithLabel(
      "남자인가요?",
      EasySwitch(
        onChanged: (value) => this.isMan = value,
      ),
    );
  }

  Widget makeAge() {
    return makeWidgetWithLabel(
      "나이대",
      EasyRadioBox(
        radioValueList: [
          "10~20대",
          "20~30대",
          "30~40대",
        ],
        onChanged: (value) => this.ageRange = value,
      ),
    );
  }

  Widget makeHobby() {
    return makeWidgetWithLabel(
      "취미",
      Column(
        children: [
          makeWidgetWithLabel(
            "노래",
            EasyCheckbox(onChanged: (value) {
              if (value) {
                if (!habitList.contains("노래")) habitList.add("노래");
              } else {
                habitList.remove("노래");
              }
              print(habitList);
            }),
          ),
          makeWidgetWithLabel(
            "수영",
            EasyCheckbox(onChanged: (value) {
              if (value) {
                if (!habitList.contains("수영")) habitList.add("수영");
              } else {
                habitList.remove("수영");
              }
              print(habitList);
            }),
          ),
          makeWidgetWithLabel(
            "독서",
            EasyCheckbox(onChanged: (value) {
              if (value) {
                if (!habitList.contains("독서")) habitList.add("독서");
              } else {
                habitList.remove("독서");
              }
              print(habitList);
            }),
          ),
        ],
      ),
    );
  }

  Widget makeTextFieldWithLabel(
      String label, TextEditingController controller) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: controller,
          ),
        ),
      ],
    );
  }

  Widget makeWidgetWithLabel(String label, Widget widget) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 20),
        Expanded(child: widget),
      ],
    );
  }
}

class EasyCheckbox extends StatefulWidget {
  void Function(bool value) onChanged;

  EasyCheckbox({required this.onChanged});

  @override
  _EasyCheckboxState createState() => _EasyCheckboxState();
}

class _EasyCheckboxState extends State<EasyCheckbox> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        if (value != null) {
          isChecked = value;
          widget.onChanged(value);
          setState(() {});
        }
      },
    );
  }
}

class EasyRadioBox extends StatefulWidget {
  List radioValueList;
  void Function(dynamic value) onChanged;

  EasyRadioBox({required this.radioValueList, required this.onChanged});

  @override
  _EasyRadioBoxState createState() => _EasyRadioBoxState();
}

class _EasyRadioBoxState extends State<EasyRadioBox> {
  dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    for (int i = 0; i < widget.radioValueList.length; i++) {
      dynamic radioValue = widget.radioValueList[i];
      widgetList.add(Row(
        children: [
          Text(radioValue),
          Radio<dynamic>(
            groupValue: groupValue,
            value: radioValue,
            onChanged: (value) {
              groupValue = value;
              widget.onChanged(value);
              setState(() {});
            },
          ),
        ],
      ));
    }

    return Row(
      children: widgetList,
    );
  }
}

class EasySwitch extends StatefulWidget {
  void Function(bool value) onChanged;

  EasySwitch({required this.onChanged});

  @override
  _EasySwitchState createState() => _EasySwitchState();
}

class _EasySwitchState extends State<EasySwitch> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isChecked,
      onChanged: (value) {
        isChecked = value;
        widget.onChanged(value);
        setState(() {});
      },
    );
  }
}
