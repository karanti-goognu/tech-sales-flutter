import 'dart:convert';
import 'package:flutter/material.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SiteVisitWidget extends StatefulWidget {
  int siteId;
  ViewSiteDataResponse viewSiteDataResponse;
  MwpVisitModel mwpVisitModel;
  String siteDate;
  int visitSubTypeId;
  SiteOpportunityStatusEntity selectedOpportunitStatusEnity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;
  String visitRemarks;
  SiteVisitWidget(
      {this.mwpVisitModel,
       this.siteId,
        this.viewSiteDataResponse,
      this.siteDate,
      this.visitSubTypeId,
      this.selectedOpportunitStatusEnity,
      this.siteOpportunityStatusEntity,
      this.visitRemarks
      });
  _SiteVisitWidgetState createState() => _SiteVisitWidgetState();
}

class _SiteVisitWidgetState extends State<SiteVisitWidget> {

  LatLng _currentPosition;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String _remark, visitSubType;
  String selectedDateStringNext = 'Next visit date', typeValue = "PHYSICAL";
  SiteController _siteController = Get.find();
  SiteOpportunityStatusEntity _siteOpportunitStatusEnity;
  TextEditingController _siteTypeController = TextEditingController();
  TextEditingController _selectedVisitType = TextEditingController();
  String selectedDateString = DateFormat("yyyy-MM-dd").format(DateTime.now());
  bool _isStartButtonDisabled;
  bool _isEndButtonDisabled;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity =
  new List.empty(growable: true);
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();

  @override
  void initState() {
    super.initState();
    _isStartButtonDisabled = false;
    _isEndButtonDisabled = false;
    setData();
  }

  setData() {
    setState(() {
    viewSiteDataResponse = widget.viewSiteDataResponse;
    siteOpportunityStatusEntity = viewSiteDataResponse.siteOpportunityStatusEntity;
    if (viewSiteDataResponse.sitesModal.siteOppertunityId != null) {
      for (int i = 0; i < siteOpportunityStatusEntity.length; i++) {
        if (viewSiteDataResponse.sitesModal.siteOppertunityId.toString() ==
            siteOpportunityStatusEntity[i].id.toString()) {
          _siteOpportunitStatusEnity = siteOpportunityStatusEntity[i];
          _siteTypeController.text =
              siteOpportunityStatusEntity[i].opportunityStatus;
        }
      }
    } else {
      _siteOpportunitStatusEnity = siteOpportunityStatusEntity[0];
      _siteTypeController.text =
          siteOpportunityStatusEntity[0].opportunityStatus;
    }

    if (widget.mwpVisitModel != null) {
      if (widget.mwpVisitModel.nextVisitDate != null) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            widget.mwpVisitModel.nextVisitDate);
        var formattedDate = DateFormat("yyyy-MM-dd").format(date);
        selectedDateStringNext = "$formattedDate";
      } else {
        selectedDateStringNext = "Next visit date";
      }
      _siteTypeController.text = widget.mwpVisitModel.visitSubType;
      _selectedVisitType.text = widget.mwpVisitModel.visitType;
      selectedDateString = "${widget.mwpVisitModel.visitDate}";
    } else {
     // _siteTypeController.text = "";
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    final visitType = (widget.selectedOpportunitStatusEnity == null)
        ? DropdownButtonFormField(
            items: widget.siteOpportunityStatusEntity
                .map((label) => DropdownMenuItem(
                      child: Text(
                        label.opportunityStatus,
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                      ),
                      value: label.opportunityStatus,
                    ))
                .toList(),
            onChanged: (value) {},
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: "Opportunity Status",
            ),
          )
        : DropdownButtonFormField<SiteOpportunityStatusEntity>(
            value: widget.selectedOpportunitStatusEnity,
            items: [widget.selectedOpportunitStatusEnity]
                .map((label) => DropdownMenuItem(
                      child: Text(
                        label == null ? "" : label.opportunityStatus,
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                      ),
                      value: label,
                    ))
                .toList(),
            onChanged: (value) {},
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: "Opportunity Status",
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
            TsoLogger.printLog("In Start");
            if (!_isStartButtonDisabled) {
              _isStartButtonDisabled = true;
              _isEndButtonDisabled = false;
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _getCurrentLocationStart();
              }
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
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
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
    return SingleChildScrollView(
        //reverse: true,
        child: Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: (widget.mwpVisitModel == null)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //visitType,
                            TextFormField(
                              controller: _siteTypeController,
                              readOnly: true,
                              decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Opportunity Status",
                              ),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                            ),
                            SizedBox(height: 16),
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorConstants
                                            .inputBoxBorderSideColor)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: typeValue,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        typeValue = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'PHYSICAL',
                                      'VIRTUAL',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.roboto(
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                            SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: ColorConstants.lineColorFilter)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDateString,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.blackColor,
                                            fontFamily: "Muli"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // _selectDate(context);
                                        },
                                        child: Icon(
                                          Icons.calendar_today_sharp,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                onSaved: (val) {
                                  print('saved' + val);
                                  _remark = val;
                                },
                                onChanged: (_) {
                                  _remark = _.toString();
                                },
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                maxLines: 3,
                                decoration: _inputDecoration("Remarks", false)),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorConstants.buttonNormalColor,
                                  ),
                                  onPressed: () {
                                    TsoLogger.printLog("In Create");
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
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
                            ),
                            SizedBox(height: 50),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: _siteTypeController,
                              readOnly: true,
                              decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Opportunity Status",
                              ),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                            ),
                            SizedBox(height: 16),
                            ((widget.mwpVisitModel.visitStartTime != null &&
                                        widget.mwpVisitModel.visitEndTime ==
                                            null) ||
                                    (widget.mwpVisitModel.visitStartTime !=
                                            null &&
                                        widget.mwpVisitModel.visitEndTime !=
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
                                : Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorConstants
                                                .inputBoxBorderSideColor)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: typeValue,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            typeValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'PHYSICAL',
                                          'VIRTUAL',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.roboto(
                                                  color: ColorConstants
                                                      .inputBoxHintColorDark,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.0),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )),
                            SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: ColorConstants.lineColorFilter)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDateString,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.blackColor,
                                            fontFamily: "Muli"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // _selectDate(context);
                                        },
                                        child: Icon(
                                          Icons.calendar_today_sharp,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            // nextDate(),
                            // SizedBox(
                            //   height: 16,
                            // ),
                            (widget.mwpVisitModel.visitStartTime != null &&
                                    widget.mwpVisitModel.visitEndTime != null)
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
                                          widget.mwpVisitModel.remark,
                                          maxLines: null,
                                        ),
                                      ),
                                    ],
                                  )
                                : TextFormField(
                                    initialValue:
                                        widget.mwpVisitModel.remark == 'null'
                                            ? ''
                                            : widget.mwpVisitModel.remark,
                                    onSaved: (val) {
                                      print('saved' + val);
                                      widget.mwpVisitModel.remark = val;
                                    },
                                    onChanged: (_) {
                                      widget.mwpVisitModel.remark =
                                          _.toString();
                                    },
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    maxLines: 3,
                                    decoration:
                                        _inputDecoration("Remarks", false)),
                            SizedBox(
                              height: 16,
                            ),
                            (widget.mwpVisitModel.visitStartTime == null &&
                                    widget.mwpVisitModel.visitEndTime == null)
                                ? btnStart
                                : (widget.mwpVisitModel.visitStartTime !=
                                            null &&
                                        widget.mwpVisitModel.visitEndTime ==
                                            null)
                                    ? btnEnd
                                    : Container(),
                            SizedBox(height: 100),
                          ],
                        ),
                )
              ],
            )));
  }

  Widget nextDate() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
        border: Border.all(width: 1, color: ColorConstants.lineColorFilter),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDateStringNext,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.blackColor,
                    fontFamily: "Muli"),
              ),
              GestureDetector(
                onTap: () {
                  _selectDateNextVisit(context);
                },
                child: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.orange,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }


  _getCurrentLocation(int id) async {
    LocationDetails result = await GetCurrentLocation.getCurrentLocation();

    if (result != null) {
      setState(() {
        _currentPosition = result.latLng;
        btnCreatePressed(id);
      });
    }
  }

  SiteVisitResponseModel _siteVisitResponseModel;
  btnCreatePressed(int id) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String visitStartTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();

    if (widget.selectedOpportunitStatusEnity == null) {
      visitSubType = visitSubType;
    } else {
      visitSubType = widget.selectedOpportunitStatusEnity.opportunityStatus;
    }
    if (selectedDateStringNext == null ||
        selectedDateStringNext == "Next visit date") {
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
      "remark": _remark,
      "visitDate": selectedDateString,
      "visitEndLat": "",
      "visitEndLong": "",
      "visitEndTime": "",
      "visitOutcomes": "",
      "visitStartLat": '${_currentPosition.latitude}',
      "visitStartLong": '${_currentPosition.longitude}',
      "visitStartTime": visitStartTime,
      "visitSubType": visitSubType,
      "visitType": typeValue,
    });
    TsoLogger.printLog("Create: ${json.encode(_siteVisitRequestModel)}");
    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController
                  .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
                  .then((data) {
                if (data != null) {
                  setState(() {
                    _siteVisitResponseModel = data;
                    if (data.respCode == "MWP2028")
                      Get.dialog(showDialogSubmitSite(data.respMsg.toString()));
                    else {
                      Get.dialog(
                          CustomDialogs().errorDialog(data.respMsg.toString()),
                          barrierDismissible: false);
                    }
                  });
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


  _getCurrentLocationStart() async {
    LocationDetails result = await GetCurrentLocation.getCurrentLocation();

    if (result != null) {
      setState(() {
        _currentPosition = result.latLng;
        btnStartPressed();
      });
    }
  }

  btnStartPressed() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String visitStartTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    if (selectedDateStringNext == null ||
        selectedDateStringNext == "Next visit date") {
      selectedDateStringNext = '${widget.mwpVisitModel.nextVisitDate}';
    }
    SiteVisitRequestModel _siteVisitRequestModel =
        SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "dspAvailableQty": "",
      "eventType": "",
      "id": widget.mwpVisitModel.id,
      "isDspAvailable": "",
      "nextVisitDate": selectedDateStringNext,
      "referenceId": empId,
      "remark": widget.mwpVisitModel.remark,
      "visitDate": selectedDateString,
      "visitEndLat": "",
      "visitEndLong": "",
      "visitEndTime": "",
      "visitOutcomes": "",
      "visitStartLat": '${_currentPosition.latitude}',
      "visitStartLong": '${_currentPosition.longitude}',
      "visitStartTime": visitStartTime,
      "visitSubType": widget.mwpVisitModel.visitSubType,
      "visitType": typeValue,
    });

    TsoLogger.printLog("Start: ${json.encode(_siteVisitRequestModel)}");
    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController
                  .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
                  .then((data) {
                if (data != null) {
                  setState(() {
                    _siteVisitResponseModel = data;
                    if (data.respCode == "MWP2028")
                      Get.dialog(showDialogSubmitSite(data.respMsg.toString()));
                    else {
                      Get.dialog(
                          CustomDialogs().errorDialog(data.respMsg.toString()),
                          barrierDismissible: false);
                    }
                  });
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


  _getCurrentLocationEnd() async {
    LocationDetails result = await GetCurrentLocation.getCurrentLocation();

    if (result != null) {
      setState(() {
        _currentPosition = result.latLng;
        btnEndPressed();
      });
    }
  }


  btnEndPressed() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    if (selectedDateStringNext == null ||
        selectedDateStringNext == "Next visit date") {
      selectedDateStringNext = '${widget.mwpVisitModel.nextVisitDate}';
    }

    SiteVisitRequestModel _siteVisitRequestModel =
        SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "dspAvailableQty": "",
      "eventType": "",
      "id": widget.mwpVisitModel.id,
      "isDspAvailable": "",
      "nextVisitDate": selectedDateStringNext,
      "referenceId": empId,
      "remark": widget.mwpVisitModel.remark,
      "visitDate": selectedDateString,
      "visitEndLat": '${_currentPosition.latitude}',
      "visitEndLong": '${_currentPosition.longitude}',
      "visitEndTime": currentTime,
      "visitOutcomes": "",
      "visitStartLat": widget.mwpVisitModel.visitStartLat,
      "visitStartLong": widget.mwpVisitModel.visitStartLong,
      "visitStartTime": widget.mwpVisitModel.visitStartTime,
      "visitSubType": widget.mwpVisitModel.visitSubType,
      "visitType": widget.mwpVisitModel.visitType,
    });
    TsoLogger.printLog("End: ${json.encode(_siteVisitRequestModel)}");
    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController
                  .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
                  .then((data) {
                if (data != null) {
                  setState(() {
                    _siteVisitResponseModel = data;

                    if (data.respCode == "MWP2028")
                      Get.dialog(showDialogSubmitSite(data.respMsg.toString()));
                    else {
                      Get.dialog(
                          CustomDialogs().errorDialog(data.respMsg.toString()),
                          barrierDismissible: false);
                    }
                  });
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

  InputDecoration _inputDecoration(String labelText, bool suffixStatus) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      labelText: labelText,
      filled: true,
      suffixIcon: (suffixStatus == true)
          ? GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Icon(Icons.calendar_today_rounded,
                  color: Colors.deepOrangeAccent))
          : null,
      focusColor: Colors.black,
      labelStyle: GoogleFonts.roboto(
          color: ColorConstants.inputBoxHintColorDark,
          fontWeight: FontWeight.normal,
          fontSize: 16.0),
      fillColor: ColorConstants.backgroundColor,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateString = formattedDate;
      });
  }

  Future<void> _selectDateNextVisit(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateStringNext = formattedDate;
      });
  }

  getSiteData() async {
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _siteController.getAccessKeyOnly().then(
      (data) async {
        accessKeyModel = data;
        await _siteController
            .getSitedetailsData(accessKeyModel.accessKey, widget.siteId)
            .then(
          (data) async {
            viewSiteDataResponse = data;
            setState(() {
              widget.mwpVisitModel = viewSiteDataResponse.mwpVisitModel;
              widget.siteDate =
                  viewSiteDataResponse.sitesModal.siteCreationDate;
              widget.visitSubTypeId =
                  viewSiteDataResponse.sitesModal.siteOppertunityId;

              widget.siteOpportunityStatusEntity =
                  viewSiteDataResponse.siteOpportunityStatusEntity;
              widget.visitRemarks =
                  viewSiteDataResponse.sitesModal.siteClosureReasonText;

              if (viewSiteDataResponse.sitesModal.siteOppertunityId != null) {
                for (int i = 0;
                    i < viewSiteDataResponse.siteOpportunityStatusEntity.length;
                    i++) {
                  if (viewSiteDataResponse.sitesModal.siteOppertunityId
                          .toString() ==
                      viewSiteDataResponse.siteOpportunityStatusEntity[i].id
                          .toString()) {
                    widget.selectedOpportunitStatusEnity =
                        viewSiteDataResponse.siteOpportunityStatusEntity[i];
                  }
                }
              } else {
                widget.selectedOpportunitStatusEnity = null;
              }
              setData();
            });
          },
        );
      },
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
            setState(() {
              getSiteData();
            });
          },
        ),
      ],
    );
  }
}
