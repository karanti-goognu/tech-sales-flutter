import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogs {
  Future<void> showEmpIdAndNoNotMatchDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  StringConstants.empIdAndNoNotMatch,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      height: 1.4,
                      letterSpacing: .25,
                      fontStyle: FontStyle.normal,
                      color: ColorConstants.inputBoxHintColorDark),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    letterSpacing: 1.25,
                    fontStyle: FontStyle.normal,
                    color: ColorConstants.buttonNormalColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
