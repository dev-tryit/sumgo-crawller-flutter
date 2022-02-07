import 'package:flutter/material.dart';
import 'package:kdh_homepage/page/resume/MyMenuItem.dart';
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

class EachMenu extends StatefulWidget {
  final MyMenuItem item;
  const EachMenu(this.item, {Key? key}) : super(key: key);

  @override
  _EachMenuState createState() => _EachMenuState();
}

class _EachMenuState extends State<EachMenu> {
  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    setRebuildConditionIfEmpty();
    super.initState();
  }

  void setRebuildConditionIfEmpty() {
    widget.item.iconColor.addListener(() {
      rebuild();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget = Container(
      width: 91,
      height: 91,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyColors.white, width: 0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: widget.item.iconColor.value,
              // backgroundImage: AssetImage(widget.item.imagePath),
            ),
          ),
          const SizedBox(height: 7),
          MyComponents.text(
              text: widget.item.label, fontSize: 12, color: MyColors.white),
        ],
      ),
    );

    returnWidget = GestureDetector(
      onTap: () {
        widget.item.click();
      },
      child: returnWidget,
    );

    returnWidget = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: returnWidget,
      onExit: (event) {
        if (widget.item.isClick.value) {
          widget.item.setColor(widget.item.highlightColor);
        } else {
          widget.item.setColor(widget.item.normalColor);
        }
      },
      onEnter: (event) {
        widget.item.setColor(widget.item.highlightColor);
      },
    );

    return returnWidget;
  }
}
