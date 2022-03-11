
import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/_common/model/WidgetToGetSize.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';

abstract class KDHService<STATE extends KDHState, COMPONENT> {
  final STATE _state;
  final COMPONENT c;

  BuildContext get context => _state.context;
  VoidCallback get rebuild => _state.rebuild;
  Size get screenSize => _state.screenSize;
  Map<dynamic, WidgetToGetSize> get widgetMap => _state.widgetMap;
  set widgetToBuild(Widget Function() widgetToBuild) => _state.widgetToBuild = widgetToBuild;

  KDHService(this._state, this.c);
}