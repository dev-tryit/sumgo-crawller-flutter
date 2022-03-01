import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdh_homepage/util/MyColors.dart';

class MyRedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const MyRedButton(this.text, {Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.gothicA1(
          color: MyColors.white,
          fontSize: 12.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: MyColors.black,
        elevation: 7,
        padding:
        const EdgeInsets.only(left: 23, right: 23, top: 14, bottom: 14),
        primary: MyColors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
