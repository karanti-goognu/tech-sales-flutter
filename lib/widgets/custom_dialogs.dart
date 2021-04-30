import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/cancel_event.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/RejectionLeadScreen.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CustomDialogs {

  Widget errorDialog(String message) {
    print(message);
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

  Widget messageDialogMWP(String message) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
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
              Get.offNamed(Routes.HOME_SCREEN);
            },
          ),
        ],
      ),
    );
  }

  Widget redirectToLoginDialog(String message) {
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
            Get.offNamed(Routes.LOGIN);
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

  Widget showDialogSubmitLead(String message) {
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
            Get.toNamed(Routes.HOME_SCREEN);
          },
        ),
      ],
    );
  }

  // Widget showCancelEventDialog(String heading, String message) {
  //   return AlertDialog(
  //     content: SingleChildScrollView(
  //       child: ListBody(
  //         children: <Widget>[
  //           Text(heading,
  //           style: GoogleFonts.roboto(
  //               fontSize: 20,
  //               height: 1.4,
  //               letterSpacing: .25,
  //               fontWeight: FontWeight.bold,
  //               color: ColorConstants.inputBoxHintColorDark),),
  //           Text(
  //             message,
  //             style: GoogleFonts.roboto(
  //                 fontSize: 16,
  //                 height: 1.4,
  //                 letterSpacing: .25,
  //                 fontStyle: FontStyle.normal,
  //                 color: ColorConstants.inputBoxHintColorDark),
  //           ),
  //         ],
  //       ),
  //     ),
  //     actions: <Widget>[
  //       TextButton(
  //         child: Text(
  //           'NO',
  //           style: GoogleFonts.roboto(
  //               fontSize: 20,
  //               letterSpacing: 1.25,
  //               fontStyle: FontStyle.normal,
  //               color: ColorConstants.buttonNormalColor),
  //         ),
  //         onPressed: () {
  //           Get.back();
  //         },
  //       ),
  //       TextButton(
  //         child: Text(
  //           'YES',
  //           style: GoogleFonts.roboto(
  //               fontSize: 20,
  //               letterSpacing: 1.25,
  //               fontStyle: FontStyle.normal,
  //               color: ColorConstants.buttonNormalColor),
  //         ),
  //         onPressed: () {
  //           Get.back();
  //           Get.to(() => CancelEvent(), binding: EGBinding());
  //           //Get.toNamed(Routes.CANCEL_EVENT);
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget showStartEventDialog(String heading, String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(heading,
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  height: 1.4,
                  letterSpacing: .25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.inputBoxHintColorDark),),
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
            'NO',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
           // Get.toNamed(Routes.CANCEL_EVENT);
            //Get.toNamed(Routes.HOME_SCREEN);
          },
        ),
        TextButton(
          child: Text(
            'YES',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            Get.toNamed(Routes.START_EVENT);
          },
        ),
      ],
    );
  }

  Widget showExistingLeadDialog(String message, BuildContext context,
      SaveLeadRequestModel saveLeadRequestModel, List<File> imageList) {
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
            gv.saveLeadRequestModelNew = saveLeadRequestModel;
            gv.imageList = imageList;

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

  showUpdatedLeadDialog(String s, BuildContext context) {
    Get.back();
    Get.toNamed(Routes.VIEW_OLD_LEAD_SCREEN);
  }

  Widget showRejectionConfirmationDialog(String message, BuildContext context,
      ViewLeadDataResponse viewLeadDataResponse) {
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
                    builder: (BuildContext context) =>
                        RejectionLeadScreen(viewLeadDataResponse)));
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

  Widget showExistingTSODialog(String respMsg, BuildContext context,
      SaveLeadRequestModel saveLeadRequestModel, List<File> imageList) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              respMsg,
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
            'YES',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            Get.lazyPut<AddLeadsController>(() {
              return AddLeadsController(
                  repository: MyRepositoryLeads(
                      apiClient: MyApiClientLeads(httpClient: http.Client())));
            });
            AddLeadsController _addLeadsController = Get.find();
            saveLeadRequestModel.isStatus = "true";
            _addLeadsController.getAccessKeyAndSaveLead(
                saveLeadRequestModel, imageList, context);
          },
        ),
        TextButton(
          child: Text(
            'NO',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
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
}
