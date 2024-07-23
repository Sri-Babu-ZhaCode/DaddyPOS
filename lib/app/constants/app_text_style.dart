import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'themes.dart';

class EBAppTextStyle {
  static final heading1 = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: EBTheme.kPrimaryColor,
  );
  static final heading2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static final bodyText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const billItemsText = TextStyle(
    fontFamily: 'TimesNewRoman',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  // static final billItemStyle = GoogleFonts.poppins(
  //   fontSize: 15,
  //   fontWeight: FontWeight.w500,
  // );
  static final avtiveTxt = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: EBTheme.greenColor,
  );

  static final totalAmt = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final button = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle txtStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle catStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.blue,
  );
  static final TextStyle subStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.blue,
  );
  static final TextStyle printBtn = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFFFFFFF),
  );
  static final TextStyle appBarTxt = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFFFFFFF),
  );
  static final TextStyle itemTxt = GoogleFonts.poppins(
    color: EBTheme.blue,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static final TextStyle billQty = GoogleFonts.poppins(
    fontSize: 30,
  );

  static TextStyle customeTextStyle(
      {double? fontSize, FontWeight? fontWeigh, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeigh,
      color: color,
    );
  }

  static TextStyle customeTextStyleWTNR(
      {double? fontSize, FontWeight? fontWeigh, Color? color}) {
    return TextStyle(
      fontFamily: 'TimesNewRoman',
      fontSize: fontSize,
      fontWeight: fontWeigh,
      color: color,
    );
  }
}
