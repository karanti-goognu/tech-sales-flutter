import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEventVisit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddEventVisitScreenPageState();
  }
}

class AddEventVisitScreenPageState extends State<AddEventVisit> {
  String dropdownValue = 'Select visit sub-types';
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;

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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Select visit sub-types',
                    'Two',
                    'Free',
                    'Four'
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
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Site ID can't be empty";
                    }
                    return null;
                  },
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: _inputDecoration("Site Id", false),
                ),
                SizedBox(height: 16),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter date and time ';
                      }
                      return null;
                    },
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.datetime,
                    decoration: _inputDecoration("Date and time", true)),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter date and time ';
                      }
                      return null;
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
                RaisedButton(
                  color: ColorConstants.buttonNormalColor,
                  highlightColor: ColorConstants.buttonPressedColor,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      //afterRequestLayout(empId, mobileNumber);
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
      });
  }
}
