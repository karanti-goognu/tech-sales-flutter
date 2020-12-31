import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle formfieldLabelText = TextStyle(
      fontFamily: "Muli",
      color: ColorConstants.inputBoxHintColorDark,
      fontWeight: FontWeight.normal,
      fontSize: 16.0);

  static TextStyle resendOtpTextStyleEnabled = TextStyle(
      fontFamily: "Muli",
      fontSize: 14,
      decoration: TextDecoration.underline,
      letterSpacing: .25,
      color: ColorConstants.buttonNormalColor);

  static TextStyle resendOtpTextStyleNormal = TextStyle(
      fontFamily: "Muli",
      fontSize: 14,
      letterSpacing: .25,
      color: ColorConstants.darkTextColor);

  static TextStyle welcomeMsgTextStyle20 = TextStyle(
      color: ColorConstants.darkTextColor,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 20,
      letterSpacing: .30,
      fontWeight: FontWeight.bold);

  static TextStyle phoneNumberTextStyle16 = TextStyle(
      color: ColorConstants.darkTextColor,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 16,
      letterSpacing: .30,
      fontWeight: FontWeight.bold);

  static TextStyle mulliBold18 = TextStyle(
      color: ColorConstants.blackColorFilter,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static TextStyle mulliBold14 = TextStyle(
      color: ColorConstants.blackColorFilter,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 14,
      fontWeight: FontWeight.bold);

  static TextStyle mulliRegular14 = TextStyle(
      color: ColorConstants.blackColorFilter,
      fontFamily: "Muli.ttf",
      fontSize: 14,
      fontWeight: FontWeight.normal);

  static TextStyle robotoRegular14 = GoogleFonts.roboto(
      color: ColorConstants.fromDateColor,
      fontSize: 14,
      letterSpacing: .25,
      fontWeight: FontWeight.normal);

  static TextStyle robotoBold16 = GoogleFonts.roboto(
      color: ColorConstants.fromDateColor,
      fontSize: 16,
      letterSpacing: .14,
      fontWeight: FontWeight.bold);

  static TextStyle mulliBoldYellow18 = TextStyle(
      color: ColorConstants.clearAllTextColor,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static TextStyle enterMsgTextStyle16 = TextStyle(
      fontFamily: "Muli",
      fontSize: 16,
      letterSpacing: .5,
      color: const Color(0xFF000000).withOpacity(0.6));
}
