import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';

class MyRedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool useShadow;

  const MyRedButton(this.text,
      {Key? key, required this.onPressed, this.useShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyComponents.bounce(
      onPressed: onPressed,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: MyColors.red,
        shadowColor: useShadow ? MyColors.black : null,
        elevation: useShadow ? 7 : 0,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 23, right: 23, top: 8, bottom: 8),
          child: Text(
            text,
            style: MyFonts.gothicA1(
              color: MyColors.white,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }
}
