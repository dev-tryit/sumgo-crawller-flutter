import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/util/SizeUtil.dart';

class WidgetToGetSize {
  String label;
  late Widget Function() makeWidget;
  GlobalKey key = GlobalKey();
  late Size size;
  late double width;
  late double height;

  WidgetToGetSize(this.label, Widget Function(GlobalKey key) makeWidget) {
    this.makeWidget = () {
      return makeWidget(key);
    };
  }

  void calculateSize() {
    size = SizeUtil.getSizeByKey(key);
    width = size.width;
    height = size.height;
    print("[$label] size: $size");
  }
}
