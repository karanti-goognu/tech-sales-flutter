import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static TextStyle formfieldLabelText = TextStyle(
      fontFamily: "Muli",
      color: ColorConstants.inputBoxHintColorDark,
      fontWeight: FontWeight.normal,
      fontSize: ScreenUtil().setSp(16));

  static TextStyle formfieldLabelTextDark = TextStyle(
      fontFamily: "Muli",
      color: Colors.black,
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

  static TextStyle muliBold25 = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: "Muli");

  static TextStyle mulliBoldBlue = TextStyle(
      color: ColorConstants.darkBlue,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static TextStyle mulliBold14 = TextStyle(
      color: ColorConstants.blackColorFilter,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 14,
      fontWeight: FontWeight.bold);

  static TextStyle mulliBold16 = TextStyle(
      color: ColorConstants.blackColorFilter,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 16,
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

  static TextStyle robotoBtn14 = GoogleFonts.roboto(
      color: ColorConstants.clearAllTextColor,
      fontSize: 14,
      letterSpacing: .14,
      fontWeight: FontWeight.normal);

  static TextStyle mulliBoldYellow18 = TextStyle(
      color: ColorConstants.clearAllTextColor,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 18,
      fontWeight: FontWeight.bold);

  static TextStyle mulliSemiBoldCancelStyle = TextStyle(
      color: ColorConstants.cancelRed,
      fontFamily: "Muli-Bold.ttf",
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static TextStyle enterMsgTextStyle16 = TextStyle(
      fontFamily: "Muli",
      fontSize: 16,
      letterSpacing: .5,
      color: const Color(0xFF000000).withOpacity(0.6));

  static TextStyle appBarTitleStyle = TextStyle(
      fontFamily: "Muli",
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 22.0);

  static TextStyle titleGreenStyle = TextStyle(
      fontFamily: "Muli",
      color: ColorConstants.greenTitle,
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil().setSp(20));
  
  static TextStyle btnWhite = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil().setSp(15));

  static TextStyle btnBlue = TextStyle(
      color: ColorConstants.btnBlue,
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil().setSp(15)
  );

  static TextStyle btnOrange = TextStyle(
      color: ColorConstants.btnOrange,
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil().setSp(15)
  );


  static TextStyle mulliRegular14Italic = TextStyle(
      color: Colors.blueAccent,
      fontFamily: "Muli.ttf",
      fontSize: 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.normal);

  static TextStyle contactTextStyle = TextStyle(
      fontFamily: "Muli",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      letterSpacing: .25,
      color: ColorConstants.clearAllTextColor);

  static TextStyle muliBoldOrange17 = TextStyle(
      color: ColorConstants.btnOrange,
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil().setSp(17));


}

