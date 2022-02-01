import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/all_events.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/cancel_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/end_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/events.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/RejectionLeadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/edit_visit_view.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/KittyBagsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen_new.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

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
            // Get.back();
            Get.back();
          },
        ),
      ],
    );
  }

  Widget errorDialogForEvent(String message) {
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
              //Get.toNamed(Routes.VISIT_VIEW_SCREEN);
              Get.offNamed(Routes.HOME_SCREEN);
            },
          ),
        ],
      ),
    );
  }

  Widget messageDialogMWPCreate(String message) {
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
              Get.toNamed(Routes.ADD_MWP_SCREEN);
            },
          ),
        ],
      ),
    );
  }

  Widget messageDialogSRC(String message) {
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
              //Get.offNamed(Routes.HOME_SCREEN);
              Get.toNamed(Routes.SERVICE_REQUESTS);
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

  Widget showDialogSubmitEvent(String message) {
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
            //Get.back();
            Get.toNamed(Routes.EVENTS_GIFTS);
            //Get.toNamed(Routes.ALL_EVENTS);
            // Navigator.push(
            //     context, new CupertinoPageRoute(
            //     builder: (BuildContext context) =>
            //         Events(tabIndex: 1,))
            // );
          },
        ),
      ],
    );
  }

  Widget showDialogSubmitSite(String message) {
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
            //Get.back();
            Get.toNamed(Routes.SITES_SCREEN);
            // Navigator.push(
            //     context,
            //     new CupertinoPageRoute(
            //         builder: (BuildContext context) =>
            //             ViewSiteScreenNew(siteId: siteId,tabIndex: 0,)));
          },
        ),
      ],
    );
  }

  Widget showDialogSubmitInfluencer(String message) {
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
            //Get.back();
            Get.toNamed(Routes.INFLUENCER_LIST);
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


  Widget showDialogRestrictSystemBack(String message) {
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
            Get.back();
          },
        ),
      ],
     ),
    );
  }

  Widget showDialogInfPresent(String message) {
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

  Widget showDialogInfNotPresent(String message) {
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
            'Cancel',
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
            'Add Influencer',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            Get.toNamed(Routes.ADD_INFLUENCER);
          },
        ),
      ],
    );
  }

  Widget showDialogSubmitLead(String message,int from,BuildContext context) {
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

            if(from==3){
              Get.back();
               //Get.offAll(Routes.HOME_SCREEN);
              Get.offAndToNamed(Routes.HOME_SCREEN);
            }else if(from==4){
              Get.back();
              Get.back();
              Get.offAndToNamed(Routes.LEADS_SCREEN);
            }else if(from==2){
             Get.back();
             Get.back();
             Get.back();
   // Get.offAndToNamed(Routes.LEADS_SCREEN);
    }
            else {
               // Get.back();
              Get.offAndToNamed(Routes.LEADS_SCREEN);
            }
            //Below line was commented for leads screen, if it's being use somewhere else, please consider.. s s
//            Get.toNamed(Routes.HOME_SCREEN);
          },
        ),
      ],
    );
  }

  Widget showSaveChangesDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // Text(heading,
            // style: GoogleFonts.roboto(
            //     fontSize: 20,
            //     height: 1.4,
            //     letterSpacing: .25,
            //     fontWeight: FontWeight.bold,
            //     color: ColorConstants.inputBoxHintColorDark),),
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
            Get.back();
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
          },
        ),
      ],
    );
  }

  Widget showStartEventDialog(String heading, String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              heading,
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  height: 1.4,
                  letterSpacing: .25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
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

  Widget showCommentDialog(String respMsg, BuildContext context, int eventId) {
    var _commentController = TextEditingController();
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
            SizedBox(height: 16),
            TextFormField(
              controller: _commentController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Comment ';
                }

                return null;
              },
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.backgroundColorBlue,
                      //color: HexColor("#0000001F"),
                      width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF000000).withOpacity(0.4),
                      width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Comment",
                filled: false,
                focusColor: Colors.black,
                labelStyle: TextStyle(
                    fontFamily: "Muli",
                    color: ColorConstants.inputBoxHintColorDark,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0),
                fillColor: ColorConstants.backgroundColor,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'SUBMIT',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            Get.dialog(
                CustomDialogs().showCommentConfirmDialog(
                    "Are you sure ? Once you end the event, you can not modify it.",
                    eventId,
                    _commentController.text),
                barrierDismissible: false);
          },
        ),
        TextButton(
          child: Text(
            'CLOSE',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget showCommentConfirmDialog(
      String message, int eventId, String eventComment) {
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
            'NO',
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
            'YES',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            _getCurrentLocation(eventId, eventComment);
          },
        ),
      ],
    );
  }

  _getCurrentLocation(int eventId, String eventComment) async {
    AllEventController _eventController = Get.find();
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String currentDateString = formatter.format(date);
    print("DateFormat--" + currentDateString);
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.back();
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      Get.dialog(Center(
        child: CircularProgressIndicator(),
      ));
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        _eventController
            .submitEndEventDetail(eventId, eventComment, currentDateString,
                position.latitude, position.longitude)
            .then((value) => {
                  if (value.respCode == "DM1002")
                    {
                      print('RESPONSE : ${value.respMsg + value.respCode}'),
                      // Get.toNamed(Routes.END_EVENT),
                      Get.dialog(
                          CustomDialogs()
                              .showMessage1(value.respMsg, 0, eventId),
                          barrierDismissible: false)
                    }
                  else
                    {
                      Get.back(),
                      Get.dialog(
                          CustomDialogs()
                              .showMessage1(value.respMsg, 1, eventId),
                          barrierDismissible: false)
                    }
                });
      }).catchError((e) {
        Get.back();
        Get.dialog(CustomDialogs().errorDialog(
            "Access to location data denied "));
        print(e);
      });
    }
  }

  Widget showMessage1(String message, int from, int eventId) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // Text(heading,
            // style: GoogleFonts.roboto(
            //     fontSize: 20,
            //     height: 1.4,
            //     letterSpacing: .25,
            //     fontWeight: FontWeight.bold,
            //     color: ColorConstants.inputBoxHintColorDark),),
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
            if (from == 0) {
              Get.to(() => EndEvent(eventId, 0), binding: EGBinding());
            } else {
              Get.back();
            }
          },
        ),
      ],
    );
  }

  Widget showMessage(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // Text(heading,
            // style: GoogleFonts.roboto(
            //     fontSize: 20,
            //     height: 1.4,
            //     letterSpacing: .25,
            //     fontWeight: FontWeight.bold,
            //     color: ColorConstants.inputBoxHintColorDark),),
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

  Widget appUpdateDialog(String message, String appId, String platform) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              "App Update",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  height: 1.4,
                  letterSpacing: .25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
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
            'Ignore',
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
        TextButton(
          child: Text(
            'Update',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            print("Go To Store");
           // StoreRedirect.redirect(androidAppId: "com.dalmia.flutter_tech_sales", iOSAppId: "1554988271");
            if(platform == "IOS"){
              StoreRedirect.redirect(androidAppId: "", iOSAppId: appId);
            }else{
              StoreRedirect.redirect(androidAppId: appId, iOSAppId: "");
            }
          },
        ),
      ],
    );
  }

  Widget appForceUpdateDialog(String message, String appId, String platform) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              "App Update",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  height: 1.4,
                  letterSpacing: .25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
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
            'Update',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
           // StoreRedirect.redirect(androidAppId: "com.dalmia.flutter_tech_sales", iOSAppId: "1554988271");
            if(platform == "IOS"){
              StoreRedirect.redirect(androidAppId: "", iOSAppId: appId);
            }else{
              StoreRedirect.redirect(androidAppId: appId, iOSAppId: "");
            }
          },
        ),
      ],
    );
  }

  Widget appUserInactiveDialog(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            // Text(
            //   "App Update",
            //   style: GoogleFonts.roboto(
            //       fontSize: 20,
            //       height: 1.4,
            //       letterSpacing: .25,
            //       fontWeight: FontWeight.bold,
            //       color: ColorConstants.inputBoxHintColorDark),
            // ),
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
          onPressed: () async{

            print("IN function");
            Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
            final SharedPreferences prefs = await _prefs;
            prefs.clear();
            // Get.back();
            // Get.back();
            exit(0);
           // SystemNavigator.pop();
           //  Future.delayed(const Duration(milliseconds: 1000), () {
           //    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
           //  });
          },
        ),
      ],
    );
  }

  Widget showPendingSupplyData(String message) {
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
            //Get.back();
            Get.offAllNamed(Routes.HOME_SCREEN);
          },
        ),
      ],
    );
  }


  Widget showCancelEventDialog(int eventId,String heading, String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              heading,
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  height: 1.4,
                  letterSpacing: .25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
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
            Get.to(() => CancelEvent(eventId), binding: EGBinding());
            //Get.toNamed(Routes.CANCEL_EVENT);
          },
        ),
      ],
    );
  }


  Widget showDialogForKittiPoints(KittyBagsListModel _kittyBagsListModel, BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width*0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
         // child: Column(
            children: <Widget>[
              Text(
                "Kitty Bags",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    height: 1.4,
                    letterSpacing: .25,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.inputBoxHintColorDark),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Product",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          height: 1.4,
                          letterSpacing: .25,
                          fontStyle: FontStyle.normal,
                          color: ColorConstants.inputBoxHintColorDark),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Reserved",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          height: 1.4,
                          letterSpacing: .25,
                          fontStyle: FontStyle.normal,
                          color: ColorConstants.inputBoxHintColorDark),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Claimable",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          height: 1.4,
                          letterSpacing: .25,
                          fontStyle: FontStyle.normal,
                          color: ColorConstants.inputBoxHintColorDark),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _kittyBagsListModel.response.kittyPointsList.length,
                itemBuilder:(context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          _kittyBagsListModel.response.kittyPointsList[index].productName,
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              height: 1.4,
                              letterSpacing: .25,
                              fontStyle: FontStyle.normal,
                              color: ColorConstants.inputBoxHintColorDark),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${_kittyBagsListModel.response.reservePoolList[index].kittyBags}',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              height: 1.4,
                              letterSpacing: .25,
                              fontStyle: FontStyle.normal,
                              color: ColorConstants.inputBoxHintColorDark),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${_kittyBagsListModel.response.kittyPointsList[index].kittyBags}',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              height: 1.4,
                              letterSpacing: .25,
                              fontStyle: FontStyle.normal,
                              color: ColorConstants.inputBoxHintColorDark),
                        ),
                      ),
                    ],
                  );
                })
             ],
          ),
      ),
      //),
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
            //Get.back();
          },
        ),
      ],
    );
  }

  Widget redirectToSamePg(String message) {
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
            //Get.back();
            AddEventController _addEventController = Get.find();
            AppController _appController = Get.find();
            print("2 Waheguru");

            _addEventController.viewVisitData(_appController.accessKeyResponse.accessKey);
           // Get.back();
            // Navigator.push(
            //     context, new CupertinoPageRoute(
            //     builder: (BuildContext context) =>
            //         EditEventVisit())
            // );
            // Get.to(() => DetailViewEvent(eventId), binding: EGBinding());
          },
        ),
      ],
    );
  }

  Widget redirectToViewEventPg(String message) {
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
            Get.toNamed(Routes.VISIT_VIEW_SCREEN);

          },
        ),
      ],
    );
  }

}
