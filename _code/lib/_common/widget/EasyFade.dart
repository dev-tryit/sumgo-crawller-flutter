import 'dart:async';

import 'package:flutter/material.dart';

class EasyFade extends StatefulWidget {
  final Widget child;
  const EasyFade({Key? key,required this.child}) : super(key: key);

  @override
  _EasyFadeState createState() => _EasyFadeState();
}

class _EasyFadeState extends State<EasyFade> {
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    if (opacity == 0) {
      Timer(const Duration(milliseconds: 500), () {
        opacity = 1;
        setState(() {});
      });
    }
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 800),
      child: widget.child,
    );
  }
}
