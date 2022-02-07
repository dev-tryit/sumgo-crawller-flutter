import 'package:flutter/material.dart';
import 'package:kdh_homepage/_common/widget/Menu.dart';
import 'package:kdh_homepage/util/MyColors.dart';
import 'package:kdh_homepage/util/MyComponents.dart';

class MyMenuItem extends MenuItem {
  String imagePath;
  String label;

  MyMenuItem(this.imagePath, this.label,
      {required Color selectedColor, required Color unselectedColor})
      : super(selectedColor, unselectedColor);
}

class MyMenu extends StatefulWidget {
  final MyMenuItem item;
  const MyMenu(this.item, {Key? key}) : super(key: key);

  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
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
