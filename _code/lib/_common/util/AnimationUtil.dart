import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimationUtil {
  static Widget bounceInDown(
      {required Widget child,
      Duration duration = const Duration(milliseconds: 100)}) {
    return BounceInUp(
      child: child,
    );
  }

  static Widget fadeOutLeft(
      {required Widget child,
      Duration duration = const Duration(milliseconds: 100),
      required VoidCallback onPressed}) {
    return FadeOutLeft(
      duration: duration,
      child: child,
    );
  }
}
