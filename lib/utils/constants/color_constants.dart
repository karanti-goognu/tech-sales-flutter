import 'dart:ui';

import 'package:flutter_tech_sales/core/functions/convert_to_hex.dart';

abstract class ColorConstants {

  //Hex Color
  static Color backgroundColor = HexColor("#FFFFFF");
  static Color blackColor = HexColor("#2B2828");
  static Color lightBlackBorderColor = HexColor("#00001F");

  //Color Constants
  static Color inputBoxHintColor = const Color(0x00000000).withOpacity(0.8);
  static Color inputBoxBorderSideColor = const Color(0xFF000000).withOpacity(0.4);
  static Color inputBoxHintColorDark = const Color(0x00000000).withOpacity(0.6);
  static Color buttonPressedColor = const Color(0x006200EE).withOpacity(1);
  static Color buttonNormalColor = const Color(0x001c99d4).withOpacity(1);

}
