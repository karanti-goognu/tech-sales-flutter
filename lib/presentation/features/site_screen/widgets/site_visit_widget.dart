import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteVisitWidget extends StatefulWidget {
  MwpVisitModel mwpVisitModel;
  int siteId;
  String siteDate;
  SiteController _siteController = Get.find();
  SiteOpportunityStatusEntity selectedOpportunitStatusEnity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;
  String visitRemarks;
  SiteVisitWidget(
      {this.mwpVisitModel,
      this.siteId,
      this.siteDate,
      this.selectedOpportunitStatusEnity,
      this.siteOpportunityStatusEntity,
      this.visitRemarks});
  _SiteVisitWidgetState createState() => _SiteVisitWidgetState();
}

class _SiteVisitWidgetState extends State<SiteVisitWidget> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition = new Position();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String _remark, visitSubType;

  String selectedDateStringNext = 'Next visit date',
      typeValue = "PHYSICAL",
      selectedDateString;
  SiteController _siteController = Get.find();
  TextEditingController _siteTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    if (widget.mwpVisitModel != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(widget.mwpVisitModel.nextVisitDate);
      var formattedDate = DateFormat("yyyy-MM-dd").format(date);
      _siteTypeController.text = widget.mwpVisitModel.visitSubType;
      selectedDateString = "${widget.mwpVisitModel.visitDate}";
      selectedDateStringNext = "${formattedDate}";
    } else {
      _siteTypeController.text = "";
      selectedDateString = "Visit Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    final visitType = DropdownButtonFormField(
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
      onChanged: (value) {
        setState(() {
          visitSubType = value;
          print(visitSubType);
        });
      },
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Opportunity Status",
      ),
      validator: (value) =>
      value == null ? 'Please select Opportunity status' : null,
    );

    final btnStart = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RaisedButton(
          color: ColorConstants.buttonNormalColor,
          highlightColor: ColorConstants.buttonPressedColor,
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _getCurrentLocationStart();
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RaisedButton(
          color: ColorConstants.buttonNormalColor,
          highlightColor: ColorConstants.buttonPressedColor,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _getCurrentLocation(widget.mwpVisitModel.id);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'UPDATE',
              style: ButtonStyles.buttonStyleBlue,
            ),
          ),
        ),
        RaisedButton(
          color: ColorConstants.buttonNormalColor,
          highlightColor: ColorConstants.buttonPressedColor,
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _getCurrentLocationEnd();
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
        child: Padding(
            padding: EdgeInsets.all(16),
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
                            visitType,
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Site ID",
                                  style: TextStyles.formfieldLabelText),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '${widget.siteId}',
                                style: TextStyles.mulliBold16,
                              ),
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
                                          _selectDate(context);
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
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    color: ColorConstants.lineColorFilter),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                RaisedButton(
                                  color: ColorConstants.buttonNormalColor,
                                  highlightColor:
                                      ColorConstants.buttonPressedColor,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                     if(selectedDateString == null || selectedDateString == "Visit Date"){
                                       Get.snackbar("", "Select Visit Date",
                                           colorText: Colors.black,
                                           backgroundColor: Colors.white,
                                           snackPosition: SnackPosition.BOTTOM);
                                      }else if (selectedDateStringNext == null || selectedDateStringNext == "Next visit date") {
                                       Get.snackbar("", "Select next visit date",
                                           colorText: Colors.black,
                                           backgroundColor: Colors.white,
                                           snackPosition: SnackPosition.BOTTOM);
                                     }
                                     else {
                                        _getCurrentLocation(0);
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
                              style: FormFieldStyle.formFieldTextStyle,
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              enableInteractiveSelection: false,
                              decoration: FormFieldStyle.buildInputDecoration(),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Site ID",
                                  style: TextStyles.formfieldLabelText),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '${widget.siteId}',
                                style: TextStyles.mulliBold16,
                              ),
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
                                          _selectDate(context);
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
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    color: ColorConstants.lineColorFilter),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                // key: Key(
                                //     _addEventController.visitRemarks),
                                initialValue:
                                    widget.mwpVisitModel.remark == 'null'
                                        ? ''
                                        : widget.mwpVisitModel.remark,
                                onSaved: (val) {
                                  print('saved' + val);
                                  widget.mwpVisitModel.remark = val;
                                },
                                onChanged: (_) {
                                  widget.mwpVisitModel.remark = _.toString();
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
                            (widget.mwpVisitModel.visitStartTime == null &&
                                    widget.mwpVisitModel.visitEndTime == null)
                                ? btnStart
                                : (widget.mwpVisitModel.visitStartTime !=
                                            null &&
                                        widget.mwpVisitModel.visitEndTime ==
                                            null)
                                    ? btnEnd
                                    : Container(),
                            SizedBox(height: 50),
                          ],
                        ),
                )
              ],
            )));
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
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      )
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          btnCreatePressed(id);
        });
        Get.back();
      }).catchError((e) {
        print(e);
      });
    }
  }

  btnCreatePressed(int id) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String visitStartTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    SiteVisitRequestModel _siteVisitRequestModel =
        SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "eventType": "",
      "id": id,
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
      "visitType": "VISIT",
    });

    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController
                  .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
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
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      )
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          btnStartPressed();
        });
        Get.back();
      }).catchError((e) {
        print(e);
      });
    }
  }

  btnStartPressed()async{
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String visitStartTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    // if(selectedDateString == null || selectedDateString == "Visit Date"){
    //   selectedDateString = widget.mwpVisitModel.visitDate;
    // }
    // if(selectedDateStringNext == null || selectedDateStringNext == "Next visit date"){
    //   selectedDateStringNext = '${widget.mwpVisitModel.nextVisitDate}';
    // }
    SiteVisitRequestModel _siteVisitRequestModel =
    SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "eventType": "",
      "id": widget.mwpVisitModel.id,
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
      "visitSubType": widget.mwpVisitModel.visitSubType,
      "visitType": "VISIT",
    });

    internetChecking().then((result) => {
      if (result == true)
        {
          _siteController
              .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
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
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      )
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          btnEndPressed();
        });
        Get.back();
      }).catchError((e) {
        print(e);
      });
    }
  }

  btnEndPressed()async{

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTime = dateFormat.format(DateTime.now());
    String empId = await getEmpId();
    // if(selectedDateString == null || selectedDateString == "Visit Date"){
    //   selectedDateString = widget.mwpVisitModel.visitDate;
    // }
    // if(selectedDateStringNext == null || selectedDateStringNext == "Next visit date"){
    //   selectedDateStringNext = '${widget.mwpVisitModel.nextVisitDate}';
    // }
    SiteVisitRequestModel _siteVisitRequestModel =
    SiteVisitRequestModel.fromJson({
      "docId": widget.siteId,
      "eventType": "",
      "id": widget.mwpVisitModel.id,
      "nextVisitDate": selectedDateStringNext,
      "referenceId": empId,
      "remark": _remark,
      "visitDate": selectedDateString,
      "visitEndLat": '${_currentPosition.latitude}',
      "visitEndLong":  '${_currentPosition.longitude}',
      "visitEndTime": currentTime,
      "visitOutcomes": "",
      "visitStartLat": widget.mwpVisitModel.visitStartLat,
      "visitStartLong": widget.mwpVisitModel.visitStartLong,
      "visitStartTime": widget.mwpVisitModel.visitStartTime,
      "visitSubType": widget.mwpVisitModel.visitSubType,
      "visitType": widget.mwpVisitModel.visitType,
    });

    internetChecking().then((result) => {
      if (result == true)
        {
          _siteController
              .getAccessKeyAndSaveSiteRequest(_siteVisitRequestModel)
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
}