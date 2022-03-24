import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class AnimationUtil{

  static Widget bounce(
      {required Widget child,
      Duration duration = const Duration(milliseconds: 100),
      required VoidCallback onPressed}) {
    return Bounce(
      onPressed:onPressed,
      duration: duration,
      child: child,
    );
  }
}