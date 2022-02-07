
import 'package:flutter/material.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';

class Menu<T> extends StatefulWidget {
  final List<T> itemList;
  final Widget Function(List<T> itemList) menuBuilder;
  final void Function(List<T> itemList) addListnerOnMenuClick;
  const Menu(
      {Key? key,
      required this.itemList,
      required this.menuBuilder,
      required this.addListnerOnMenuClick})
      : super(key: key);

  @override
  _MenuState<T> createState() => _MenuState<T>();
}

class _MenuState<T> extends State<Menu<T>> {
  late bool isInit;

  @override
  void initState() {
    isInit = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      isInit = true;
      widget.addListnerOnMenuClick(widget.itemList);
    }

    return widget.menuBuilder(widget.itemList);
  }
}

class EachMenuItem {
  static const Color selectedColor = MyColors.lightBlue;
  static const Color unselectedColor = MyColors.ligthGray;

  String imagePath;
  String label;
  ValueNotifier iconColor = ValueNotifier(unselectedColor);
  ValueNotifier isClick = ValueNotifier(false);

  void click() {
    isClick.value = true;
    iconColor.value = selectedColor;
  }

  void unclick() {
    isClick.value = false;
    iconColor.value = unselectedColor;
  }

  EachMenuItem(this.imagePath, this.label);
}

class EachMenu extends StatefulWidget {
  final EachMenuItem item;
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
          widget.item.iconColor.value = EachMenuItem.selectedColor;
          return;
        }

        widget.item.iconColor.value = EachMenuItem.unselectedColor;
      },
      onEnter: (event) {
        widget.item.iconColor.value = EachMenuItem.selectedColor;
      },
    );

    return returnWidget;
  }
}
