import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sumgo_crawller_flutter/util/MyColors.dart';
import 'package:sumgo_crawller_flutter/util/MyComponents.dart';
import 'package:sumgo_crawller_flutter/util/MyFonts.dart';

class MyWhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyWhiteButton(this.text, {Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 20),
        child: Material(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: MyColors.black, width: 0.6),
            borderRadius: BorderRadius.circular(4),
          ),
          color: MyColors.white,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: MyComponents.bounceButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: MyFonts.gothicA1(
                  color: MyColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
