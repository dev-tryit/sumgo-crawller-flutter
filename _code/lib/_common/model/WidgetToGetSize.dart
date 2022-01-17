import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/util/SizeUtil.dart';

class WidgetToGetSize<T> {
  Enum key;
  late Widget Function() makeWidget;
  final _globalKey = GlobalKey();
  late Size size;
  late double width;
  late double height;

  WidgetToGetSize(this.key, Widget Function(GlobalKey key) makeWidget) {
    this.makeWidget = () {
      return makeWidget(_globalKey);
    };
  }

  void calculateSize() {
    size = SizeUtil.getSizeByKey(_globalKey);
    width = size.width;
    height = size.height;
    print("[$key] size: $size");
  }
}
