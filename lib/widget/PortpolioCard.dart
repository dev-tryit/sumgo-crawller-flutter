import 'package:flutter/material.dart';

class PortpolioCard extends StatelessWidget {
  final int index;

  const PortpolioCard(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal[100 * (index % 9)],
      child: Text(
        'Grid Item ${index + 1}',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
