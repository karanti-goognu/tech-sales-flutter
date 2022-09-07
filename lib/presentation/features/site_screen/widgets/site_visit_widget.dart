import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';

class SiteVisitWidget extends StatefulWidget {
  final int? siteId;
  SiteVisitWidget({
    this.siteId,
  });
  _SiteVisitWidgetState createState() => _SiteVisitWidgetState();
}

class _SiteVisitWidgetState extends State<SiteVisitWidget> {
  LatLng? _currentPosition;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? visitSubType;
  String? selectedDateStringNext = 'Next visit date', typeValue = "PHYSICAL";
  bool isDataLoaded = false;
  SiteController _siteController = Get.find();
  TextEditingController _siteTypeController = TextEditingController();
  TextEditingController _selectedVisitType = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  String selectedDateString = DateFormat("yyyy-MM-dd").format(DateTime.now());
  late bool _isEndButtonDisabled;
  SiteOpportunityStatusEntity? selectedOpportunitStatusEnity;
  List<SiteOpportunityStatusEntity>? siteOpportunityStatusEntity =
      new List.empty(growable: true);
  ViewSiteDataResponse? viewSiteDataResponse = new ViewSiteDataResponse();

  @override
  void initState() {
    super.initState();
    _isEndButtonDisabled = false;
    getSiteData();
  }

  Future getEmpId() async {
    String? empID = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    empID = prefs.getString(StringConstants.employeeId);
    return empID;
  }

  getSiteData() async {

    AccessKeyModel accessKeyModel = await _siteController.getAccessKeyOnly();
    viewSiteDataResponse = await _siteController.getSitedetailsData(
        accessKeyModel.accessKey, widget.siteId);

    setData();
    setState(() {
      isDataLoaded = true;
    });
  }

  setData() {
    setState(() {
      siteOpportunityStatusEntity =
          viewSiteDataResponse!.siteOpportunityStatusEntity;
      if (viewSiteDataResponse!.sitesModal!.siteOppertunityId != null) {
        for (int i = 0; i < siteOpportunityStatusEntity!.length; i++) {
          if (viewSiteDataResponse!.sitesModal!.siteOppertunityId.toString() ==
              siteOpportunityStatusEntity![i].id.toString()) {
            _siteTypeController.text =
                siteOpportunityStatusEntity![i].opportunityStatus!;
          }
        }
      } else {
        _siteTypeController.text =
            siteOpportunityStatusEntity![0].opportunityStatus!;
      }

      if (viewSiteDataResponse!.mwpVisitModel != null) {
        if (viewSiteDataResponse!.mwpVisitModel!.nextVisitDate != null) {
          var date = DateTime.fromMillisecondsSinceEpoch(
              viewSiteDataResponse!.mwpVisitModel!.nextVisitDate!);
          var formattedDate = DateFormat("yyyy-MM-dd").format(date);
          selectedDateStringNext = "$formattedDate";
        } else {
          selectedDateStringNext = "Next visit date";
        }

        if (viewSiteDataResponse!.mwpVisitModel!.remark == null ||
            viewSiteDataResponse!.mwpVisitModel!.remark == "null") {
          _remarkController.text = '';
        } else {
          _remarkController.text = viewSiteDataResponse!.mwpVisitModel!.remark!;
        }
        _siteTypeController.text =
            viewSiteDataResponse!.mwpVisitModel!.visitSubType!;
        _selectedVisitType.text =
            viewSiteDataResponse!.mwpVisitModel!.visitType!;
        selectedDateString =
            "${viewSiteDataResponse!.mwpVisitModel!.visitDate!}";
      } else {
        // _siteTypeController.text = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
      minTextAdapt: true,
    );

    final opportunityTxt = TextFormField(
      controller: _siteTypeController,
      readOnly: true,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Opportunity Status",
      ),
      style: TextStyle(
          fontSize: 18,
          color: ColorConstants.inputBoxHintColor,
          fontFamily: "Muli"),
    );

    final remarkTxt = TextFormField(
      controller: _remarkController,
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Remark",
      ),
    );

    final visitType = Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            border: Border.all(color: ColorConstants.inputBoxBorderSideColor)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: typeValue,
            onChanged: (String? newValue) {
              setState(() {
                typeValue = newValue;
              });
            },
            items: <String>[
              'PHYSICAL',
              'VIRTUAL',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.roboto(
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                ),
              );
            }).toList(),
          ),
        ));

    final date = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
          border: Border.all(width: 1, color: ColorConstants.lineColorFilter)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDateString,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.blackColor,
                    fontFamily: "Muli"),
              ),
              Icon(
                Icons.calendar_today_sharp,
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );

    final btnStart = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorConstants.buttonNormalColor,
          ),
          onPressed: () {
            TsoLogger.printLog("In Create");
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _getCurrentLocation(0);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'START',
              style: ButtonStyles.buttonStyleBlue,
            ),
          ),
        )
      ],
    );

    final btnEnd = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorConstants.buttonNormalColor,
          ),
          onPressed: () {
            TsoLogger.printLog("In End");
            if (!_isEndButtonDisabled) {
              _isEndButtonDisabled = true;
              if (_formKey.currentState!.validate()) {
                Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
                _formKey.currentState!.save();
                _getCurrentLocationEnd();
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'END',
              style: ButtonStyles.buttonStyleBlue,
            ),
          ),
        )
      ],
    );

    return
      !isDataLoaded?
      Center(child: CircularProgressIndicator(),) :
      SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: (viewSiteDataResponse!.mwpVisitModel == null)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            opportunityTxt,
                            SizedBox(height: 16),
                            visitType,
                            SizedBox(height: 16),
                            date,
                            SizedBox(
                              height: 16,
                            ),
                            remarkTxt,
                            SizedBox(
                              height: 16,
                            ),
                            btnStart,
                            SizedBox(height: 50),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            opportunityTxt,
                            SizedBox(height: 16),
                            ((viewSiteDataResponse!.mwpVisitModel!
                                                .visitStartTime !=
                                            null &&
                                        viewSiteDataResponse!
                                                .mwpVisitModel!.visitEndTime ==
                                            null) ||
                                    (viewSiteDataResponse!.mwpVisitModel!
                                                .visitStartTime !=
                                            null &&
                                        viewSiteDataResponse!
                                                .mwpVisitModel!.visitEndTime !=
                                            null))
                                ? TextFormField(
                                    controller: _selectedVisitType,
                                    style: FormFieldStyle.formFieldTextStyle,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(),
                                  )
                                : visitType,
                            SizedBox(height: 16),
                            date,
                            SizedBox(
                              height: 16,
                            ),
                            (viewSiteDataResponse!
                                            .mwpVisitModel!.visitStartTime !=
                                        null &&
                                    viewSiteDataResponse!
                                            .mwpVisitModel!.visitEndTime !=
                                        null)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Remark',
                                        style:
                                            TextStyles.formfieldLabelTextDark,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 8,
                                            right: 8),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors
                                                  .grey, // Set border color
                                              width: 1.0), // Set border width
                                        ),
                                        child: Text(
                                          _remarkController.text,
                                          maxLines: null,
                                        ),
                                      ),
                                    ],
                                  )
                                : remarkTxt,
                            SizedBox(
                              height:16,
                            ),
                            (viewSiteDataResponse!.mwpVisitModel!.visitStartTime != null && viewSiteDataResponse!.mwpVisitModel!.visitEndTime == null)
                                ? btnEnd
                                : Container(),
                            SizedBox(height:100),
                          ],
                        ),
                )
              ],
            )));
  }

  _getCurrentLocation(int id) async {
    LocationDetails result = await GetCurrentLocation.getCurrentLocation();
      setState(() {
        _currentPosition = result.latLng;
        btnCreatePressed(id);
      });
  }

  btnCreatePressed(int id) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String visitStartTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    if (selectedDateStringNext == null || selectedDateStringNext == "Next visit date") {
      selectedDateStringNext = "";
    }
    SiteVisitRequestModel _siteVisitRequestModel =
        SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "dspAvailableQty": "",
      "eventType": "",
      "id": id,
      "isDspAvailable": "",
      "nextVisitDate": selectedDateStringNext,
      "referenceId": empId,
      "remark": _remarkController.text,
      "visitDate": selectedDateString,
      "visitEndLat": "",
      "visitEndLong": "",
      "visitEndTime": "",
      "visitOutcomes": "",
      "visitStartLat": '${_currentPosition!.latitude}',
      "visitStartLong": '${_currentPosition!.longitude}',
      "visitStartTime": visitStartTime,
      "visitSubType": _siteTypeController.text,
      "visitType": typeValue,
    });
    TsoLogger.printLog("Create: ${json.encode(_siteVisitRequestModel)}");
    apiCall(_siteVisitRequestModel);
  }

  _getCurrentLocationEnd() async {
    LocationDetails result = await GetCurrentLocation.getCurrentLocation();
      setState(() {
        _currentPosition = result.latLng;
        btnEndPressed();
      });
  }

  btnEndPressed() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    if (selectedDateStringNext == null ||
        selectedDateStringNext == "Next visit date") {
      selectedDateStringNext =
          '${viewSiteDataResponse!.mwpVisitModel!.nextVisitDate}';
    }

    SiteVisitRequestModel _siteVisitRequestModel =
        SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "dspAvailableQty": "",
      "eventType": "",
      "id": viewSiteDataResponse!.mwpVisitModel!.id,
      "isDspAvailable": "",
      "nextVisitDate": selectedDateStringNext,
      "referenceId": empId,
      "remark": _remarkController.text,
      "visitDate": selectedDateString,
      "visitEndLat": '${_currentPosition!.latitude}',
      "visitEndLong": '${_currentPosition!.longitude}',
      "visitEndTime": currentTime,
      "visitOutcomes": "",
      "visitStartLat": viewSiteDataResponse!.mwpVisitModel!.visitStartLat,
      "visitStartLong": viewSiteDataResponse!.mwpVisitModel!.visitStartLong,
      "visitStartTime": viewSiteDataResponse!.mwpVisitModel!.visitStartTime,
      "visitSubType": viewSiteDataResponse!.mwpVisitModel!.visitSubType,
      "visitType": viewSiteDataResponse!.mwpVisitModel!.visitType,
    });
    TsoLogger.printLog("End: ${json.encode(_siteVisitRequestModel)}");
    apiCall(_siteVisitRequestModel);
  }

  apiCall(SiteVisitRequestModel _siteVisitRequestModel) {
    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController
                  .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
                  .then((data) {
                if (data != null) {
                  setState(() {
                    if (data.respCode == "MWP2028")
                      Get.dialog(showDialogSubmitSite(data.respMsg.toString()));
                    else {
                      Get.dialog(
                          CustomDialogs.showMessage(data.respMsg.toString()),
                          barrierDismissible: false);
                    }
                  });
                  getSiteData();
                }
              })
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
            }
        });
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
            setState(() {
              getSiteData();
            });
          },
        ),
      ],
    );
  }
}
