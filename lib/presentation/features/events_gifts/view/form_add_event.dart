import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/event_type_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';


class FormAddEvent extends StatefulWidget {
  @override
  _FormAddEventState createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {
  AddEventModel addEventModel;
  EventTypeController eventController = Get.find();
  List<String> suggestions = [];
  final _addEventFormKey = GlobalKey<FormState>();
  TextEditingController _requestSubType = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  LocationResult _pickedLocation;
  Position _currentPosition = new Position();
  var _fromDate = 'Select Date';
  TimeOfDay _time;
  String geoTagType;
  int dealerId;

  @override
  void initState() {
    getDropdownData();
    super.initState();
  }

  getDropdownData() async {
    await eventController.getAccessKey().then((value) async {
      print(value.accessKey);
      await eventController.getEventType(value.accessKey).then((data) {
        setState(() {
          addEventModel = data;
        });
        print('RESPONSE, ${data}');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    final eventDropDwn =
        DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          //requestDepartmentId = value;
        });
      },
      items:
      addEventModel==null?[]:
      addEventModel.eventTypeModels
          //['Event 1', 'Event 2', 'Event 3', 'Event 4']
          .map((e) => DropdownMenuItem(
                value: e.eventTypeId,
                child: Text(e.eventTypeText),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Event Type"),
      validator: (value) =>
          value == null ? 'Please select the event type' : null,
   // )
    //:Container(),
    );

    final date = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: RaisedButton(
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: Text(_fromDate)),
                Icon(
                  Icons.calendar_today,
                  color: ColorConstants.clearAllTextColor,
                ),
              ],
            ),
            onPressed: () {
              _selectFromDate();
            },
          ),
        ));

    final time = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: RaisedButton(
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text((_time != null
                        ? '${_time.hour}:${_time.minute}'
                        : 'Select time'))),
                Icon(
                  Icons.calendar_today,
                  color: ColorConstants.clearAllTextColor,
                ),
              ],
            ),
            onPressed: () {
              _startTime();
            },
          ),
        ));

    final dalmiaInfluencer = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Dalmia Influencers',
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorConstants.backgroundColorBlue, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final nondalmia = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Non-Dalmia Influencers',
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorConstants.backgroundColorBlue, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final total = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Total Participants',
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorConstants.backgroundColorBlue, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final venueDropDwn = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          //requestDepartmentId = value;
        });
      },
      items: ['Venue 1', 'Venue 2', 'Venue 3', 'Venue 4']
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Venue"),
      validator: (value) => value == null ? 'Please select the venue' : null,
    );

    final venueAddress = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Venue address (if booked)',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstants.backgroundColorBlue,
              //color: HexColor("#0000001F"),
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final dealer = GestureDetector(
      onTap: () => getBottomSheetForDealer(),
      child: FormField(
        validator: (value) => value,
        builder: (state) {
          return InputDecorator(
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: 'Add Dealer(s)',
              suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12),
                  child:
                  //Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   // children: [
                     // Text('Add Dealer(s)'),
                      Icon(
                        Icons.add,
                        size: 20,
                        color: HexColor('#F9A61A'),
                      ),
                  //  ],
               //   )
            ),
            ),
            child:
            //selectedDealersModels.isEmpty
              //  ? Text('')
               // :
            Container(
                    height: 30,
                    child:
                        //Text('Add Dealer(s)'),
                        ListView(
                      scrollDirection: Axis.horizontal,
                      children: selectedDealersModels
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Chip(
                                  label: Text(
                                    e.dealerName,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  backgroundColor:
                                      Colors.lightGreen.withOpacity(0.2),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
          );
        },
      ),
    );

    final influencer = GestureDetector(
      onTap: () => getBottomSheet(),
      child: FormField(
        validator: (value) => value,
        builder: (state) {
          return InputDecorator(
            decoration: FormFieldStyle.buildInputDecoration(
              hintText: 'Add Influencer(s)',
              suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: HexColor('#F9A61A'),
                  )),
            ),
            child: Container(
              height: 30,
              child: Text('Add Influencer(s)'),
              // ListView(
              //   scrollDirection:
              //   Axis.horizontal,
              //   children:
              //   selectedRequestSubtypeObjectList
              //       .map(
              //           (e) =>
              //           Padding(
              //             padding:
              //             const EdgeInsets.symmetric(horizontal: 4.0),
              //             child:
              //             Chip(
              //               label:
              //               Text(
              //                 e.serviceRequestTypeText,
              //                 style:
              //                 TextStyle(fontSize: 10),
              //               ),
              //               backgroundColor: Colors
              //                   .lightGreen
              //                   .withOpacity(0.2),
              //             ),
              //           )
              //   )
              //       .toList(),
              // ),
            ),
          );
        },
      ),
    );

    final expectedLeads = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Expected Leads',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstants.backgroundColorBlue,
              //color: HexColor("#0000001F"),
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final giftDistribution = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Gift distribution (proposed)',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstants.backgroundColorBlue,
              //color: HexColor("#0000001F"),
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final giftType = TextFormField(
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Type of gift',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstants.backgroundColorBlue,
              //color: HexColor("#0000001F"),
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final comment = TextFormField(
      maxLines: 3,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return "Contact Name can't be empty";
      //   }
      //   //leagueSize = int.parse(value);
      //   return null;
      // },
      onChanged: (data) {
        setState(() {
          //_contactName = data;
        });
      },
      style: TextStyles.formfieldLabelText,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Comments',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstants.backgroundColorBlue,
              //color: HexColor("#0000001F"),
              width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        filled: false,
        focusColor: Colors.black,
        isDense: false,
        labelStyle: TextStyles.formfieldLabelText,
        fillColor: ColorConstants.backgroundColor,
      ),
    );

    final btns = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.black26)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
            child: Text(
              "SAVE AS DRAFT",
              style: TextStyles.btnBlue,
            ),
          ),
          onPressed: () {},
        ),
        RaisedButton(
          color: ColorConstants.btnBlue,
          child: Text(
            "SUBMIT",
            style:
                //TextStyles.btnWhite,
                TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 2,
                    fontSize: ScreenUtil().setSp(15)),
          ),
          onPressed: () {},
        ),
      ],
    );

    final contact = Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
      child: TextFormField(
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return "Contact Name can't be empty";
        //   }
        //   //leagueSize = int.parse(value);
        //   return null;
        // },
        onChanged: (data) {
          setState(() {
            //_contactName = data;
          });
        },
        style: TextStyle(
            fontSize: 18,
            color: ColorConstants.inputBoxHintColor,
            fontFamily: "Muli"),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Contact No.',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorConstants.backgroundColorBlue,
                //color: HexColor("#0000001F"),
                width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
          ),
          filled: false,
          focusColor: Colors.black,
          isDense: false,
          labelStyle: TextStyle(
              fontFamily: "Muli",
              color: ColorConstants.inputBoxHintColorDark,
              fontWeight: FontWeight.normal,
              fontSize: 16.0),
          fillColor: ColorConstants.backgroundColor,
        ),
      ),
    );

    final location = TextField(
      controller: _locationController,
      onTap: () async {
        // placeholder for our places search later
      },
      // with some styling
      decoration: InputDecoration(
        icon: Container(
          margin: EdgeInsets.only(left: 20),
          width: 10,
          height: 10,
          child: Icon(
            Icons.home,
            color: Colors.black,
          ),
        ),
        hintText: "Enter your shipping address",
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
      ),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body:
          //Container(child: Text('Hi'),),
          Stack(
        children: [
          Positioned.fill(
            child:
//            addEventModel != null ?
            ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        height: 56,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Event',
                              style: TextStyles.titleGreenStyle,
                            ),
                            Chip(
                              shape: StadiumBorder(
                                  side: BorderSide(color: HexColor("#39B54A"))),
                              backgroundColor:
                                  HexColor("#39B54A").withOpacity(0.1),
                              label: Text('Status: Not Submitted'),
                            ),
                          ],
                        ),
                        // decoration: BoxDecoration(
                        //     border: Border(bottom: BorderSide(width: 0.3))),
                      ),
                      SizedBox(height: 16),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _addEventFormKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                 // Obx(() => eventDropDwn),
                                  eventDropDwn,
                                  SizedBox(height: 16),
                                  date,
                                  SizedBox(height: 16),
                                  time,
                                  SizedBox(height: 16),
                                  Text(
                                    "Tentative Members",
                                    style: TextStyles.welcomeMsgTextStyle20,
                                  ),
                                  SizedBox(height: 16),
                                  dalmiaInfluencer,
                                  SizedBox(height: 16),
                                  nondalmia,
                                  SizedBox(height: 16),
                                  total,
                                  SizedBox(height: 16),
                                  venueDropDwn,
                                  SizedBox(height: 16),
                                  venueAddress,
                                  SizedBox(height: 16),
                                  dealer,
                                  SizedBox(height: 16),
                                  //influencer,
                                  //SizedBox(height: 16),
                                  expectedLeads,
                                  SizedBox(height: 16),
                                  giftDistribution,
                                  SizedBox(height: 16),
                                  // giftType,
                                  //SizedBox(height: 16),
                                  comment,
                                  SizedBox(height: 16),
                                  btns,
                                  SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               FlatButton.icon(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(0),
//                                     side: BorderSide(color: Colors.black26)),
//                                 color: Colors.transparent,
//                                 icon: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Icon(
//                                     Icons.location_searching,
//                                     color: HexColor("#F9A61A"),
//                                     size: 18,
//                                   ),
//                                 ),
//                                 label: Padding(
//                                   padding: const EdgeInsets.only(
//                                       right: 5, bottom: 8, top: 5),
//                                   child: Text(
//                                     "DETECT",
//                                     style: TextStyle(
//                                         color: HexColor("#F9A61A"),
//                                         fontWeight: FontWeight.bold,
//                                         // letterSpacing: 2,
//                                         fontSize: 17),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     geoTagType = "A";
//                                   });
//                                   Get.dialog(Center(
//                                     child: CircularProgressIndicator(),
//                                   ));
//                                   _getCurrentLocation();
//                                 },
//                               ),
//                               Text(
//                                 "Or",
//                                 style: TextStyle(
//                                     fontFamily: "Muli",
//                                     //color: HexColor("#F9A61A"),
//                                     // fontWeight: FontWeight.bold,
//                                     // letterSpacing: 2,
//                                     fontSize: 17),
//                               ),
//                               FlatButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(0),
//                                     side: BorderSide(color: Colors.black26)),
//                                 color: Colors.transparent,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       right: 5, bottom: 8, top: 5),
//                                   child: Text(
//                                     "MANUAL",
//                                     style: TextStyle(
//                                         color: HexColor("#F9A61A"),
//                                         fontWeight: FontWeight.bold,
//                                         // letterSpacing: 2,
//                                         fontSize: 17),
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   setState(() {
//                                     geoTagType = "M";
//                                   });
//                                   LocationResult result = await showLocationPicker(
//                                     context,
//                                     StringConstants.API_Key,
//                                     initialCenter: LatLng(28.644800, 77.216721),
//                                     automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                                     myLocationButtonEnabled: true,
//                                     // requiredGPS: true,
//                                     layersButtonEnabled: false,
//                                     // countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                                     // desiredAccuracy: LocationAccuracy.best,
//                                   );
//                                   print("result = $result");
//                                   setState(() {
//                                     _pickedLocation = result;
//                                     _currentPosition = new Position(
//
//                                         latitude: _pickedLocation.latLng.latitude,
//                                         longitude: _pickedLocation.latLng.longitude);
// //                              print(_currentPosition);
//                                     _getAddressFromLatLng();
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
                                ]),
                          )),
                    ],
                  )
//                : Center(
//                    child: CircularProgressIndicator(),
//                  ),
          ),
        ],
      ),
    );
  }

  Future _selectFromDate() async {
    DateTime _picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime(
          new DateTime.now().year,
        ),
        lastDate: new DateTime(2025));
    setState(() {
      _fromDate = new DateFormat('yyyy-MM-dd').format(_picked);
    });
  }

  Future _startTime() async {
    _time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
  }

  addInfluencerBottomSheetWidget() {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.5,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Influencer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.clear))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 16),
              child: TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                onChanged: (data) {
                  setState(() {
                    //_contactName = data;
                  });
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Contact No.',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  filled: false,
                  focusColor: Colors.black,
                  isDense: false,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                onChanged: (data) {
                  setState(() {
                    //_contactName = data;
                  });
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  filled: false,
                  focusColor: Colors.black,
                  isDense: false,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    //requestDepartmentId = value;
                  });
                },
                items: [
                  'Influencer 1',
                  'Influencer 2',
                  'Influencer 3',
                  'Influencer 4'
                ]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                style: FormFieldStyle.formFieldTextStyle,
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Influencer Type"),
                validator: (value) =>
                    value == null ? 'Please select Influencer type ' : null,
              ),
            ),
            SizedBox(height: 16),
            Container(
              // decoration:
              //     BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
              padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: HexColor('#1C99D4'),
                    onPressed: () {},
                    child: Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  List<bool> checkedValues;
  List<String> selectedDealer = [];
  List<DealersModels> selectedDealersModels = [];

  //List<String> selectedDealerList = [];
  TextEditingController _query = TextEditingController();

  addDealerBottomSheetWidget() {
    List<DealersModels> dealers = addEventModel.dealersModels;
    checkedValues =
        List.generate(addEventModel.dealersModels.length, (index) => false);
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.5,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dealer(s) List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.clear))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _query,
                onChanged: (value) {
                  setState(() {
                    dealers = addEventModel.dealersModels.where((element) {
                      return element.dealerName
                          .toString()
                          .toLowerCase()
                          .contains(value);
                    }).toList();
                  });
                },
                decoration: FormFieldStyle.buildInputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    labelText: 'Search'),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // CheckboxListTile(
            //   title: Text("9939 - 0077059321"),
            //   value: false,
            //   onChanged: (newValue) {},
            //   controlAffinity:
            //       ListTileControlAffinity.leading, //  <-- leading Checkbox
            // ),
            // SizedBox(
            //   height: 20,
            // ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: dealers.length,
                itemBuilder: (context, index) {
                  return
                      // dealerId == dealers[index].dealerId
                      //   ?
                      CheckboxListTile(
                    activeColor: Colors.black,
                    dense: true,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dealers[index].dealerId),
                        Text('( ${dealers[index].dealerName} )'),
                      ],
                    ),
                    value: selectedDealer.contains(dealers[index].dealerName),
                    onChanged: (newValue) {
                      setState(() {
                        selectedDealer.contains(dealers[index].dealerName)
                            ? selectedDealer.remove(dealers[index].dealerName)
                            : selectedDealer.add(dealers[index].dealerName);

                        selectedDealersModels.contains(dealers[index])
                            ? selectedDealersModels.remove(dealers[index])
                            : selectedDealersModels.add(dealers[index]);


                        checkedValues[index] = newValue;
                        //dataToBeSentBack = requestSubtype[index];
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                  //  : Container();
                },
                separatorBuilder: (context, index) {
                  return dealerId == dealers[index].dealerId
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(),
                        )
                      : Container();
                },
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
              padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDealer.clear();
                      });
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#F6A902'),
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: HexColor('#1C99D4'),
                    onPressed: () {

                      Get.back();

                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  getBottomSheet() {
    Get.bottomSheet(
      addInfluencerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  getBottomSheetForDealer() {
    Get.bottomSheet(
      addDealerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  _getCurrentLocation() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
        });

        _getAddressFromLatLng();
        Get.back();
      }).catchError((e) {
        print(e);
      });
    }
  }

  _getAddressFromLatLng() async {
    try {
      print(
          "from lat long ${await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude)}");
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        // _siteAddress.text =
        //     place.name + "," + place.thoroughfare + "," + place.subLocality;
        // _district.text = place.subAdministrativeArea;
        // _state.text = place.administrativeArea;
        // _pincode.text = place.postalCode;
        // _taluk.text = place.locality;
        // //txt.text = place.postalCode;
        // _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
        print(
            "........ selected ${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, "
            "${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, "
            "${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print("ex.....   $e");
    }
  }
}
