import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEventVisit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddEventVisitScreenPageState();
  }
}

class AddEventVisitScreenPageState extends State<AddEventVisit> {
  // String dropdownValue;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();

  @override
  void initState() {



    _appController.getAccessKey(RequestIds.GET_DEALERS_LIST);
    // setState(() {
    //   dropdownValue = 'RETENTION SITE';
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(
                      color: ColorConstants.inputBoxBorderSideColor)),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _addEventController.visitSubType,
                    onChanged: (String newValue) {
                      setState(() {
                        _addEventController.visitSubType = newValue;
                      });
                    },
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
                              color: ColorConstants.inputBoxHintColorDark,
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0),
                        ),
                        onTap: () {
                          print(value);
                          setState(() {
                            switch (value) {
                              case "RETENTION SITE":
                                _addEventController.siteIdText = "Site ID";
                                break;
                              case "LEADS":
                                _addEventController.siteIdText = "Lead ID";
                                break;
                              case "CONVERSION OPPORTUNITY":
                                _addEventController.siteIdText = "Site ID";
                                break;
                              case "COUNTER":
                                _addEventController.siteIdText = "Counter Code";
                                break;
                              case "TECHNOCRAT":
                                _addEventController.siteIdText =
                                    "Technocrat ID";
                                break;
                            }
                          });
                        },
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
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _addEventController.siteIdText == "Counter Code"
                    ? DropdownButtonFormField(
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Counter Code"),
                        items: _addEventController.dealerList
                            .map<DropdownMenuItem<dynamic>>((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: SizedBox(
                              width: SizeConfig.screenWidth-100,
                                child: Text('${val.dealerName} (${val.dealerId})')),
                          );
                        }).toList(),
                        onChanged: (val) {
                          print(val.dealerName);
                          _addEventController.visitSiteId = val.dealerId;
                        })
                    : TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "${_addEventController.siteIdText} can't be empty";
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
                        decoration: _inputDecoration(
                            "${_addEventController.siteIdText}", false),
                      ),
                SizedBox(height: 16),
               Obx(()=> TextFormField(
                  decoration: FormFieldStyle.buildInputDecoration(
                    hintText: "${this._addEventController.visitDateTime}",
                    suffixIcon: Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.orange,
                    ),
                  ),
                  readOnly: true,
                 validator: (value) {
                    print(this._addEventController.visitDateTime);
                   if (this._addEventController.visitDateTime=="Visit Date") {
                     print(value);
                     return "Visit Date can't be empty";
                   }
                   return null;
                 },
                  onTap: () {
                    _selectDate(context);
                  },
                ),),
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(2),
                //       color: Colors.white,
                //       border: Border.all(
                //           width: 1, color: ColorConstants.lineColorFilter)),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Obx(() => Text(
                //             "${this._addEventController.visitDateTime}",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 fontSize: 14,
                //                 color: ColorConstants.blackColor,
                //                 fontFamily: "Muli"),
                //           )),
                //       // GestureDetector(
                //       //   onTap: () {
                //       //     _selectDate(context);
                //       //   },
                //       //   child: Icon(
                //       //     Icons.calendar_today_sharp,
                //       //     color: Colors.orange,
                //       //   ),
                //       // )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                    onChanged: (_) {
                      _addEventController.visitRemarks = _.toString();
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
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  color: ColorConstants.buttonNormalColor,
                  highlightColor: ColorConstants.buttonPressedColor,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      //afterRequestLayout(empId, mobileNumber);
                      _appController.getAccessKey(RequestIds.SAVE_VISIT);
                      _addEventController.isLoading = true;
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      'ADD EVENT',
                      style: ButtonStyles.buttonStyleBlue,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ]);
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
}
