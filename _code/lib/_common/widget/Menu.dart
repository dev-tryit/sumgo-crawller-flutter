import 'package:flutter/material.dart';
import 'package:kdh_homepage/page/resume/MyMenu.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';

abstract class MenuItem {
  final Color highlightColor;
  final Color normalColor;
  final ValueNotifier isClick;
  final ValueNotifier iconColor;

  void click() {
    isClick.value = true;
    setColor(highlightColor);
  }

  void unclick() {
    isClick.value = false;
    setColor(normalColor);
  }

  void setColor(Color color) {
    iconColor.value = color;
  }

  MenuItem(this.highlightColor, this.normalColor)
      : isClick = ValueNotifier(false),
        iconColor = ValueNotifier(normalColor);
}

class Menu<T extends MenuItem> extends StatefulWidget {
  final List<T> itemList;
  final Widget Function(T item) itemWidgetBuilder;
  final Widget Function(List<Widget> itemWidgetList) menuWidgetBuilder;
  const Menu({
    Key? key,
    required this.itemList,
    required this.itemWidgetBuilder,
    required this.menuWidgetBuilder,
  }) : super(key: key);

  @override
  _MenuState<T> createState() => _MenuState<T>();
}

class _MenuState<T extends MenuItem> extends State<Menu<T>> {
  List<Widget> itemWidgetList = [];

  @override
  void initState() {
    itemWidgetList.clear();
    for (var item in widget.itemList) {
      itemWidgetList.add(widget.itemWidgetBuilder(item));
      item.isClick.addListener(() {
        if (!item.isClick.value) return;

        for (var element in widget.itemList) {
          if (element != item) {
            element.unclick();
          }
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.menuWidgetBuilder(itemWidgetList);
  }
}
