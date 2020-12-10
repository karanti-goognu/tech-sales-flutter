import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEventInfluencerMeet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddEventInfluencerMeetScreenPageState();
  }
}

class AddEventInfluencerMeetScreenPageState
    extends State<AddEventInfluencerMeet> {
  String dropdownValue = 'Event type';
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
                  items: <String>['Event type', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: _myFormFont(),
                      ),
                    );
                  }).toList(),
                ),
              )),
          _spaceBetweenFields(),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter date and time ';
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.datetime,
                    decoration: _inputDecoration("Date and time", true)),
                _spaceBetweenFields(),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Dalmia Influencers can't be empty";
                    }
                    return null;
                  },
                  style: _myFormFont(),
                  keyboardType: TextInputType.text,
                  decoration: _inputDecoration("Dalmia Influencers", false),
                ),
                _spaceBetweenFields(),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Non-Dalmia Influencers can't be empty ";
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.text,
                    decoration:
                        _inputDecoration("Non-Dalmia Influencers", false)),
                _spaceBetweenFields(),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Total participants can't be empty ";
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.text,
                    decoration: _inputDecoration("Total participants", false)),
                _spaceBetweenFields(),
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
                        items: <String>['Event type', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: _myFormFont(),
                            ),
                          );
                        }).toList(),
                      ),
                    )),
                _spaceBetweenFields(),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Add dealers can't be empty ";
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.text,
                    decoration: _inputDecoration("Add dealer(s)", false)),
                _spaceBetweenFields(),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Expected leads can't be empty ";
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.text,
                    decoration: _inputDecoration("Expected leads", false)),
                _spaceBetweenFields(),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Gift distribution can't be empty ";
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.text,
                    decoration: _inputDecoration("Gift distribution", false)),
                _spaceBetweenFields(),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Event location can't be empty ";
                      }
                      return null;
                    },
                    style: _myFormFont(),
                    keyboardType: TextInputType.text,
                    decoration: _inputDecoration("Event location", false)),
                _spaceBetweenFields(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          side: BorderSide(
                              color: ColorConstants.inputBoxBorderSideColor)),
                      color: Colors.transparent,
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
                          'SAVE AS DRAFT',
                          style: ButtonStyles.buttonStyleWhite,
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
                )
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
      labelStyle: _myFormFont(),
      fillColor: ColorConstants.backgroundColor,
    );
  }

  TextStyle _myFormFont() {
    return GoogleFonts.roboto(
        color: ColorConstants.inputBoxHintColorDark,
        fontWeight: FontWeight.normal,
        fontSize: 16.0);
  }

  SizedBox _spaceBetweenFields() {
    return SizedBox(
      height: 24,
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
