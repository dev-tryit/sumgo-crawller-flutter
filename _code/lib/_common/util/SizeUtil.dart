import 'package:flutter/material.dart';

class SizeUtil {
  Size getSizeByContext(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    return size;
  }

  Size getSizeByKey(GlobalKey key) {
    if (key.currentContext != null) {
      return getSizeByContext(key.currentContext!);
    }

    return Size(0, 0);
  }
}