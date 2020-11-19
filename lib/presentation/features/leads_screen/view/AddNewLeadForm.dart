import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/CommentDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _comment;
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  var _comments = TextEditingController();
  var _rera = TextEditingController();
  var _influencerNumber = TextEditingController();
  var _influencerName = TextEditingController();
  var _influencerType = TextEditingController();
  var _influencerCategory = TextEditingController();
  String geoTagType;

  var _totalBags = TextEditingController();
  var _totalMT = TextEditingController();
  List<File> _imageList = new List();
  List<CommentsDetail> _commentsList = new List();
  bool viewMoreActive = false;

  List<String> _items = new List(); // to store comments

  final myController = TextEditingController();

  void _addComment() {
    if (myController.text.isNotEmpty) {
      // check if the comments text input is not empty
      setState(() {
        _items.add(myController.text); // add new commnet to the existing list
      });

      myController.clear(); // clear the text from the input
    }
  }

  List<Item> _data = generateItems(1);
  List<InfluencerDetail> _listInfluencerDetail = [
    new InfluencerDetail(isExpanded: true)
  ];
  Position _currentPosition;
  String _currentAddress;

  List<SiteSubTypeEntity> siteSubTypeEntity = [
    new SiteSubTypeEntity(siteSubId: 1, siteSubTypeDesc: "Ground"),
    new SiteSubTypeEntity(siteSubId: 2, siteSubTypeDesc: "G+1"),
    new SiteSubTypeEntity(siteSubId: 3, siteSubTypeDesc: "Multi-Storey"),
  ];
  List<InfluencerTypeEntity> influencerTypeEntity;

  List<InfluencerCategoryEntity> influencerCategoryEntity;

  AddLeadsController _addLeadsController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addLeadsController = Get.find();
    getInitialData();
  }

  getInitialData() {
    AddLeadInitialModel addLeadInitialModel = new AddLeadInitialModel();
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    _addLeadsController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      print("AccessKey :: " + accessKeyModel.accessKey);
      await _addLeadsController
          .getAddLeadsData(accessKeyModel.accessKey)
          .then((data) {
        addLeadInitialModel = data;
        setState(() {
          siteSubTypeEntity = addLeadInitialModel.siteSubTypeEntity;
          influencerTypeEntity = addLeadInitialModel.influencerTypeEntity;
          influencerCategoryEntity =
              addLeadInitialModel.influencerCategoryEntity;
          //  print(influencerCategoryEntity[0].inflCatDesc);
        });
      });

      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
              color: Colors.black,
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
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
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
                        Text(
                          'Drafts',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Stack(
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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],

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
                            setState(() {
                              geoTagType = "Auto";
                            });
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
                            setState(() {
                              geoTagType = "Manual";
                            });
                            LocationResult result = await showLocationPicker(
                              context,
                              "AIzaSyBbCRRECpLRmhBJSY2jv9H0SbzQLnCFYFk",
                              initialCenter: LatLng(31.1975844, 29.9598339),
                              automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                              myLocationButtonEnabled: true,
                              // requiredGPS: true,
                              layersButtonEnabled: false,
                              // countries: ['AE', 'NG']

//                      resultCardAlignment: Alignment.bottomCenter,
                              // desiredAccuracy: LocationAccuracy.best,
                            );
                            print("result = $result");
                            setState(() {
                              _pickedLocation = result;
                              _currentPosition = new Position(
                                  latitude: _pickedLocation.latLng.latitude,
                                  longitude: _pickedLocation.latLng.longitude);
                              _getAddressFromLatLng();
                              //print(_pickedLocation.latLng.latitude);
                            });
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                          if(_imageList.length<5){
                            _showPicker(context);
                          }
                          else{
                            Get.dialog(CustomDialogs().errorDialog("You can add only upto 5 photos"));
                          }

                        },
                      ),
                    ),

                    _imageList != null
                        ? Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _imageList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: new Container(
                                                    // width: 500,
                                                    // height: 500,
                                                    child: Image.file(
                                                        _imageList[index]),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Picture ${(index + 1)}. ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Image_${(index + 1)}.jpg",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#007CBF"),
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              child: Icon(
                                                Icons.delete,
                                                color: HexColor("#FFCD00"),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _imageList.removeAt(index);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )
                        : Container(),

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
                    // Container(
                    //   child: _buildPanel(),
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _listInfluencerDetail.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (!_listInfluencerDetail[index].isExpanded) {
                                  return Column(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Influencer Details ${(index + 1)} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          _listInfluencerDetail[index]
                                                  .isExpanded
                                              ? FlatButton.icon(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(0),
                                                  //     side: BorderSide(color: Colors.black26)),
                                                  color: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: HexColor("#F9A61A"),
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    "COLLAPSE",
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
                                                              .isExpanded;
                                                    });
                                                    // _getCurrentLocation();
                                                  },
                                                )
                                              : FlatButton.icon(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(0),
                                                  //     side: BorderSide(color: Colors.black26)),
                                                  color: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: HexColor("#F9A61A"),
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    "EXPAND",
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
                                                              .isExpanded;
                                                    });
                                                    // _getCurrentLocation();
                                                  },
                                                ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Influencer Details ${(index + 1)} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          _listInfluencerDetail[index]
                                                  .isExpanded
                                              ? FlatButton.icon(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(0),
                                                  //     side: BorderSide(color: Colors.black26)),
                                                  color: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: HexColor("#F9A61A"),
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    "COLLAPSE",
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
                                                              .isExpanded;
                                                    });
                                                    // _getCurrentLocation();
                                                  },
                                                )
                                              : FlatButton.icon(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius: BorderRadius.circular(0),
                                                  //     side: BorderSide(color: Colors.black26)),
                                                  color: Colors.transparent,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: HexColor("#F9A61A"),
                                                    size: 18,
                                                  ),
                                                  label: Text(
                                                    "EXPAND",
                                                    style: TextStyle(
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
                                                              .isExpanded;
                                                    });
                                                    // _getCurrentLocation();
                                                  },
                                                ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflContact,
                                        maxLength: 10,
                                        onChanged: (value) async {
                                          if (value.length == 10) {
                                            var bodyEncrypted = {
                                              //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
                                              "inflContact": value
                                            };

                                            AddLeadsController
                                                _addLeadsController =
                                                Get.find();
                                            _addLeadsController.phoneNumber =
                                                value;
                                            AccessKeyModel accessKeyModel =
                                                new AccessKeyModel();
                                            await _addLeadsController
                                                .getAccessKeyOnly()
                                                .then((data) async {
                                              accessKeyModel = data;
                                              print("AccessKey :: " +
                                                  accessKeyModel.accessKey);
                                              await _addLeadsController
                                                  .getInflDetailsData(
                                                      accessKeyModel.accessKey)
                                                  .then((data) {
                                                _listInfluencerDetail[index]
                                                        .inflContact =
                                                    new TextEditingController();
                                                ;
                                                _listInfluencerDetail[index]
                                                        .inflName =
                                                    new TextEditingController();
                                                ;

                                                InfluencerDetail inflDetail =
                                                    data;
                                                print(data);
                                                setState(() {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  //  print(inflDetail.inflName.text);
                                                  _listInfluencerDetail[index]
                                                          .inflTypeValue =
                                                      new TextEditingController();
                                                  _listInfluencerDetail[index]
                                                          .inflCatValue =
                                                      new TextEditingController();
                                                  _listInfluencerDetail[index]
                                                          .inflTypeId =
                                                      new TextEditingController();
                                                  _listInfluencerDetail[index]
                                                          .inflCatId =
                                                      new TextEditingController();

                                                  _listInfluencerDetail[index]
                                                          .inflContact =
                                                      inflDetail.inflContact;
                                                  _listInfluencerDetail[index]
                                                          .inflName =
                                                      inflDetail.inflName;
                                                  _listInfluencerDetail[index]
                                                      .id = inflDetail.id;
                                                  _listInfluencerDetail[index]
                                                          .ilpIntrested =
                                                      inflDetail.ilpIntrested;
                                                  _listInfluencerDetail[index]
                                                          .createdOn =
                                                      inflDetail.createdOn;

                                                  for (int i = 0;
                                                      i <
                                                          influencerTypeEntity
                                                              .length;
                                                      i++) {
                                                    if (influencerTypeEntity[i]
                                                            .inflTypeId
                                                            .toString() ==
                                                        inflDetail
                                                            .inflTypeId.text) {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeId =
                                                          inflDetail.inflTypeId;
                                                      //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeValue
                                                              .text =
                                                          influencerTypeEntity[
                                                                  influencerTypeEntity[
                                                                          i]
                                                                      .inflTypeId]
                                                              .inflTypeDesc;
                                                      break;
                                                    } else {
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflContact
                                                          .clear();
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflName
                                                          .clear();
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflTypeId
                                                          .clear();
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflTypeValue
                                                          .clear();
                                                    }
                                                  }
                                                  // _influencerType.text = influencerTypeEntity[inflDetail.inflTypeId].infl_type_desc;

                                                  for (int i = 0;
                                                      i <
                                                          influencerCategoryEntity
                                                              .length;
                                                      i++) {
                                                    if (influencerCategoryEntity[
                                                                i]
                                                            .inflCatId
                                                            .toString() ==
                                                        inflDetail
                                                            .inflCatId.text) {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflCatId =
                                                          inflDetail.inflCatId;
                                                      //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflCatValue
                                                              .text =
                                                          influencerCategoryEntity[
                                                                  influencerCategoryEntity[
                                                                          i]
                                                                      .inflCatId]
                                                              .inflCatDesc;
                                                      break;
                                                    } else {
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflContact
                                                          .clear();
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflName
                                                          .clear();
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflCatId
                                                          .clear();
                                                      _listInfluencerDetail[
                                                              index]
                                                          .inflCatValue
                                                          .clear();
                                                    }
                                                  }
                                                });
                                                Get.back();
                                              });
                                            });

                                            print("Dhawan :: ");
                                          }
                                          // setState(() {
                                          //   _totalBags = value as int;
                                          // });
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Influencer Number ';
                                          }

                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          labelText: "Infl. Contact",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        //  initialValue: _listInfluencerDetail[index].inflName,
                                        controller: _listInfluencerDetail[index]
                                            .inflName,

                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          labelText: "Infl. Name",
                                          enabled: false,
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflTypeValue,
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          enabled: false,
                                          labelText: "Infl. Type",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflCatValue,
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          enabled: false,
                                          labelText: "Infl. Category",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                        ),
                      ],
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
                          if (_listInfluencerDetail[
                                          _listInfluencerDetail.length - 1]
                                      .inflName
                                      .text !=
                                  null &&
                              _listInfluencerDetail[
                                          _listInfluencerDetail.length - 1]
                                      .inflName
                                      .text !=
                                  "null") {
                            InfluencerDetail infl =
                                new InfluencerDetail(isExpanded: true);

                            // Item item = new Item(
                            //     headerValue: "agx ", expandedValue: "dnxcx");
                            setState(() {
                              // _data.add(item);
                              _listInfluencerDetail[
                                      _listInfluencerDetail.length - 1]
                                  .isExpanded = false;
                              _listInfluencerDetail.add(infl);
                            });
                          } else {
                            print(
                                "Error : Please fill previous influencer first");
                          }
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
                              // initialValue: _totalBags.toString(),
                              controller: _totalBags,
                              onChanged: (value) {
                                setState(() {
                                  // _totalBags.text = value ;
                                  if (_totalBags.text == null ||
                                      _totalBags.text == "") {
                                    _totalMT.clear();
                                  } else {
                                    _totalMT.text =
                                        (int.parse(_totalBags.text) / 20)
                                            .toString();
                                  }
                                });
                              },
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                              controller: _totalMT,
                              onChanged: (value) {
                                setState(() {
                                  // _totalBags.text = value ;
                                  if (_totalMT.text == null ||
                                      _totalMT.text == "") {
                                    _totalBags.clear();
                                  } else {
                                    _totalBags.text =
                                        (int.parse(_totalMT.text) * 20)
                                            .toString();
                                  }
                                });
                              },
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
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                                //enabled: false,
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
                      controller: _rera,
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
                      controller: _comments,

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
                      onChanged: (value) {
                        setState(() {
                          _comments.text = value;
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

                    // Center(
                    //   child: FlatButton(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(0),
                    //         side: BorderSide(color: Colors.black26)),
                    //     color: Colors.transparent,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           right: 5, bottom: 8, top: 5),
                    //       child: Text(
                    //         "ADD COMMENT",
                    //         style: TextStyle(
                    //             color: HexColor("#1C99D4"),
                    //             fontWeight: FontWeight.bold,
                    //             // letterSpacing: 2,
                    //             fontSize: 17),
                    //       ),
                    //     ),
                    //     onPressed: () async {
                    //       if (_comments.value.text != null &&
                    //           _comments.value.text != '') {
                    //         print("here");
                    //         setState(() {
                    //           _commentsList.add(
                    //             new CommentsDetail(
                    //                 commentedBy: "XYZNAME",
                    //                 comment: _comments.value.text,
                    //                 commentedAt: DateTime.now()),
                    //           );
                    //           _comments.clear();
                    //         });
                    //       }
                    //       SystemChannels.textInput
                    //           .invokeMethod('TextInput.hide');
                    //     },
                    //   ),
                    // ),
                    _commentsList != null && _commentsList.length != 0
                        ? viewMoreActive
                            ? Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        reverse: true,
                                        shrinkWrap: true,
                                        itemCount: _commentsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _commentsList[index]
                                                        .commentedBy,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[index]
                                                        .comment,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[index]
                                                        .commentedAt
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .commentedBy,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .comment,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 25),
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .commentedAt
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                        : Container(),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                    //   child: Text(
                    //     "XYZ Kumar",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 25,
                    //         // color: HexColor("#000000DE"),
                    //         fontFamily: "Muli"),
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 5.0, bottom: 20, left: 5),
                    //   child: Text(
                    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    //     style: TextStyle(
                    //         //fontWeight: FontWeight.bold,
                    //         fontSize: 20,
                    //         // color: HexColor("#000000DE"),
                    //         fontFamily: "Muli"),
                    //   ),
                    // ),
                    Center(
                      child: FlatButton(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(0),
                        //     side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
                          child: !viewMoreActive
                              ? Text(
                                  "VIEW MORE COMMENT (" +
                                      _commentsList.length.toString() +
                                      ")",
                                  style: TextStyle(
                                      color: HexColor("##F9A61A"),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                      fontSize: 17),
                                )
                              : Text(
                                  "VIEW LESS COMMENT (" +
                                      _commentsList.length.toString() +
                                      ")",
                                  style: TextStyle(
                                      color: HexColor("##F9A61A"),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: 2,
                                      fontSize: 17),
                                ),
                        ),
                        onPressed: () async {
                          setState(() {
                            viewMoreActive = !viewMoreActive;
                          });
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
                          onPressed: () async {
                            //print(_comments.text);
                            if (_comments.text != null &&
                                _comments.text != '') {
                             // print(_comments.text);
                              print("here");
                              setState(() {
                                String empId;
                                String mobileNumber;
                                String name;
                                Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                                _prefs.then((SharedPreferences prefs) {
                                  empId = prefs.getString(
                                      StringConstants.employeeId) ?? "empty";
                                  mobileNumber = prefs.getString(
                                      StringConstants.mobileNumber) ?? "empty";
                                  name = prefs.getString(
                                      StringConstants.employeeName) ?? "empty";
                                  print(_comments.text);
                                  _commentsList.add(
                                      new CommentsDetail(
                                          commentedBy: name,
                                          comment: _comments.text,
                                          commentedAt: DateTime.now()),
                                  );
                                });


                              //  _comments.clear();
                              });
                            }
                            SaveLeadRequestModel saveLeadRequestModel =
                                new SaveLeadRequestModel(
                                    siteSubTypeId:
                                        _selectedValue.siteSubId.toString(),
                                    contactName: _contactName,
                                    contactNumber: _contactNumber,
                                    geotagType: geoTagType,
                                    leadLatitude:
                                        _currentPosition.latitude.toString(),
                                    leadLongitude:
                                        _currentPosition.longitude.toString(),
                                    leadAddress: _siteAddress.text,
                                    leadPincode: _pincode.text,
                                    leadStateName: _state.text,
                                    leadDistrictName: _district.text,
                                    leadTalukName: _taluk.text,
                                    leadSalesPotentialMt: _totalMT.text,
                                    leadReraNumber: _rera.text,
                                    isStatus: "false",
                                    influencerList: _listInfluencerDetail,
                                    comments: _commentsList);

                            _addLeadsController.getAccessKeyAndSaveLead(
                                saveLeadRequestModel, _imageList);
                          },
                        ),
                      ],
                    ),
                    // Column(children: [
                    //   Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: <Widget>[
                    //         Expanded(
                    //             child: TextField(
                    //           style: TextStyle(color: Colors.black),
                    //           controller: myController,
                    //           maxLines: 5,
                    //           keyboardType: TextInputType.multiline,
                    //         )),
                    //         SizedBox(width: 15),
                    //         InkWell(
                    //             onTap: () {
                    //               _addComment();
                    //             },
                    //             child: Icon(Icons.send))
                    //       ]),
                    //   SizedBox(height: 10),
                    //   Row(
                    //     children: [
                    //       Expanded(
                    //         child: ListView.builder(
                    //             shrinkWrap: true,
                    //             itemCount: _items.length,
                    //             itemBuilder: (BuildContext context, int index) {
                    //               return Text(
                    //                   "${(index + 1)}. " + _items[index]);
                    //             }),
                    //       ),
                    //     ],
                    //   )
                    // ]),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      //print(image.path);
      if(image!=null) {

          _imageList.add(image);

      }
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      // print(image.path);

      if(image!=null) {

          _imageList.add(image);

      }
      // _imageList.insert(0,image);
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
        });
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
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
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
