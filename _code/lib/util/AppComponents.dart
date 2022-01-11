import 'package:kdh_homepage/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppComponents {
  static DateTime? _lastClickDateTime;

  static Widget scaffold({required Widget body}) {
    return SafeArea(
      child: Scaffold(
        body: body,
      ),
    );
  }

  static Widget webPage({
    required List<Widget> widgetList,
    double? containerWidth,
    double? containerHeight,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return scaffold(
      body: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SizedBox(
            width: containerWidth,
            height: containerHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgetList,
            ),
          ),
        ],
      ),
    );
  }

  static text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    double? fontSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        height: textHeight ?? 1.555555555555556,
      ),
      overflow: overflow,
    );
  }

  static Text size22Text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppComponents.text(
      text: text,
      fontSize: 22,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      textHeight: textHeight,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Text size18Text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppComponents.text(
      text: text,
      fontSize: 18,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      textHeight: textHeight,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Text size16Text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppComponents.text(
      text: text,
      fontSize: 16,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      textHeight: textHeight,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Text size14Text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppComponents.text(
      text: text,
      fontSize: 14,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      textHeight: textHeight,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Text size12Text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppComponents.text(
      text: text,
      fontSize: 12,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      textHeight: textHeight,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static size9Text({
    required String text,
    TextAlign? textAlign,
    Color? color,
    double? textHeight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    bool? softWrap,
  }) {
    return AppComponents.text(
      text: text,
      fontSize: 9,
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      textHeight: textHeight,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static TransitionBuilder easyLoadingBuilder() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..progressColor = Colors.white
      ..indicatorColor = Colors.white
      ..backgroundColor = Colors.grey
      ..textColor = Colors.white
      ..toastPosition = EasyLoadingToastPosition.center
      ..fontSize = 16
      ..radius = 25
      ..dismissOnTap = false
      ..userInteractions = true;
    // ..customAnimation = CustomAnimation();

    return EasyLoading.init();
  }

  static void toastInfo(BuildContext context, String text) {
    // text = StringUtil.addCharAtPosition(text, "\n", 25, repeat: true);

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.blue
      ..textColor = Colors.white
      ..toastPosition = EasyLoadingToastPosition.center
      ..fontSize = 10
      ..radius = 25
      ..dismissOnTap = false
      ..userInteractions = true;

    EasyLoading.showToast(text);
  }

  static void toastError(BuildContext context, String? text,
      {int durationMilliseocnds = 1500}) {
    // text = StringUtil.addCharAtPosition(text, "\n", 25, repeat: true);

    EasyLoading.instance
      ..displayDuration = Duration(milliseconds: durationMilliseocnds)
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.red
      ..textColor = Colors.white
      ..toastPosition = EasyLoadingToastPosition.center
      ..fontSize = 10
      ..radius = 25
      ..dismissOnTap = false
      ..userInteractions = true;

    EasyLoading.showToast(text ?? "에러가 발생하였습니다");
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    EasyLoading.instance
      // ..displayDuration = const Duration(milliseconds: 2000)
      ..radius = 8
      ..loadingStyle = EasyLoadingStyle.dark
      ..dismissOnTap = false
      ..userInteractions = false;

    await EasyLoading.show(
      status: "조금만 기다려주세요",
      maskType: EasyLoadingMaskType.black,
    );
  }

  static Future<void> dismissLoadingDialog() async {
    return await EasyLoading.dismiss();
  }

  static void snackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  static void modalDialog(BuildContext context, {required Widget page}) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return page;
      },
    );
  }

  static void transparentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            margin:
                const EdgeInsets.only(top: 32, bottom: 32, left: 24, right: 24),
            width: double.infinity,
            height: double.infinity,
            child: Text("content"),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("test"),
            ),
          ],
        );
      },
    );
  }

  static Widget _buttonToPreventMultipleClicks(
      {VoidCallback? onPressed, ButtonStyle? style, required Widget? child}) {
    return ElevatedButton(
      style: style,
      child: child,
      onPressed: () {
        DateTime now = DateTime.now();
        if (_lastClickDateTime != null &&
            _lastClickDateTime!.difference(now).inMilliseconds.abs() <
                Setting.milliSecondsForPreventingMultipleClicks) {
          return;
        }
        _lastClickDateTime = now;

        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }

  static Widget buttonDefault(
      {required Widget child, required VoidCallback? onPressed}) {
    return _buttonToPreventMultipleClicks(
      child: child,
      onPressed: onPressed,
    );
  }

  static Widget loadingWidget() {
    return Center(
      child: Container(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget noItems({double? height}) {
    Widget child = Center(
      child: AppComponents.size16Text(text: "항목이 없습니다"),
    );

    if (height != null) {
      child = SizedBox(
        height: height,
        child: child,
      );
    }

    return child;
  }

  static Widget buttonWhite(String text,
      {bool? softWrap, double? width, required VoidCallback? onPressed}) {
    bool isActive = onPressed != null;
    return SizedBox(
      width: width ?? double.infinity,
      height: 48,
      child: _buttonToPreventMultipleClicks(
        style: ElevatedButton.styleFrom(
          primary: isActive ? Colors.white : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              width: 1,
              color: isActive ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        child: size16Text(
            text: text,
            softWrap: softWrap,
            color: isActive ? Colors.blue : Colors.grey),
        onPressed: onPressed,
      ),
    );
  }

  static Widget buttonGray(String text,
      {bool? softWrap, double? width, VoidCallback? onPressed}) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 48,
      child: _buttonToPreventMultipleClicks(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          primary: Colors.white,
        ),
        child: size16Text(text: text, softWrap: softWrap, color: Colors.grey),
        onPressed: onPressed,
      ),
    );
  }
}
