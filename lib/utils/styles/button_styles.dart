import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonStyles {

  ButtonStyles._();

  static TextStyle buttonStyleBlue = GoogleFonts.roboto(
      fontSize: 14, color: Colors.white, letterSpacing: 1.25);

  static TextStyle buttonStyleWhite = GoogleFonts.robotoCondensed(
      fontSize: 14, color: Colors.blue, letterSpacing: 1.25);



  static TextStyle buttonStyleWhiteBold = GoogleFonts.robotoCondensed(
      fontSize: 14, color: Colors.blue, letterSpacing: 1.25,fontWeight: FontWeight.bold);

  static TextStyle buttonStyleGreen = GoogleFonts.robotoCondensed(
      fontSize: 14, color: Colors.green, letterSpacing: 1.25);
}
