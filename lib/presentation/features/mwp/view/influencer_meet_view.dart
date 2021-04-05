import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/widgets/dealers_list.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:get/get.dart';
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
  int _value = 0;
  TextEditingController dalmiaInfluencers = TextEditingController();
  TextEditingController nonDalmiaInfluencers = TextEditingController();
  TextEditingController meetInitiatorName = TextEditingController();

  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();

  @override
  void initState() {
    _addEventController.dealerList.clear();
    _appController.getAccessKey(RequestIds.GET_DEALERS_LIST);
    _addEventController.isLoading = true;
    super.initState();
  }

  // void dispose() {
  //   dalmiaInfluencers.clear();
  //   nonDalmiaInfluencers.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (_addEventController.isLoading == false)
        ? Column(
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
                      child: Obx(() => DropdownButton<String>(
                            value: _addEventController.selectedEventTypeMeet,
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                _addEventController.selectedEventTypeMeet =
                                    newValue;
                              });
                            },
                            items: <String>[
                              'MASOON MEET',
                              'DEALER MEET',
                              'CONTRACTOR MEET',
                              'ENGINEER MEET',
                              'CONSUMER MEET',
                              'MINI CONTRACTOR MEET',
                              'TECHNOCRAT MEET',
                              'BLOCK LEVEL MEET'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: _myFormFont(),
                                ),
                              );
                            }).toList(),
                          )),
                    )),
                _spaceBetweenFields(),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text(
                                      "${this._addEventController.visitDateTime}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ColorConstants.blackColor,
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
                      _spaceBetweenFields(),
                      TextFormField(
                        controller: dalmiaInfluencers,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Dalmia Influencers can't be empty";
                          }
                          return null;
                        },
                        onChanged: (_) {
                          _addEventController.dalmiaInflCount = int.parse(_);
                        },
                        style: _myFormFont(),
                        keyboardType: TextInputType.number,
                        decoration:
                            _inputDecoration("Dalmia Influencers", false),
                      ),
                      _spaceBetweenFields(),
                      TextFormField(
                        controller: nonDalmiaInfluencers,
                          validator: (value) {
                            if (value.isEmpty) {
                              print('called validator');
                              return "Non-Dalmia Influencers can't be empty ";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _addEventController.nonDalmiaInflCount =
                                int.parse(_);
                          },
                          onEditingComplete: (){
                            print("Edit");
                          },

                          style: _myFormFont(),
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration(
                              "Non-Dalmia Influencers", false)),
                      _spaceBetweenFields(),
                      TextFormField(
                          controller: meetInitiatorName,
                          validator: (value) {
                            if(_addEventController.selectedEventTypeMeet=="MINI CONTRACTOR MEET") {
                              if (value.isEmpty) {
                                print('called validator');
                                return "Meet Initiator Name can't be empty ";
                              }
                              return null;
                            }else{
                              return null;
                            }
                          },
                          onChanged: (_) {
                            _addEventController.meetInitiatorName = _.toString();
                          },
                          onEditingComplete: (){
                            print("Edit");
                          },

                          style: _myFormFont(),
                          keyboardType: TextInputType.text,
                          decoration: _inputDecoration(
                              "Meet Initiator Name", false)),
                      _spaceBetweenFields(),
                      Text('Total Participants'),
                      Obx(() =>
                          Container(
                          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(
                                  color:
                                      ColorConstants.inputBoxBorderSideColor)),
                          child: Text(
                            // "${_addEventController.dalmiaInflCount + _addEventController.nonDalmiaInflCount}  ,${dalmiaInfluencers.text.length} " +
                              // dalmiaInfluencers.text.length.toString()
                            // (int.parse(dalmiaInfluencers.text.length!=0?dalmiaInfluencers.text:"0")+int.parse(nonDalmiaInfluencers.text.length!=0?nonDalmiaInfluencers.text:"0")).toString()
                            // "${_addEventController.dalmiaInflCount + _addEventController.nonDalmiaInflCount}"
                            "${_addEventController.dalmiaInflCount + _addEventController.nonDalmiaInflCount}  ,${(int.parse(dalmiaInfluencers.text.length!=0?dalmiaInfluencers.text:"0")+int.parse(nonDalmiaInfluencers.text.length!=0?nonDalmiaInfluencers.text:"0"))}".substring("${_addEventController.dalmiaInflCount + _addEventController.nonDalmiaInflCount}  ,${(int.parse(dalmiaInfluencers.text.length!=0?dalmiaInfluencers.text:"0")+int.parse(nonDalmiaInfluencers.text.length!=0?nonDalmiaInfluencers.text:"0"))}".lastIndexOf(',')+1)
                          ),
                      ),
                      ),
                      // Text("${dalmiaInfluencers.text.length} dalmia"),
                      // Text("${nonDalmiaInfluencers.text.length} nondalmia"),
                      _spaceBetweenFields(),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(
                                  color:
                                      ColorConstants.inputBoxBorderSideColor)),
                          child: DropdownButtonHideUnderline(
                              child: Obx(
                            () => DropdownButton<String>(
                              value: _addEventController.selectedVenueTypeMeet,
                              onChanged: (String newValue) {
                                setState(() {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  dropdownValue = newValue;
                                  _addEventController.selectedVenueTypeMeet =
                                      newValue;
                                });
                              },
                              items: <String>[
                                'BOOKED',
                                'NOT BOOKED',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: _myFormFont(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ))),
                      _spaceBetweenFields(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add Dealers(s)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.blackColor,
                                      fontFamily: "Muli"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _settingModalBottomSheetDealers(context);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Obx(
                                () => Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12.0,
                                  children: List<Widget>.generate(
                                    _addEventController
                                        .dealerListSelected.length,
                                    (int index) {
                                      return ChoiceChip(
                                        pressElevation: 0.0,
                                        selectedColor: Colors.grey[100],
                                        backgroundColor: Colors.grey[100],
                                        label: Text(
                                            "${_addEventController.dealerListSelected[index].dealerName}"),
                                        selected: _value == index,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _value = selected ? index : null;
                                          });
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _spaceBetweenFields(),
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Expected leads can't be empty ";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _addEventController.expectedLeadsCount =
                                int.parse(_);
                          },
                          style: _myFormFont(),
                          keyboardType: TextInputType.number,
                          decoration:
                              _inputDecoration("Expected leads", false)),
                      _spaceBetweenFields(),
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Gift distribution can't be empty ";
                            }
                            return null;
                          },
                          onChanged: (_) {
                            _addEventController.giftsDistributedCount =
                                int.parse(_);
                          },
                          style: _myFormFont(),
                          keyboardType: TextInputType.number,
                          decoration:
                              _inputDecoration("Gift distribution", false)),
                      _spaceBetweenFields(),
                      TextFormField(
                          validator: (value) {
                            if((_addEventController.selectedEventTypeMeet=="TECHNOCRAT MEET" || _addEventController.selectedEventTypeMeet=="BLOCK LEVEL MEET" || _addEventController.selectedEventTypeMeet=="CONSUMER MEET" || _addEventController.selectedEventTypeMeet=="MINI CONTRACTOR MEET")) {
                              if (value.isEmpty) {
                                String addressType;
                                (_addEventController.selectedEventTypeMeet ==
                                    "TECHNOCRAT MEET" ||
                                    _addEventController.selectedEventTypeMeet ==
                                        "BLOCK LEVEL MEET") ?
                                addressType = "Address can't be empty "
                                    : addressType =
                                "Event location can't be empty ";
                                return addressType;
                              }
                            }else {
                              return null;
                            }
                              return null;
                          },
                          onChanged: (_) {
                            _addEventController.eventLocation = _.toString();
                          },
                          style: _myFormFont(),
                          keyboardType: TextInputType.text,
                          decoration:(_addEventController.selectedEventTypeMeet=="TECHNOCRAT MEET"||_addEventController.selectedEventTypeMeet=="BLOCK LEVEL MEET")?
                          _inputDecoration("Address", false):_inputDecoration("Event location", false)
                      ),
                      _spaceBetweenFields(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                                side: BorderSide(
                                    color: ColorConstants
                                        .inputBoxBorderSideColor)),
                            color: Colors.transparent,
                            highlightColor: ColorConstants.buttonPressedColor,
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                //afterRequestLayout(empId, mobileNumber);
                                _addEventController.meetAction = "D";
                                _appController
                                    .getAccessKey(RequestIds.SAVE_MEET);
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
                                _addEventController.meetAction = "S";
                                _appController
                                    .getAccessKey(RequestIds.SAVE_MEET);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Text(
                                'ADD MEET',
                                style: ButtonStyles.buttonStyleBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ])
        : Container());
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
        _addEventController.visitDateTime = selectedDateString;
      });
  }

  /*void _settingModalBottomSheetDealers(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: (_addEventController.dealerListResponse == null)
                ? Container()
                : showDealerListBody(),
          );
        });
  }*/

  void _settingModalBottomSheetDealers(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: (_addEventController.dealerListResponse == null)
                ? Container()
                : DealersListWidget(),
          );
        });
  }
}
