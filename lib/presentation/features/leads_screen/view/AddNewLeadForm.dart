import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddNewLeadForm extends StatefulWidget {
  @override
  _AddNewLeadFormState createState() => _AddNewLeadFormState();
}

class _AddNewLeadFormState extends State<AddNewLeadForm> {
  final _formKey = GlobalKey<FormState>();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _myActivity;
  LocationResult _pickedLocation;
  var txt = TextEditingController();
  SiteSubTypeEntity _selectedValue;
  String _contactName;
  String _contactNumber;
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  int _totalBags=0;
  int _totalMT=0;
  List<File> _imageList = [
  new File("/storage/emulated/0/Android/data/com.dalmia.techsales/files/Pictures/scaled_image_picker6000543052621285162.jpg")
  ];

  List<Item> _data = generateItems(1);
List<InfluencerDetail> _list = [
  new InfluencerDetail()
];
  Position _currentPosition;
  String _currentAddress;

  List<SiteSubTypeEntity> siteSubTypeEntity = [
    new SiteSubTypeEntity(siteSubId: 1, siteSubTypeDesc: "Ground"),
    new SiteSubTypeEntity(siteSubId: 2, siteSubTypeDesc: "G+1"),
    new SiteSubTypeEntity(
        siteSubId: 3, siteSubTypeDesc: "Multi-Storey"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddLeadsController _addLeadsController = Get.find();

    _addLeadsController.getAccessKey(RequestIds.ADD_LEADS_DATA_REQUEST);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   // titleSpacing: 50,
      //   // leading: new Container(),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   toolbarHeight: 90,
      //   centerTitle: false,
      //   title: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Row(
      //         // mainAxisSize: MainAxisSize.max,
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             "Add a new Trade lead",
      //             style: TextStyle(
      //                 fontWeight: FontWeight.normal,
      //                 fontSize: 22,
      //                 color: HexColor("#006838"),
      //                 fontFamily: "Muli"),
      //           ),
      //         ],
      //       ),
      //
      //
      //     ],
      //   ),
      //   automaticallyImplyLeading: false,
      //
      // ),
      floatingActionButton: Container(
        height: 68.0,
        width: 68.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: ColorConstants.checkinColor,
            child: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: ColorConstants.appBarColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // currentScreen =
                        //     Dashboard(); // if user taps on this dashboard tab will be active
                        // currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.white60,
                        ),
                        // Text(
                        //   'Dashboard',
                        //   style: TextStyle(
                        //     color: currentTab == 0 ? Colors.blue : Colors.grey,
                        //   ),
                        //),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.drafts,
                          color: Colors.white60,
                        ),
                        // Text(
                        //   'Mail',
                        //   style: TextStyle(
                        //     color: currentTab == 2 ? Colors.blue : Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    minSize: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                        // Text(
                        //   'Search',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 200,
              right: 0,
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/Container.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ))),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30.0, bottom: 20, left: 5),
                      child: Text(
                        "Add a new Trade lead",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                            color: HexColor("#006838"),
                            fontFamily: "Muli"),
                      ),
                    ),

                    DropdownButtonFormField<SiteSubTypeEntity>(
                      value: _selectedValue,
                      items: siteSubTypeEntity
                          .map((label) => DropdownMenuItem(
                                child: Text(
                                  label.siteSubTypeDesc,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.inputBoxHintColor,
                                      fontFamily: "Muli"),
                                ),
                                value: label,
                              ))
                          .toList(),

                      // hint: Text('Rating'),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Site Subtype",
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
                      initialValue: _contactName,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Contact Name can't be empty";
                      //   }
                      //   //leagueSize = int.parse(value);
                      //   return null;
                      // },
                      onChanged: (data) {
                        setState(() {
                          _contactName = data;
                        });
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Contact Name",
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
                      initialValue: _contactNumber,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter contact number ';
                        }
                        if (value.length <= 9) {
                          return 'Contact number is incorrect';
                        }
                        return null;
                      },
                      onChanged: (data) {
                        setState(() {
                          _contactNumber = data;
                        });
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Contact Number",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    // SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Geo Tag",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlatButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          color: Colors.transparent,
                          icon: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.location_searching,
                              color: HexColor("#F9A61A"),
                              size: 18,
                            ),
                          ),
                          label: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
                            child: Text(
                              "DETECT",
                              style: TextStyle(
                                  color: HexColor("#F9A61A"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () {
                            _getCurrentLocation();
                          },
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                              fontFamily: "Muli",
                              //color: HexColor("#F9A61A"),
                              // fontWeight: FontWeight.bold,
                              // letterSpacing: 2,
                              fontSize: 17),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
                            child: Text(
                              "MANUAL",
                              style: TextStyle(
                                  color: HexColor("#F9A61A"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            LocationResult result = await showLocationPicker(
                                context,
                                "AIzaSyBEMGF1RVNoYyxMaYE8v2isPlmeCuHDMlc",
                                initialCenter: LatLng(31.1975844, 29.9598339),
                                automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                                myLocationButtonEnabled: true,
                                // requiredGPS: true,
                                layersButtonEnabled: true,
                                countries: ['AE', 'NG']

//                      resultCardAlignment: Alignment.bottomCenter,
                                // desiredAccuracy: LocationAccuracy.best,
                                );
                            print("result = $result");
                            setState(() => _pickedLocation = result);
                          },
                        ),
                      ],
                    ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         RaisedButton(
//                           onPressed: () async {
//                             LocationResult result = await showLocationPicker(
//                                 context,
//                                 "AIzaSyBEMGF1RVNoYyxMaYE8v2isPlmeCuHDMlc",
//                                 initialCenter: LatLng(31.1975844, 29.9598339),
//                                 automaticallyAnimateToCurrentLocation: true,
// //                      mapStylePath: 'assets/mapStyle.json',
//                                 myLocationButtonEnabled: true,
//                                 // requiredGPS: true,
//                                 layersButtonEnabled: true,
//                                 countries: ['AE', 'NG']
//
// //                      resultCardAlignment: Alignment.bottomCenter,
//                                 // desiredAccuracy: LocationAccuracy.best,
//                                 );
//                             print("result = $result");
//                             setState(() => _pickedLocation = result);
//                           },
//                        //   child: Text('Pick location'),
//                         ),
//                         Text(_pickedLocation.toString()),
//                       ],
//                     ),
//                     Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).canvasColor,
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Column(children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Icon(Icons.location_on),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       'Location',
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     ),
//                                     if (_currentPosition != null &&
//                                         _currentAddress != null)
//                                       Text(_currentAddress,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText2),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                             ],
//                           ),
//                         ])),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _siteAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Address ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Address",
                        filled: false,
                        focusColor: Colors.black,
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
                      //initialValue: _pincode.toString(),
                      controller: _pincode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Pincode ';
                        }
                        if (value.length <= 6) {
                          return 'Pincode is incorrect';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.phone,
                      //  maxLength: 6,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Pincode",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _state,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter State ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "State",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _district,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter District ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "District",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      controller: _taluk,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Taluk ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Taluk",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Mandatory",
                        style: TextStyle(
                          fontFamily: "Muli",
                          color: ColorConstants.inputBoxHintColorDark,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 10, top: 10),
                          child: Text(
                            "UPLOAD PHOTOS",
                            style: TextStyle(
                                color: HexColor("#1C99D4"),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                          _showPicker(context);

                        },
                      ),



                    ),

                        _imageList!=null ?
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Picture 1: " ,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                          ),),
                                          GestureDetector(
                                            child: Text("XYZ.jpg",
                                            style: TextStyle(
                                              color: HexColor("#007CBF"),
                                                fontSize: 15
                                            ),),
                                              onTap: (){
                                                return showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: new Container(
                                                          // width: 500,
                                                          // height: 500,
                                                          child: Image.file(_imageList[0]),
                                                        ),
                                                      );
                                                    }
                                                );
                                              }
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.delete,color: HexColor("#FFCD00"),)
                                    ],
                                  ),
                                )
                        :Container(),

                    SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Influencer Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Container(
                      child: _buildPanel(),
                    ),

                    SizedBox(height: 16),

                    Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
                          child: Text(
                            "ADD MORE INFLUENCER",
                            style: TextStyle(
                                color: HexColor("#1C99D4"),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                          InfluencerDetail infl = new InfluencerDetail();

                          Item item = new Item(
                              headerValue: "agx ", expandedValue: "dnxcx");
                          setState(() {
                            _data.add(item);
                            _list.add(infl);
                          });
                        },
                      ),
                    ),

                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Total Site Potential",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextFormField(
                              initialValue: _totalBags.toString(),
                              onChanged: (value) {
                                setState(() {
                                  _totalBags = value as int;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Bags ';
                                }

                                return null;
                              },

                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                             // keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.backgroundColorBlue,
                                      //color: HexColor("#0000001F"),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.4),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                labelText: "Bags",
                                filled: false,
                                focusColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontFamily: "Muli",
                                    color: ColorConstants.inputBoxHintColorDark,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0),
                                fillColor: ColorConstants.backgroundColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(

                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              initialValue: (_totalBags * 20).toString(),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter MT ';
                                }

                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.backgroundColorBlue,
                                      //color: HexColor("#0000001F"),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.4),
                                      width: 1.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.4),
                                      width: 1.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                labelText: "MT",
                                filled: false,
                                enabled: false,

                                focusColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontFamily: "Muli",
                                    color: ColorConstants.inputBoxHintColorDark,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0),
                                fillColor: ColorConstants.backgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter RERA Number ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "RERA Number",
                        filled: false,
                        focusColor: Colors.black,
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
                      maxLines: 4,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter RERA Number ';
                      //   }
                      //
                      //   return null;
                      // },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Comment",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                    SizedBox(height: 16),

                    Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
                          child: Text(
                            "ADD COMMENT",
                            style: TextStyle(
                                color: HexColor("#1C99D4"),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                      //     InfluencerDetail infl = new InfluencerDetail();
                      //
                      //     Item item = new Item(
                      //         headerValue: "agx ", expandedValue: "dnxcx");
                      //     setState(() {
                      //       _data.add(item);
                      //       _list.add(infl);
                      //     });
                         },
                       ),


                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                      child: Text(
                        "XYZ Kumar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 5.0, bottom: 20, left: 5),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 20,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(0),
                        //     side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
                          child: Text(
                            "VIEW MORE COMMENT",
                            style: TextStyle(
                                color: HexColor("##F9A61A"),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                          //     InfluencerDetail infl = new InfluencerDetail();
                          //
                          //     Item item = new Item(
                          //         headerValue: "agx ", expandedValue: "dnxcx");
                          //     setState(() {
                          //       _data.add(item);
                          //       _list.add(infl);
                          //     });
                        },
                      ),


                    ),

                    SizedBox(height: 35),
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
                              "SAVE AND CLOSE",
                              style: TextStyle(
                                  color: HexColor("#1C99D4"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () async {},
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
                          onPressed: () async {},
                        ),
                      ],
                    ),

                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      print(image.path);
      _imageList.insert(0,image);
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
     // print(image.path);
     _imageList.add(image);
     _imageList.insert(0,image);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _siteAddress.text =
            place.name + "," + place.thoroughfare + "," + place.subLocality;
        _district.text = place.subAdministrativeArea;
        _state.text = place.administrativeArea;
        _pincode.text = place.postalCode;
        _taluk.text = place.locality;
        //txt.text = place.postalCode;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";

        print(
            "${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, ${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, ${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _list.removeWhere((currentItem) => item == currentItem);
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}


class InfluencerDetail {
  InfluencerDetail({
    this.infl_id,
    this.infl_name,
    this.infl_contact,
    this.infl_type_id,
    this.infl_cat_id,
    this.infl_intrested,
    this.infl_created_on,


  });

  String infl_id;
  String infl_name;
  String infl_contact;
  String infl_type_id;
  String infl_cat_id;
  String infl_intrested;
  DateTime infl_created_on;
}



class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Influencer Details 1',
      expandedValue: 'This is item number $index',
    );
  });
}
//
// List<Item> addItems(Item item){
//   _data.add
//   return List.
// }


class CommentsList{

}