import 'package:flutter/material.dart';

abstract class KDHStatelessWidget extends StatelessWidget {
  bool _whenBuildCalledFirst = true;

  @override
  Widget build(BuildContext context) {
    if (_whenBuildCalledFirst) {
      _whenBuildCalledFirst = false;
      Future(() async {
        await afterBuild(context);
      });
    }

    return widgetToBuild(context);
  }

  Future<void> afterBuild(BuildContext context) async {}

  Widget widgetToBuild(BuildContext context);
}
