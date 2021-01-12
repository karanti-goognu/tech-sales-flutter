import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditEventVisit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditEventVisitScreenPageState();
  }
}

class EditEventVisitScreenPageState extends State<EditEventVisit> {
  String dropdownValue = 'RETENTION SITE';
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();

  @override
  void initState() {
    _appController.getAccessKey(RequestIds.VIEW_VISIT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.ADD_CALENDER_SCREEN);
          return true;
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColor,
          body: SingleChildScrollView(
            child: _buildAddEventInterface(context),
          ),
        ));
  }

  Widget _buildAddEventInterface(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Obx(
      () => (_addEventController.isLoadingVisitView == false)
          ? (_addEventController.visitResponseModel.mwpVisitModel != null)
              ? Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "View Event",
                              style: TextStyle(
                                  color: ColorConstants.greenText,
                                  fontFamily: "Muli-Semibold.ttf",
                                  fontSize: 20,
                                  letterSpacing: .15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(
                                  color:
                                      ColorConstants.inputBoxBorderSideColor)),
                          child: Obx(
                            () => DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _addEventController.visitSubType,
                                onChanged: (String newValue) {},
                                items: <String>[
                                  'RETENTION SITE',
                                  'LEADS',
                                  'CONVERSION OPPORTUNITY',
                                  'COUNTER',
                                  'TECHNOCRAT'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              initialValue: _addEventController.visitSiteId,
                              enabled: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Site ID can't be empty";
                                }
                                return null;
                              },
                              onChanged: (_) {
                                _addEventController.visitSiteId = _.toString();
                              },
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                              keyboardType: TextInputType.text,
                              decoration: _inputDecoration("Site Id", false),
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
                                child: Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _addEventController.visitType,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _addEventController.visitType =
                                              newValue;
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
                                      Obx(() => Text(
                                            "${this._addEventController.visitDateTime}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    ColorConstants.blackColor,
                                                fontFamily: "Muli"),
                                          )),
                                      GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
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
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: ColorConstants.lineColorFilter)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(() => Text(
                                        "${this._addEventController.nextVisitDate}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.blackColor,
                                            fontFamily: "Muli"),
                                      )),
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter remarks ';
                                  }
                                  return null;
                                },
                                initialValue: _addEventController.visitRemarks,
                                onChanged: (_) {
                                  _addEventController.visitRemarks =
                                      _.toString();
                                },
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                decoration: _inputDecoration("Remarks", false)),
                            SizedBox(
                              height: 16,
                            ),
                            Obx(() => (_addEventController.visitResponseModel
                                            .mwpVisitModel.visitStartTime ==
                                        null &&
                                    _addEventController.visitResponseModel
                                            .mwpVisitModel.visitEndTime ==
                                        null)
                                ? returnUpdateRow()
                                : (_addEventController.visitResponseModel
                                                .mwpVisitModel.visitStartTime !=
                                            null &&
                                        _addEventController.visitResponseModel
                                                .mwpVisitModel.visitEndTime ==
                                            null)
                                    ? returnEndRow()
                                    : Container()),
                          ],
                        ),
                      )
                    ],
                  ))
              : Container()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Please wait, Loading Data..",
                    style: TextStyle(
                        color: ColorConstants.greenText,
                        fontFamily: "Muli-Semibold.ttf",
                        fontSize: 20,
                        letterSpacing: .15),
                  ),
                ),
              ],
            ),
    ));
  }

  Widget returnUpdateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RaisedButton(
          color: ColorConstants.buttonNormalColor,
          highlightColor: ColorConstants.buttonPressedColor,
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              //afterRequestLayout(empId, mobileNumber);
              _addEventController.visitActionType = "UPDATE";
              _appController.getAccessKey(RequestIds.UPDATE_VISIT);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              'UPDATE EVENT',
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
              //afterRequestLayout(empId, mobileNumber);
              _addEventController.visitActionType = "START";
              _appController.getAccessKey(RequestIds.UPDATE_VISIT);
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
  }

  Widget returnEndRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          color: ColorConstants.buttonNormalColor,
          highlightColor: ColorConstants.buttonPressedColor,
          onPressed: () {
            // Validate returns true if the form is valid, or false
            // otherwise.
            if (_formKey.currentState.validate()) {
              _addEventController.visitActionType = "END";
              _appController.getAccessKey(RequestIds.UPDATE_VISIT);
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
        this._addEventController.visitDateTime = selectedDateString;
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
        selectedDateString = formattedDate;
        this._addEventController.nextVisitDate = selectedDateString;
      });
  }
}