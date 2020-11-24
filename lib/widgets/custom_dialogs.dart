import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/RejectionLeadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/ViewLeadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/ViewOldLeadScreen.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogs {
  Widget errorDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
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
            Get.back();
          },
        ),
      ],
    );
  }

  Widget appExitDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
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
            'CANCEL',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
           SystemNavigator.pop();
          },
        ),
      ],
    );
  }

  Widget showDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
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
           Get.back();
           Get.back();
          },
        ),
      ],
    );
  }

  Widget showExistingLeadDialog(String message, BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
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
            'VIEW OLD LEAD',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
             Get.back();
            Get.toNamed(Routes.VIEW_OLD_LEAD_SCREEN);
            // Navigator.push(
            //     context,
            //     new CupertinoPageRoute(
            //         builder: (BuildContext context) => ViewLeadScreen(100042)));
          },
        ),
      ],
    );
  }

  Widget showUpdatedLeadDialog(String s, BuildContext context) {
    Get.back();
    Get.toNamed(Routes.VIEW_OLD_LEAD_SCREEN);

  }


  Widget showRejectionConfirmationDialog(String message, BuildContext context, ViewLeadDataResponse viewLeadDataResponse) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
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
            'Yes',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
               // fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            Navigator.push(
                        context,
                        new CupertinoPageRoute(
                            builder: (BuildContext context) => RejectionLeadScreen(viewLeadDataResponse)));
          },
        ),
        TextButton(
          child: Text(
            'NO',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                //  fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
Get.back();
          },
        ),
      ],
    );
  }
}
