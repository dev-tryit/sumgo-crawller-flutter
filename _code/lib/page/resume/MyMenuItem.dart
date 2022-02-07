import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/widget/Menu.dart';

class MyMenuItem extends MenuItem {
  String imagePath;
  String label;

  MyMenuItem(this.imagePath, this.label,
      {required Color selectedColor, required Color unselectedColor})
      : super(selectedColor, unselectedColor);
}
