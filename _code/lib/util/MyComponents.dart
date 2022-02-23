import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:kdh_homepage/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyComponents {
  MyComponents._();

  static DateTime? _lastClickDateTime;

  static Widget scaffold({required Widget body}) {
    return SafeArea(
      child: Scaffold(
        body: body,
      ),
    );
  }

  static Widget verticalScroll({
    required List<Widget> children,
    bool showScrollbar = false,
  }) {
    ScrollController _scrollController = ScrollController();
    Widget returnWidget = SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

    if (showScrollbar) {
      returnWidget = Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: returnWidget);
    }

    return returnWidget;
  }

  static Widget horizontalScroll({
    required List<Widget> children,
    bool showScrollbar = false,
    bool useWheelScrool = false,
  }) {
    ScrollController _scrollController = ScrollController();
    Widget returnWidget = SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );

    if (showScrollbar) {
      returnWidget = Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: returnWidget);
    }

    if (useWheelScrool) {
      returnWidget = Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            _scrollController.animateTo(
              _scrollController.offset + pointerSignal.scrollDelta.dy * 1.1,
              duration: const Duration(
                  milliseconds:
                      100), //다음 스크롤까지 딜레이를 주는 개념으로 볼 수 있다, 부드러운 느낌을 줄 수 있음
              curve: Curves.ease, //가장 노멀하게 부드러운 것 같음.
            );
          }
        },
        child: returnWidget,
      );
    }

    return returnWidget;
  }

  static Widget horizontalListView({
    required List<Widget> children,
    bool showScrollbar = false,
    bool useWheelScrool = false,
  }) {
    ScrollController _scrollController = ScrollController();
    Widget returnWidget = ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: children,
    );

    if (showScrollbar) {
      returnWidget = Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          child: returnWidget);
    }

    if (useWheelScrool) {
      returnWidget = Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            _scrollController.animateTo(
              _scrollController.offset + pointerSignal.scrollDelta.dy * 1.1,
              duration: const Duration(
                  milliseconds:
                      100), //다음 스크롤까지 딜레이를 주는 개념으로 볼 수 있다, 부드러운 느낌을 줄 수 있음
              curve: Curves.ease, //가장 노멀하게 부드러운 것 같음.
            );
          }
        },
        child: returnWidget,
      );
    }

    return returnWidget;
  }

  static Widget webPage({
    required List<Widget> widgetList,
    required Size
        screenSize, //scroll 내에 scroll이 중첩되기 위해서는, 반드시 둘 중 하나의 스크롤에 크기가 정해져있어야 한다. 그래야, 에러가 안난다.
    double? containerWidth,
    bool showHorizontalScrollbar = true,
    bool showVerticalScrollbar = true,
  }) {
    return scaffold(
      body: bidirectionalScroll(
        widgetList: widgetList,
        screenSize: screenSize,
        containerWidth: containerWidth,
        showHorizontalScrollbar: showHorizontalScrollbar,
        showVerticalScrollbar: showVerticalScrollbar,
      ),
    );
  }

  static Widget bidirectionalScroll({
    required List<Widget> widgetList,
    required Size
        screenSize, //scroll 내에 scroll이 중첩되기 위해서는, 반드시 둘 중 하나의 스크롤에 크기가 정해져있어야 한다. 그래야, 에러가 안난다.
    double? containerWidth,
    bool showHorizontalScrollbar = true,
    bool showVerticalScrollbar = true,
  }) {
    Widget child;
    if (containerWidth != null) {
      child = Center(
        child: SizedBox(
          width: containerWidth,
          height: screenSize.height,
          child: horizontalScroll(
            showScrollbar: showHorizontalScrollbar,
            children: [
              SizedBox(
                width: containerWidth,
                height: screenSize.height,
                child: verticalScroll(
                  showScrollbar: showVerticalScrollbar,
                  children: widgetList,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      child = SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: horizontalScroll(
          showScrollbar: showHorizontalScrollbar,
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: verticalScroll(
                showScrollbar: showVerticalScrollbar,
                children: widgetList,
              ),
            ),
          ],
        ),
      );
    }

    return child;
  }

  static Widget text({
    GlobalKey? key,
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
      key: key,
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
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  static Widget noItems({double? height}) {
    Widget child = Center(
      child: MyComponents.text(fontSize: 16, text: "항목이 없습니다"),
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
        child: MyComponents.text(
            fontSize: 16,
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
        child: MyComponents.text(
            fontSize: 16, text: text, softWrap: softWrap, color: Colors.grey),
        onPressed: onPressed,
      ),
    );
  }
}
