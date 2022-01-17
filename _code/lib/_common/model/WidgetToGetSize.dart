
import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/util/SizeUtil.dart';

class WidgetToGetSize {
  String label;
  late Widget Function() makeWidget;
  GlobalKey key = GlobalKey();
  Size? size;

  WidgetToGetSize(this.label, Widget Function(GlobalKey key) makeWidget) {
    this.makeWidget = () {
      return makeWidget(key);
    };
  }

  void calculateSize() {
    size = SizeUtil.getSizeByKey(key);
    print("[$label] size: $size");
  }
}