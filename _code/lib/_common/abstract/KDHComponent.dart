
import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';

abstract class KDHComponent<State extends KDHState> {
  final State _state;
  void rebuild({Function? afterBuild}) => _state.rebuild(afterBuild: afterBuild);
  BuildContext get context => _state.context;
  KDHComponent(this._state);
}