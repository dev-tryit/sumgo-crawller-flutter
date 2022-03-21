
import 'package:flutter/material.dart';
import 'package:sumgo_crawller_flutter/_common/abstract/KDHState.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';

abstract class KDHComponent<State extends KDHState> {
  final State _state;
  VoidCallback get rebuild => _state.rebuild;
  BuildContext get context => _state.context;
  KDHComponent(this._state);
}