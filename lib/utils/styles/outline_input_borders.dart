import 'package:flutter/material.dart';

class InputBordersDecorations {

  InputBordersDecorations._();

  static OutlineInputBorder outLineInputBorderFocused = OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
  );

  static OutlineInputBorder outLineInputBorderError = OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
  );

  static OutlineInputBorder outLineInputBorderEnabled = OutlineInputBorder(
    borderSide: BorderSide(
        color: const Color(0xFF000000).withOpacity(0.4),
        width: 1.0),
  );
}
