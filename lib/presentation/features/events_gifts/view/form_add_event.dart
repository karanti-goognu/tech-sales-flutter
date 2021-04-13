import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
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

class FormAddEvent extends StatefulWidget {
  @override
  _FormAddEventState createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {
  List<String> suggestions = [];
  final _addEventFormKey = GlobalKey<FormState>();
  TextEditingController _requestSubType = TextEditingController();
  TextEditingController _query = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  LocationResult _pickedLocation;
  Position _currentPosition = new Position();

  String geoTagType;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
              child:
                  //srComplaintModel != null ?
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
                      style: TextStyle(
                          fontSize: 20,
                          color: HexColor('#006838'),
                          fontFamily: "Muli"),
                    ),
                    Chip(
                      shape: StadiumBorder(
                          side: BorderSide(color: HexColor("#39B54A"))),
                      backgroundColor: HexColor("#39B54A").withOpacity(0.1),
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
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            onChanged: (value) {
                              setState(() {
                                //requestDepartmentId = value;
                              });
                            },
                            items: ['Event 1', 'Event 2', 'Event 3', 'Event 4']
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            style: FormFieldStyle.formFieldTextStyle,
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Event Type"),
                            validator: (value) => value == null
                                ? 'Please select the event type'
                                : null,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Tentative Members",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "Muli"),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
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
                              hintText: 'Dalmia Influencers',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.backgroundColorBlue,
                                    //color: HexColor("#0000001F"),
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          TextFormField(
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
                              hintText: 'Non-Dalmia Influencers',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.backgroundColorBlue,
                                    //color: HexColor("#0000001F"),
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          TextFormField(
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
                              hintText: 'Total Participants',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.backgroundColorBlue,
                                    //color: HexColor("#0000001F"),
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          DropdownButtonFormField(
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
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Venue"),
                            validator: (value) => value == null
                                ? 'Please select the venue'
                                : null,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
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
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => getBottomSheetForDealer(),
                            child: FormField(
                              validator: (value) => value,
                              builder: (state) {
                                return InputDecorator(
                                  decoration:
                                  FormFieldStyle.buildInputDecoration(
                                    //labelText: 'Add Dealer(s)',
                                    suffixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 12),
                                        child: Icon(Icons.add, size: 20, color: HexColor('#F9A61A'),)
                                    ),
                                  ),
                                  child:
                                  Container(
                                    height: 30,
                                    child: Text('Add Dealer(s)'),
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
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => getBottomSheet(),
                            child: FormField(
                              validator: (value) => value,
                              builder: (state) {
                                return InputDecorator(
                                  decoration:
                                  FormFieldStyle.buildInputDecoration(
                                    hintText: 'Add Influencer(s)',
                                   // labelText: 'Add Influencer(s)',
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 12),
                                      child: Icon(Icons.add, size: 20, color: HexColor('#F9A61A'),)
                                    ),
                                  ),
                                  child:
                                 Container(
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
                          ),
                          SizedBox(height: 16),
                          TextFormField(
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
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          TextFormField(
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
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          TextFormField(
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
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          TextFormField(
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
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
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
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 1.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.0),
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
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(color: Colors.black26)),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, bottom: 8, top: 5),
                                  child: Text(
                                    "SAVE AS DRAFT",
                                    style: TextStyle(
                                        color: HexColor("#1C99D4"),
                                        fontWeight: FontWeight.bold,
                                        // letterSpacing: 2,
                                        fontSize: 17),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                              RaisedButton(
                                color: HexColor("#1C99D4"),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                      fontSize: 17),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
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
              //     : Center(
              //   child: CircularProgressIndicator(),
              // ),
              ),
        ],
      ),
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
                    borderSide: BorderSide(
                        color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.red, width: 1.0),
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
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16),
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
                    borderSide: BorderSide(
                        color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.red, width: 1.0),
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
              padding:const EdgeInsets.only(
            right: 16, left: 16, bottom: 16),
              child: DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    //requestDepartmentId = value;
                  });
                },
                items: ['Influencer 1', 'Influencer 2', 'Influencer 3', 'Influencer 4']
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                style: FormFieldStyle.formFieldTextStyle,
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Influencer Type"),
                validator: (value) => value == null
                    ? 'Please select Influencer type '
                    : null,
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

  addDealerBottomSheetWidget() {
    // List<ServiceRequestComplaintTypeEntity> requestSubtype =
    //     srComplaintModel.serviceRequestComplaintTypeEntity;
    // checkedValues = List.generate(
    //     srComplaintModel.serviceRequestComplaintTypeEntity.length,
    //        (index) => false);
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
                  //setState(() {
                    //requestSubtype = srComplaintModel
                      //   .serviceRequestComplaintTypeEntity
                      //   .where((element) {
                      // return element.serviceRequestTypeText
                      //     .toString()
                      //     .toLowerCase()
                      //     .contains(value);
                   // }
                   // ).toList();
                 // });
                },
                decoration: FormFieldStyle.buildInputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    labelText: 'Search'),
              ),
            ),
            SizedBox(height: 20,),

            CheckboxListTile(
              title: Text("9939 - 0077059321"),
              value: false,
              onChanged: (newValue) {

              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            ),
            SizedBox(height: 20,),

            //       Expanded(
      //         child: ListView.separated(
      //           padding: EdgeInsets.symmetric(horizontal: 10),
      //           itemCount:5,
      //           //requestSubtype.length,
      //           itemBuilder: (context, index) {
      //             return
      //            // requestId == requestSubtype[index].requestId
      //            //     ?
      // CheckboxListTile(
      //               activeColor: Colors.black,
      //               dense: true,
      //               title: Text(''),
      //                   //requestSubtype[index].serviceRequestTypeText),
      //               value: true,
      //                   //selectedRequestSubtype.contains(
      //                   //requestSubtype[index].serviceRequestTypeText),
      //               onChanged: (newValue) {
      //                 // if (!checkedValues.contains(true) ||
      //                 //     checkedValues[index] == true) {
      //                 // setState(() {
      //                 //   selectedRequestSubtype.contains(
      //                 //       requestSubtype[index]
      //                 //           .serviceRequestTypeText)
      //                 //       ? selectedRequestSubtype.remove(
      //                 //       requestSubtype[index]
      //                 //           .serviceRequestTypeText)
      //                 //       : selectedRequestSubtype.add(
      //                 //       requestSubtype[index]
      //                 //           .serviceRequestTypeText);
      //                 //
      //                 //   selectedRequestSubtypeObjectList
      //                 //       .contains(requestSubtype[index])
      //                 //       ? selectedRequestSubtypeObjectList
      //                 //       .remove(requestSubtype[index])
      //                 //       : selectedRequestSubtypeObjectList
      //                 //       .add(requestSubtype[index]);
      //                 //
      //                 //   selectedRequestSubtypeSeverity = [];
      //                 //   selectedRequestSubtypeObjectList
      //                 //       .forEach((element) {
      //                 //     setState(() {
      //                 //       selectedRequestSubtypeSeverity
      //                 //           .add(element.complaintSeverity);
      //                 //     });
      //                 //   });
      //                   //   print(selectedRequestSubtypeSeverity);
      //
      //                   //checkedValues[index] = newValue;
      //                   // dataToBeSentBack = requestSubtype[index];
      //                 });
      //                 // } else {
      //                 //   Get.snackbar(
      //                 //     'Please uncheck the previous option',
      //                 //     '',
      //                 //     snackPosition: SnackPosition.BOTTOM,
      //                 //   );
      //                 // }
      //               //},
      //              // controlAffinity: ListTileControlAffinity.leading,
      //            // )
      //                 //: Container();
      //           },
      //           // separatorBuilder: (context, index) {
      //           //   return requestId == requestSubtype[index].requestId
      //           //       ? Padding(
      //           //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //           //     child: Divider(),
      //           //   )
      //           //       : Container();
      //          // },
      //         ),
      //       ),
            Container(
              decoration:
              BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
              padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Clear All',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#F6A902'),
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
      print("from lat long ${await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude)}");
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
        print("........ selected ${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, "
            "${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, "
            "${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print("ex.....   $e");
    }
  }

}
/*import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/influencer_meet_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/visit_view.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';

class AddEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddEventScreenPageState();
  }
}

class AddEventScreenPageState extends State<AddEvent> {
  AddEventController _addEventController = Get.find();


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
          floatingActionButton: Container(
            height: 68.0,
            width: 68.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: ColorConstants.checkinColor,
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if(_addEventController.selectedView == "Visit"){
                    this._addEventController.visitDateTime = "Visit Date";


                  }
                },
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAddEventInterface(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Add Event",
                      style: TextStyle(
                          color: ColorConstants.greenText,
                          fontFamily: "Muli-Semibold.ttf",
                          fontSize: 20,
                          letterSpacing: .15),
                    ),
                  ),
                  Expanded(
                    flex:5,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: DropdownButtonHideUnderline(
                          child: Obx(
                                () => DropdownButton<String>(
                              value: _addEventController.selectedView,
                              onChanged: (String newValue) {
                                _addEventController.selectedView = newValue;
                                if(_addEventController.selectedView=='Service Requests'){
                                  Get.offNamed(Routes.SERVICE_REQUEST_CREATION);
                                }
                              },
                              items: <String>[
                                'Visit',
                                'Influencers meet',
                                'Service Requests'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal*3.8,

                                        fontFamily: "Muli"),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Obx(() => (_addEventController.selectedView == "Visit")
                  ? AddEventVisit()
                  :
              (_addEventController.selectedView == "Influencers meet")
                  ? AddEventInfluencerMeet():
              AddEventInfluencerMeet()),
              SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }
}*/
