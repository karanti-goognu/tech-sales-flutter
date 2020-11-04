import 'dart:ui';

import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';

abstract class ColorConstants {

  //Hex Color
  static Color appBarColor = HexColor("#002A64");
  static Color backgroundColorBlue = HexColor("#0054A6");
  static Color backgroundColor = HexColor("#FFFFFF");
  static Color blackColor = HexColor("#2B2828");
  static Color lightBlackBorderColor = HexColor("#00001F");
  static Color checkinColor = HexColor("#8DC63F");



  //Color Constants
  static Color inputBoxHintColor = const Color(0x00000000).withOpacity(0.8);
  static Color inputBoxBorderSideColor = const Color(0xFF000000).withOpacity(0.4);
  static Color inputBoxHintColorDark = const Color(0x00000000).withOpacity(0.6);
  static Color buttonPressedColor = const Color(0x006200EE).withOpacity(1);
  static Color buttonNormalColor = const Color(0x001c99d4).withOpacity(1);
  static Color buttonDisableColor = const Color(0x0000000).withOpacity(0.3);
  static Color darkTextColor = const Color.fromRGBO(0, 0, 0, 0.87);
  static Color focusedInputTextColor = const Color.fromRGBO(141, 198, 63, 1);

}
