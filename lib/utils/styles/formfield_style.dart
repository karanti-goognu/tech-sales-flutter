import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/outline_input_borders.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';

abstract class FormFieldStyle {
  static TextStyle formFieldTextStyle = TextStyle(
      fontSize: 18,
      color: ColorConstants.inputBoxHintColor,
      fontFamily: "Muli");

  static InputDecoration buildInputDecoration({
    String labelText,
    Widget suffixIcon,
    Widget prefixIcon,
  }) {
    return InputDecoration(
      focusedBorder: InputBordersDecorations.outLineInputBorderFocused,
      enabledBorder: InputBordersDecorations.outLineInputBorderEnabled,
      errorBorder: InputBordersDecorations.outLineInputBorderError,
      labelText: labelText,
      filled: false,
      focusColor: Colors.black,
      isDense: false,
      labelStyle: TextStyles.formfieldLabelText,
      fillColor: ColorConstants.backgroundColor,
      suffixIcon: suffixIcon != null ? suffixIcon : null,
      prefixIcon: prefixIcon != null? prefixIcon :null,
    );
  }
}
