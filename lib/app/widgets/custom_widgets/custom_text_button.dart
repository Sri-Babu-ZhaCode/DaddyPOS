import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/themes.dart';

class CustomTextButton extends StatelessWidget {
  final String name;
  final double radius;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? splashColor;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton(
      {super.key,
      required this.name,
      this.radius = 5,
      this.onPressed,
      this.padding,
      this.backgroundColor,
      this.splashColor,
      this.borderColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(splashColor),
        padding: MaterialStateProperty.all(padding ?? const EdgeInsets.all(11)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        // shape: MaterialStateProperty.all(
        //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        // ),
        // side: MaterialStateProperty.all(
        //     BorderSide(color: borderColor ?? EBTheme.appPrimaryColor)),
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: GoogleFonts.poppins(
          color: textColor ?? EBTheme.kPrimaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}
