import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/UpdateDataRequest.dart' as updateResponse;


class SiteDataView extends StatefulWidget {
  final siteId;
  SiteDataView({this.siteId});

  @override
  _SiteDataViewState createState() => _SiteDataViewState();
}

class _SiteDataViewState extends State<SiteDataView> {
  final db = BrandNameDBHelper();
  FocusNode myFocusNode;
  String _currentAddress;
  bool isSwitchedsiteProductDemo = false;
  bool isSwitchedsiteProductOralBriefing = false;
  bool addNextButtonDisable = false;
  bool viewMoreActive = false;
  String labelText;
  int labelId;
  String labelConstructionText;
  int labelConstructionId;
  String labelProbabilityText;
  int labelProbabilityId;
  String labelCompetetionText;
  int labelCompetetionId;
  String labelOpportunityText;
  int labelOpportunityId;
  double siteScore = 0.0;

  ConstructionStageEntity _selectedConstructionType;
  ConstructionStageEntity _selectedConstructionTypeVisit;
  ConstructionStageEntity _selectedConstructionTypeVisitNextStage;
  SiteFloorsEntity _selectedSiteFloor;
  SiteFloorsEntity _selectedSiteVisitFloor;
  SiteFloorsEntity _selectedSiteVisitFloorNextStage;
  SiteProbabilityWinningEntity _siteProbabilityWinningEntity;

  SiteOpportunityStatusEntity _siteOpportunitStatusEnity;
  SiteCompetitionStatusEntity _siteCompetitionStatusEntity;
  List<File> _imageList = new List();
  int initialInfluencerLength = 0;
  BrandModelforDB _siteProductFromLocalDB;

  BrandModelforDB _siteProductFromLocalDBNextStage;

  List<DropdownMenuItem<String>> productSoldVisitSite = new List();

  TextEditingController _siteBuiltupArea = new TextEditingController();
  TextEditingController _siteProductDemo = new TextEditingController();
  TextEditingController _siteProductOralBriefing = new TextEditingController();
  TextEditingController _stagePotentialVisit = new TextEditingController();
  TextEditingController _stagePotentialVisitNextStage = new TextEditingController();
  TextEditingController _brandPriceVisit = new TextEditingController();
  TextEditingController _brandPriceVisitNextStage = new TextEditingController();
  TextEditingController _dateofConstruction = new TextEditingController();
  TextEditingController _dateofConstructionNextStage = new TextEditingController();
  TextEditingController _nextVisitDate = new TextEditingController();
  TextEditingController _dateOfBagSupplied = new TextEditingController();
  TextEditingController _dateOfBagSuppliedNextStage = new TextEditingController();
  TextEditingController _siteCurrentTotalBagsNextStage = new TextEditingController();
  TextEditingController _comments = new TextEditingController();
  TextEditingController _inactiveReasonText = new TextEditingController();
  TextEditingController closureReasonText = new TextEditingController();
  TextEditingController _siteTotalBags = new TextEditingController();
  TextEditingController _siteTotalPt = new TextEditingController();
  TextEditingController _siteTotalBalancePt = new TextEditingController();
  TextEditingController _ownerName = new TextEditingController();
  TextEditingController _contactNumber = new TextEditingController();
  TextEditingController _stageStatus = new TextEditingController();
  TextEditingController _stageStatusNextStage = new TextEditingController();
  TextEditingController _rera = new TextEditingController();
  TextEditingController _dealerName = new TextEditingController();
  TextEditingController _so = new TextEditingController();
  TextEditingController _plotNumber = TextEditingController();
  TextEditingController _siteAddress = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _taluk = TextEditingController();


  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  LocationResult _pickedLocation;
  Position _currentPosition = new Position();
  String geoTagType;
  final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
  SitesModal sitesModal;
  List<SiteFloorsEntity> siteFloorsEntity = new List();
  List<SiteFloorsEntity> siteFloorsEntityNew = new List();
  List<SiteFloorsEntity> siteFloorsEntityNewNextStage = new List();
  List<SitephotosEntity> sitephotosEntity = new List();
  List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
  List<ConstructionStageEntity> constructionStageEntity = new List();
  List<ConstructionStageEntity> constructionStageEntityNew = new List();
  List<ConstructionStageEntity> constructionStageEntityNewNextStage = new List();
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity = new List();
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity = new List();
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity = new List();
  List<SiteBrandEntity> siteBrandEntity = new List();
  List<BrandModelforDB> siteBrandEntityfromLoaclDB = new List();
  List<BrandModelforDB> siteProductEntityfromLoaclDB = new List();
  List<BrandModelforDB> siteProductEntityfromLoaclDBNextStage = new List();
  List<SiteInfluencerEntity> siteInfluencerEntity = new List();
  List<InfluencerTypeEntity> influencerTypeEntity = new List();
  List<InfluencerCategoryEntity> influencerCategoryEntity = new List();
  List<SiteStageEntity> siteStageEntity = new List();
  List<InfluencerEntity> influencerEntity = new List();
  List<InfluencerDetail> _listInfluencerDetail = new List();
  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<SiteCommentsEntity> siteCommentsEntity = new List();
  List<ImageDetails> _imgDetails = new List();
  SiteController _siteController = Get.find();
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Form(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            focusNode: myFocusNode,
                            autofocus: true,
                          ),
                        ),
                        DropdownButtonFormField<ConstructionStageEntity>(
                          //
                          value: _selectedConstructionType,
                          items: constructionStageEntity
                              .map((label) => DropdownMenuItem(
                            child: Text(
                              label.constructionStageText,
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                  ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                            ),
                            value: label,
                          ))
                              .toList(),

                          // hint: Text('Rating'),

                          onChanged: (value) {
                            setState(() {
                              _selectedConstructionType = value;
                            });
                          },
                          decoration:
                          FormFieldStyle.buildInputDecoration(labelText: "Type of Construction"),
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
                            controller: _siteBuiltupArea,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Site Built-Up Area ';
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.number,
                            decoration: FormFieldStyle.buildInputDecoration(labelText: "Site Built-up area")

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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 5),
                          child: Text(
                            "No. of Floors",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
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
                                  enabled: false,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.inputBoxHintColor,
                                      fontFamily: "Muli"),
                                  // keyboardType: TextInputType.text,
                                  // decoration: FormFieldStyle.buildInputDecoration(labelText:"Ground"),
                                  decoration:InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants
                                              .backgroundColorBlue,
                                          //color: HexColor("#0000001F"),
                                          width: 1.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
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
                                    labelText: "Ground",
                                    filled: false,
                                    focusColor: Colors.black,
                                    labelStyle: TextStyle(
                                        fontFamily: "Muli",
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
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
                                child:
                                DropdownButtonFormField<SiteFloorsEntity>(
                                  value: _selectedSiteFloor,
                                  items: siteFloorsEntity
                                      .map((label) => DropdownMenuItem(
                                    child: Text(
                                      label.siteFloorTxt,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorConstants
                                              .inputBoxHintColor,
                                          fontFamily: "Muli"),
                                    ),
                                    value: label,
                                  ))
                                      .toList(),

                                  // hint: Text('Rating'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSiteFloor = value;
                                    });
                                  },
                                  decoration:FormFieldStyle.buildInputDecoration(labelText:"+ Floors"),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Site Demo conducted",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                // color: HexColor("#000000DE"),
                                fontFamily: "Muli"),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product demo",
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    // color: HexColor("#000000DE"),
                                    fontFamily: "Muli"),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                  Switch(
                                    onChanged: toggleSwitchForProductDemo,
                                    value: isSwitchedsiteProductDemo,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                    HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: isSwitchedsiteProductDemo
                                            ? HexColor("#009688")
                                            : Colors.black,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product oral briefing",
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    // color: HexColor("#000000DE"),
                                    fontFamily: "Muli"),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                  Switch(
                                    onChanged: toggleSwitchForOralBriefing,
                                    value: isSwitchedsiteProductOralBriefing,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                    HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: isSwitchedsiteProductOralBriefing
                                            ? HexColor("#009688")
                                            : Colors.black,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20, left: 5),
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
                                  controller: _siteTotalBags,
                                  onChanged: (value) {
                                    setState(() {
                                      // _totalBags.text = value ;
                                      if (_siteTotalBags.text == null ||
                                          _siteTotalBags.text == "") {
                                        _siteTotalPt.clear();
                                      } else {
                                        _siteTotalPt.text =
                                            (int.parse(_siteTotalBags.text) /
                                                20)
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
                                  decoration: FormFieldStyle.buildInputDecoration(labelText: "Bags"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: TextFormField(
                                  controller: _siteTotalPt,
                                  onChanged: (value) {
                                    setState(() {
                                      // _totalBags.text = value ;
                                      if (_siteTotalPt.text == null ||
                                          _siteTotalPt.text == "") {
                                        _siteTotalBags.clear();
                                      } else {
                                        _siteTotalBags.text =
                                            (int.parse(_siteTotalPt.text) * 20)
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
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: FormFieldStyle.buildInputDecoration(labelText: "MT"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: _ownerName,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Contact Name can't be empty";
                          //   }
                          //   //leagueSize = int.parse(value);
                          //   return null;
                          // },
                          onChanged: (data) {
                            setState(() {
                              _ownerName.text = data;
                            });
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          keyboardType: TextInputType.text,
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Owner Name"),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _contactNumber,
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
                              _contactNumber.text = data;
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Contact Number",),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20, left: 5),
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
                                  geoTagType = "A";
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
                                  geoTagType = "M";
                                });
                                LocationResult result =
                                await showLocationPicker(
                                  context,
                                  StringConstants.API_Key,
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
                                      longitude:
                                      _pickedLocation.latLng.longitude);
                                  _getAddressFromLatLng();
                                  //print(_pickedLocation.latLng.latitude);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _plotNumber,
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Plot No.",),
                        ),
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
                            decoration: FormFieldStyle.buildInputDecoration(labelText: "Address",)
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Pincode",),
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
                          decoration: FormFieldStyle.buildInputDecoration( labelText: "State",),
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "District",),
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Taluk",),
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
                              side: BorderSide(color: Colors.black26),),
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
                              if (_imgDetails.length < 5) {
                                _showPicker(context);
                              } else {
                                Get.dialog(CustomDialogs().errorDialog(
                                    "You can add only upto 5 photos"));
                              }
                            },
                          ),
                        ),

                        _imgDetails != null
                            ? Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _imgDetails.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(_imgDetails[index]
                                        .from
                                        .toLowerCase());
                                    return GestureDetector(
                                      onTap: () {
                                        return showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext context) {
                                              return AlertDialog(
                                                content: new Container(
                                                  // width: 500,
                                                  // height: 500,
                                                  child: _imgDetails[
                                                  index]
                                                      .from
                                                      .toLowerCase() ==
                                                      "network"
                                                      ? Image.network(
                                                      _imgDetails[
                                                      index]
                                                          .file
                                                          .path)
                                                      : Image.file(
                                                      _imgDetails[
                                                      index]
                                                          .file),
                                                ),
                                              );
                                            });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
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
                                                    color: HexColor(
                                                        "#007CBF"),
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
                                                _imgDetails
                                                    .removeAt(index);
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
                        //

                        SizedBox(height: 16),

                        TextFormField(
                          controller: _rera,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter RERA';
                            }

                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          keyboardType: TextInputType.text,
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "RERA",),
                        ),

                        SizedBox(height: 16),

                        TextFormField(
                          controller: _dealerName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Dealer Name ';
                            }

                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          keyboardType: TextInputType.text,
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Dealer",),
                        ),

                        SizedBox(height: 16),

                        TextFormField(
                          controller: _so,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter SO ';
                            }

                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          keyboardType: TextInputType.text,
                          decoration: FormFieldStyle.buildInputDecoration( labelText: "SO",),
                        ),

                        SizedBox(height: 16),

                        SizedBox(height: 35),

                        Center(
                          child: RaisedButton(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: HexColor("#1C99D4"),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 5, bottom: 10, top: 10),
                              child: Text(
                                "UPDATE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 17),
                              ),
                            ),
                            onPressed: () async {
                              UpdateRequest();
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                      ])))),
    );
  }

  Future<void> UpdateRequest() async {
    if (_siteBuiltupArea.text == "" ||
        _siteBuiltupArea.text == null ||
        _siteBuiltupArea.text == "null") {
      Get.dialog(CustomDialogs()
          .errorDialog("Please fill mandatory fields in \"Site Data\" TAb"));
    } else if (_selectedConstructionTypeVisit == null ||
        _stagePotentialVisit.text == null ||
        _stagePotentialVisit.text == "" ||
        _siteProductFromLocalDB == null ||
        _selectedSiteVisitFloor == null ||
        _brandPriceVisit.text == "" ||
        _brandPriceVisit.text == null
        // && _dateofConstruction.text == "" && _dateofConstruction.text == null
        ||
        _dateOfBagSupplied.text == "" ||
        _dateOfBagSupplied.text == null ||
        _stagePotentialVisit.text == "" ||
        _stagePotentialVisit.text == null ||
        _stageStatus.text == "" ||
        _stageStatus.text == null ||
        _siteCompetitionStatusEntity == null ||
        _siteOpportunitStatusEnity == null ||
        _siteProbabilityWinningEntity == null) {
      Get.dialog(CustomDialogs()
          .errorDialog("Please fill mandatory fields in \"Visit Data\" Tab"));
    } else if (addNextButtonDisable &&
        (_selectedConstructionTypeVisitNextStage == null ||
            _stagePotentialVisitNextStage.text == null ||
            _stagePotentialVisitNextStage.text == "" ||
            _siteProductFromLocalDBNextStage == null ||
            _selectedSiteVisitFloorNextStage == null ||
            _brandPriceVisitNextStage.text == "" ||
            _brandPriceVisitNextStage.text == null
            // && _dateofConstruction.text == "" && _dateofConstruction.text == null
            ||
            _dateOfBagSuppliedNextStage.text == "" ||
            _dateOfBagSuppliedNextStage.text == null ||
            _stagePotentialVisitNextStage.text == "" ||
            _stagePotentialVisitNextStage.text == null ||
            _stageStatusNextStage.text == "" ||
            _stageStatusNextStage.text == null)) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please fill mandatory fields in \"Add Next Stage\" or hide next stage"));
    } else {
      String empId;
      String mobileNumber;
      String name;
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      await _prefs.then((SharedPreferences prefs) {
        empId = prefs.getString(StringConstants.employeeId) ?? "empty";
        mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
        name = prefs.getString(StringConstants.employeeName) ?? "empty";

        if (_comments.text == null ||
            _comments.text == "null" ||
            _comments.text == "") {
          _comments.text = "Site updated";
        }

        List<SiteCommentsEntity> newSiteCommentsEntity = new List();
        newSiteCommentsEntity.add(new SiteCommentsEntity(
            siteId: widget.siteId,
            siteCommentText: _comments.text,
            creatorName: name,
            createdBy: empId));

        if (_selectedConstructionTypeVisit != null) {
          siteVisitHistoryEntity.add(new SiteVisitHistoryEntity(
            totalBalancePotential: _siteTotalBalancePt.text,
            constructionStageId: _selectedConstructionTypeVisit.id ?? 1,
            floorId: _selectedSiteVisitFloor.id.toString(),
            stagePotential: _stagePotentialVisit.text,
            brandId: _siteProductFromLocalDB.id,
            brandPrice: _brandPriceVisit.text,
            constructionDate: _dateofConstruction.text,
            siteId: widget.siteId.toString(),
            supplyDate: _dateOfBagSupplied.text,
            supplyQty: _stagePotentialVisit.text,
            stageStatus: _stageStatus.text,
            createdBy: empId,
          ));
        }

        if (_selectedConstructionTypeVisitNextStage != null) {
          siteNextStageEntity.add(new SiteNextStageEntity(
            siteId: widget.siteId,
            constructionStageId:
            _selectedConstructionTypeVisitNextStage.id ?? 1,
            stagePotential: _stagePotentialVisitNextStage.text,
            brandId: _siteProductFromLocalDBNextStage.id,
            brandPrice: _brandPriceVisitNextStage.text,
            stageStatus: _stageStatusNextStage.text,
            constructionStartDt: _dateofConstructionNextStage.text,
            nextStageSupplyDate: _dateOfBagSuppliedNextStage.text,
            nextStageSupplyQty: _siteCurrentTotalBagsNextStage.text,
            createdBy: empId,
          ));
        }

        List<updateResponse.SitePhotosEntity> newSitePhotoEntity = new List();
        // sitephotosEntity.clear();
        for (int i = 0; i < _imageList.length; i++) {
          newSitePhotoEntity.add(new updateResponse.SitePhotosEntity(
              photoName: path.basename(_imageList[i].path),
              siteId: widget.siteId,
              createdBy: empId));
        }

        print("Sumit Length :: " + newSitePhotoEntity.length.toString());

        //print(sitephotosEntity.)

        if (_listInfluencerDetail.length != 0) {
          if (_listInfluencerDetail[_listInfluencerDetail.length - 1].inflName == null ||
              _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName ==null ||
              _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName.text.isNullOrBlank) {
            print("here1234");
            _listInfluencerDetail.removeAt(_listInfluencerDetail.length - 1);
          }
        }

        List<updateResponse.SiteInfluencerEntityNew> newInfluencerEntity =
        new List();

        for (int i = 0; i < _listInfluencerDetail.length; i++) {
          newInfluencerEntity.add(new updateResponse.SiteInfluencerEntityNew(
              id: _listInfluencerDetail[i].originalId,
              inflId: int.parse(_listInfluencerDetail[i].id.text),
              siteId: widget.siteId,
              isDelete: "N",
              isPrimary: _listInfluencerDetail[i].isPrimarybool ? "Y" : "N",
              createdBy: empId));
        }

        if (_selectedSiteFloor == null) {
          _selectedSiteFloor = new SiteFloorsEntity(id: 1, siteFloorTxt: "0");
        }

        var updateDataRequest = {
          "siteId": widget.siteId,
          "siteSegment": "TRADE",
          "assignedTo": viewSiteDataResponse.sitesModal.assignedTo,
          "siteStatusId": viewSiteDataResponse.sitesModal.siteStatusId,
          "siteStageId": labelId,
          "contactName": _ownerName.text,
          "contactNumber": _contactNumber.text,
          "siteGeotag": geoTagType,
          "siteGeotagLat": _currentPosition.latitude.toString(),
          "siteGeotagLong": _currentPosition.longitude.toString(),
          "plotNumber": _plotNumber.text,
          "siteAddress": _siteAddress.text,
          "sitePincode": _pincode.text,
          "siteState": _state.text,
          "siteDistrict": _district.text,
          "siteTaluk": _taluk.text,
          "sitePotentialMt": _siteTotalPt.text,
          "reraNumber": _rera.text,
          "siteCreationDate": viewSiteDataResponse.sitesModal.siteCreationDate,
          "dealerId": viewSiteDataResponse.sitesModal.siteDealerId,
          "siteBuiltArea": _siteBuiltupArea.text,
          "noOfFloors": _selectedSiteFloor.id,
          "productDemo": _siteProductDemo.text,
          "productOralBriefing": _siteProductOralBriefing.text,
          "soCode": viewSiteDataResponse.sitesModal.siteSoId,
          "inactiveReasonText": (_inactiveReasonText.text != "")
              ? _inactiveReasonText.text
              : null,
          "nextVisitDate":
          (_nextVisitDate.text != "") ? _nextVisitDate.text : null,
          "closureReasonText":
          (closureReasonText.text != "") ? closureReasonText.text : null,
          "createdBy": "",
          "siteCommentsEntity": newSiteCommentsEntity,
          "siteVisitHistoryEntity": siteVisitHistoryEntity,
          "siteNextStageEntity": siteNextStageEntity,
          "sitePhotosEntity": newSitePhotoEntity,
          "siteInfluencerEntity": newInfluencerEntity,
          "siteConstructionId": _selectedConstructionType.id,
          "siteCompetitionId": _siteCompetitionStatusEntity != null
              ? _siteCompetitionStatusEntity.id
              : null,
          "siteOppertunityId": _siteOpportunitStatusEnity != null
              ? _siteOpportunitStatusEnity.id
              : null,
          "siteProbabilityWinningId": _siteProbabilityWinningEntity != null
              ? _siteProbabilityWinningEntity.id
              : null
        };
        _siteController.updateLeadData(
            updateDataRequest, _imageList, context, widget.siteId);

        Get.back();
      });
    }
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

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      //print(image.path);
      if (image != null) {
        // print(basename(image.path));

        // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);

        _imgDetails.add(new ImageDetails("asset", image));
      }
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      // print(image.path);

      if (image != null) {
        // listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);

        _imgDetails.add(new ImageDetails("asset", image));
      }
      // _imageList.insert(0,image);
    });


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
      }).catchError((e) {
        print(e);
      });
    }
  }

  void toggleSwitchForProductDemo(bool value) {
    if (isSwitchedsiteProductDemo == false) {
      setState(() {
        isSwitchedsiteProductDemo = true;
        _siteProductDemo.text = "Y";
        // textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitchedsiteProductDemo = false;
        _siteProductDemo.text = "N";
        // textValue = 'Switch Button is OFF';
      });
    }
  }

  void toggleSwitchForOralBriefing(bool value) {
    if (isSwitchedsiteProductOralBriefing == false) {
      setState(() {
        isSwitchedsiteProductOralBriefing = true;
        _siteProductOralBriefing.text = "Y";
        // textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitchedsiteProductOralBriefing = false;
        _siteProductOralBriefing.text = "N";
        // textValue = 'Switch Button is OFF';
      });
    }
  }
}
class ImageDetails {
  String from;
  File file;
  ImageDetails(this.from, this.file);
}