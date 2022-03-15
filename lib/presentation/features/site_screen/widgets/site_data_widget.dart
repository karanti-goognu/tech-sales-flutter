import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/custom_map.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/UpdateDataRequest.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/updated_values.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/functions/validation.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class SiteDataWidget extends StatefulWidget {
  final int siteId;
  final ViewSiteDataResponse viewSiteDataResponse;
  SiteDataWidget({this.siteId, this.viewSiteDataResponse});

  SiteDataViewWidgetState createState() => SiteDataViewWidgetState();
}

class SiteDataViewWidgetState extends State<SiteDataWidget> {
  final _updateFormKey = GlobalKey<FormState>();
  FocusNode myFocusNode;
  bool isSwitchedsiteProductDemo = false;
  bool isSwitchedsiteProductOralBriefing = false;
  String labelProbabilityText;
  int labelProbabilityId;
  ConstructionStageEntity _selectedConstructionType;
  SiteFloorsEntity _selectedSiteFloor;
  SiteProbabilityWinningEntity _siteProbabilityWinningEntity;
  SiteOpportunityStatusEntity _siteOpportunitStatusEnity;
  SiteCompetitionStatusEntity _siteCompetitionStatusEntity;
  List<ImageDetails> _imgDetails = new List.empty(growable: true);
  List<File> _imageList = new List.empty(growable: true);
  var siteBuiltupArea = new TextEditingController();
  var _siteProductDemo = new TextEditingController();
  var _siteProductOralBriefing = new TextEditingController();

  var _siteTotalBags = new TextEditingController();
  var _siteTotalPt = new TextEditingController();
  var _siteTotalBalanceBags = new TextEditingController();
  var _siteTotalBalancePt = new TextEditingController();
  var _ownerName = new TextEditingController();
  var _contactNumber = new TextEditingController();
  TextEditingController _completionStatus = new TextEditingController();
  TextEditingController _opportunityStatus = new TextEditingController();

  var _rera = new TextEditingController();
  var _dealerName = new TextEditingController();
  var _subDealerName = new TextEditingController();
  var _so = new TextEditingController();
  var _plotNumber = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  var _totalBathroomCount = TextEditingController();
  var _totalKitchenCount = TextEditingController();
  LatLng _currentPosition;
  String geoTagType;
  List<SiteFloorsEntity> siteFloorsEntity = new List.empty(growable: true);
  List<ConstructionStageEntity> constructionStageEntity =
      new List.empty(growable: true);
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity =
      new List.empty(growable: true);
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity =
      new List.empty(growable: true);
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity =
      new List.empty(growable: true);

  ///site visit
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  SitesModal sitesModal = new SitesModal();

  UpdateDataRequest updateDataRequest = new UpdateDataRequest();

  setSiteData() {
    TsoLogger.printLog(":::::::::Set Site Data:::::::::");
    setState(() {
      viewSiteDataResponse = widget.viewSiteDataResponse;
      sitesModal = viewSiteDataResponse.sitesModal;
      constructionStageEntity = viewSiteDataResponse.constructionStageEntity;
      siteBuiltupArea.text = sitesModal.siteBuiltArea;
      siteFloorsEntity = viewSiteDataResponse.siteFloorsEntity;
      _totalKitchenCount.text = sitesModal.kitchenCount != null
          ? sitesModal.kitchenCount.toString()
          : "";
      _totalBathroomCount.text = sitesModal.bathroomCount != null
          ? sitesModal.bathroomCount.toString()
          : "";

      _siteProductDemo.text = sitesModal.siteProductDemo;
      if (_siteProductDemo.text == 'N') {
        isSwitchedsiteProductDemo = false;
      } else {
        isSwitchedsiteProductDemo = true;
      }
      _siteProductOralBriefing.text = sitesModal.siteProductOralBriefing;
      if (_siteProductOralBriefing.text == 'N') {
        isSwitchedsiteProductOralBriefing = false;
      } else {
        isSwitchedsiteProductOralBriefing = true;
      }

      _ownerName.text = sitesModal.siteOwnerName;
      _contactNumber.text = sitesModal.siteOwnerContactNumber;

      _siteTotalPt.text = sitesModal.siteTotalSitePotential;

      if (_siteTotalPt.text == null || _siteTotalPt.text == "") {
        _siteTotalBags.clear();
      } else {
        _siteTotalBags.text =
            (double.parse(_siteTotalPt.text) * 20).round().toString();
      }

      _siteTotalBalanceBags.text = sitesModal.totalBalancePotential;
      if (_siteTotalBalanceBags.text == null ||
          _siteTotalBalanceBags.text == "") {
        _siteTotalBalancePt.clear();
      } else {
        _siteTotalBalancePt.text =
            (int.parse(_siteTotalBalanceBags.text) / 20).toString();
      }

      _plotNumber.text = sitesModal.sitePlotNumber;
      _siteAddress.text = sitesModal.siteAddress;
      _pincode.text = sitesModal.sitePincode;
      _state.text = sitesModal.siteState;
      _district.text = sitesModal.siteDistrict;
      _taluk.text = sitesModal.siteTaluk;
      _rera.text = sitesModal.siteReraNumber;
      if (sitesModal.siteDealerName == null ||
          sitesModal.siteDealerName == "null") {
        _dealerName.text = "";
      } else {
        _dealerName.text = sitesModal.siteDealerName;
      }

      if (sitesModal.siteSubDealerName == null ||
          sitesModal.siteSubDealerName == "null") {
        _subDealerName.text = "";
      } else {
        _subDealerName.text = sitesModal.siteSubDealerName;
      }

      _so.text = sitesModal.siteSoname;
      geoTagType = sitesModal.siteGeotagType;

      if (sitesModal.siteGeotagLatitude != null &&
          sitesModal.siteGeotagLongitude != null &&
          sitesModal.siteGeotagLatitude != "null" &&
          sitesModal.siteGeotagLongitude != "null" &&
          sitesModal.siteGeotagLatitude != "" &&
          sitesModal.siteGeotagLongitude != "") {
        TsoLogger.printLog(":::::::::Set Site Data::::::::: current position");

        _currentPosition = new LatLng(
            double.parse(sitesModal.siteGeotagLatitude),
            double.parse(sitesModal.siteGeotagLongitude));
      }

      constructionStageEntity = viewSiteDataResponse.constructionStageEntity;

      for (int i = 0; i < constructionStageEntity.length; i++) {
        if (viewSiteDataResponse.sitesModal.siteConstructionId.toString() ==
            constructionStageEntity[i].id.toString()) {
          _selectedConstructionType = constructionStageEntity[i];
        }
      }

      siteProbabilityWinningEntity =
          viewSiteDataResponse.siteProbabilityWinningEntity;
      if (viewSiteDataResponse.sitesModal.siteProbabilityWinningId != null) {
        for (int i = 0; i < siteProbabilityWinningEntity.length; i++) {
          if (viewSiteDataResponse.sitesModal.siteProbabilityWinningId
                  .toString() ==
              siteProbabilityWinningEntity[i].id.toString()) {
            labelProbabilityId = siteProbabilityWinningEntity[i].id;
            _siteProbabilityWinningEntity = siteProbabilityWinningEntity[i];
          }
        }
      } else {
        _siteProbabilityWinningEntity = siteProbabilityWinningEntity[0];
      }

      siteCompetitionStatusEntity =
          viewSiteDataResponse.siteCompetitionStatusEntity;
      if (viewSiteDataResponse.sitesModal.siteCompetitionId != null) {
        for (int i = 0; i < siteCompetitionStatusEntity.length; i++) {
          if (viewSiteDataResponse.sitesModal.siteCompetitionId.toString() ==
              siteCompetitionStatusEntity[i].id.toString()) {
            _siteCompetitionStatusEntity = siteCompetitionStatusEntity[i];
            _completionStatus.text =
                siteCompetitionStatusEntity[i].competitionStatus;
          }
        }
      } else {
        _siteCompetitionStatusEntity = siteCompetitionStatusEntity[0];
        _completionStatus.text =
            siteCompetitionStatusEntity[0].competitionStatus;
      }

      siteOpportunityStatusEntity =
          viewSiteDataResponse.siteOpportunityStatusEntity;
      if (viewSiteDataResponse.sitesModal.siteOppertunityId != null) {
        for (int i = 0; i < siteOpportunityStatusEntity.length; i++) {
          if (viewSiteDataResponse.sitesModal.siteOppertunityId.toString() ==
              siteOpportunityStatusEntity[i].id.toString()) {
            _siteOpportunitStatusEnity = siteOpportunityStatusEntity[i];
            _opportunityStatus.text =
                siteOpportunityStatusEntity[i].opportunityStatus;
          }
        }
      } else {
        _siteOpportunitStatusEnity = siteOpportunityStatusEntity[0];
        _opportunityStatus.text =
            siteOpportunityStatusEntity[0].opportunityStatus;
      }

      if (viewSiteDataResponse.sitesModal.noOfFloors != null ||
          viewSiteDataResponse.sitesModal.noOfFloors != 0) {
        for (int i = 0; i < siteFloorsEntity.length; i++) {
          if (viewSiteDataResponse.sitesModal.noOfFloors.toString() ==
              siteFloorsEntity[i].id.toString()) {
            _selectedSiteFloor = siteFloorsEntity[i];
          }
        }
      }

      UpdatedValues.setSiteData(
          widget.siteId,
          _siteProductDemo.text,
          _siteProductOralBriefing.text,
          _siteTotalPt.text,
          _siteProbabilityWinningEntity,
          _siteCompetitionStatusEntity,
          _siteOpportunitStatusEnity,
          _ownerName.text,
          _contactNumber.text,
          _plotNumber.text,
          _siteAddress.text,
          _pincode.text,
          _state.text,
          _district.text,
          _taluk.text,
          _rera.text,
          sitesModal.siteDealerId,
          sitesModal.subdealerId,
          _so.text,
          sitesModal.assignedTo,
          sitesModal.siteStatusId.toString(),
          sitesModal.siteTotalSitePotential.toString(),
          geoTagType,
          _currentPosition.latitude,
          _currentPosition.longitude,
          sitesModal.siteCreationDate,
          "TRADE");

      UpdatedValues.setSiteInfluencerEntity(
          viewSiteDataResponse.siteInfluencerEntity);

      if (UpdatedValues.getSiteConstructionId() != null) {
        _selectedConstructionType = null;
        _selectedConstructionType = UpdatedValues.getSiteConstructionId();
      } else {
        UpdatedValues.setSiteConstructionId(_selectedConstructionType);
      }

      if (UpdatedValues.getNoOfFloors() != null) {
        _selectedSiteFloor = null;
        _selectedSiteFloor = UpdatedValues.getNoOfFloors();
      } else {
        UpdatedValues.setNoOfFloors(_selectedSiteFloor);
      }

      if (UpdatedValues.getSiteBuiltArea() != null) {
        siteBuiltupArea.text = UpdatedValues.getSiteBuiltArea();
      } else {
        UpdatedValues.setSiteBuiltArea(siteBuiltupArea.text);
      }

      if (UpdatedValues.getBathroomCount() != null) {
        _totalBathroomCount = UpdatedValues.getBathroomCount();
      } else {
        UpdatedValues.setBathroomCount(_totalBathroomCount);
      }

      if (UpdatedValues.getKitchenCount() != null) {
        _totalKitchenCount = UpdatedValues.getKitchenCount();
      } else {
        UpdatedValues.setKitchenCount(_totalKitchenCount);
      }

      if (UpdatedValues.getSiteTotalPotential() != null) {
        _siteTotalBags.text = UpdatedValues.getSiteTotalPotential();
      } else {
        UpdatedValues.setSiteTotalPotential(_siteTotalBags.text);
      }

      if (UpdatedValues.getTotalBalancePotential() != null) {
        _siteTotalBalanceBags.text = UpdatedValues.getTotalBalancePotential();
      } else {
        UpdatedValues.setTotalBalancePotential(_siteTotalBalanceBags.text);
      }
    });
  }

  @override
  void initState() {
    setSiteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return siteDataView();
  }

  Widget siteDataView() {
    return ListView(
      children: [
        Container(
            child: Form(
                key: _updateFormKey,
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
                            value: _selectedConstructionType,
                            items: constructionStageEntity
                                .map((label) => DropdownMenuItem(
                                      child: Text(
                                        label.constructionStageText,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                      ),
                                      value: label,
                                    ))
                                .toList(),
                            onChanged: (_) => setState(() {
                              _selectedConstructionType = _;
                              UpdatedValues.setSiteConstructionId(
                                  _selectedConstructionType);
                            }),
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Stage of Construction"),
                          ),
                          TextStyles.mandatoryText,
                          SizedBox(height: 16),
                          TextFormField(
                              controller: siteBuiltupArea,
                              onChanged: (String _) => setState(() {
                                    UpdatedValues.setSiteBuiltArea(_);
                                  }),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Site Built-Up Area (sqft)';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                                TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  try {
                                    final text = newValue.text;
                                    if (text.isNotEmpty) double.parse(text);
                                    return newValue;
                                  } catch (e) {}
                                  return oldValue;
                                }),
                              ],
                              decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Site Built-up area (sqft)")),

                          TextStyles.mandatoryText,
                          SizedBox(height: 16),
                          Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, left: 5),
                              child: Text("No. of Floors",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Muli"))),
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
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorConstants
                                                  .backgroundColorBlue,
                                              width: 1.0)),
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
                                    onChanged: (value) {
                                      setState(() {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        _selectedSiteFloor = value;
                                        UpdatedValues.setNoOfFloors(
                                            _selectedSiteFloor);
                                      });
                                    },
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "+ Floors"),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _totalBathroomCount,
                            onChanged: (String text) {
                              setState(() {
                                UpdatedValues.setBathroomCount(
                                    _totalBathroomCount);
                              });
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Bathroom Count",
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _totalKitchenCount,
                            onChanged: (String text) {
                              setState(() {
                                UpdatedValues.setKitchenCount(
                                    _totalKitchenCount);
                              });
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Kitchen Count",
                            ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Product demo",
                                        style: TextStyle(
                                            fontSize: 18, fontFamily: "Muli")),
                                    Row(children: [
                                      Text("No",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: "Muli")),
                                      Switch(
                                          onChanged: toggleSwitchForProductDemo,
                                          value: isSwitchedsiteProductDemo,
                                          activeColor: HexColor("#009688"),
                                          activeTrackColor: HexColor("#009688")
                                              .withOpacity(0.5),
                                          inactiveThumbColor:
                                              HexColor("#F1F1F1"),
                                          inactiveTrackColor: Colors.black26),
                                      Text("Yes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: isSwitchedsiteProductDemo
                                                  ? HexColor("#009688")
                                                  : Colors.black,
                                              fontFamily: "Muli"))
                                    ])
                                  ])),
                          Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Product oral briefing",
                                        style: TextStyle(
                                            fontSize: 16, fontFamily: "Muli")),
                                    Row(children: [
                                      Text("No",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: "Muli")),
                                      Switch(
                                          onChanged:
                                              toggleSwitchForOralBriefing,
                                          value:
                                              isSwitchedsiteProductOralBriefing,
                                          activeColor: HexColor("#009688"),
                                          activeTrackColor: HexColor("#009688")
                                              .withOpacity(0.5),
                                          inactiveThumbColor:
                                              HexColor("#F1F1F1"),
                                          inactiveTrackColor: Colors.black26),
                                      Text("Yes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color:
                                                  isSwitchedsiteProductOralBriefing
                                                      ? HexColor("#009688")
                                                      : Colors.black,
                                              fontFamily: "Muli"))
                                    ])
                                  ])),

                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20, left: 5),
                              child: Text("Total Site Potential",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      fontFamily: "Muli"))),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: TextFormField(
                                    controller: _siteTotalBags,
                                    onChanged: (value) {
                                      setState(() {
                                        if (_siteTotalBags.text == null ||
                                            _siteTotalBags.text == "") {
                                          _siteTotalPt.clear();
                                        } else {
                                          _siteTotalPt.text =
                                              (int.parse(_siteTotalBags.text) /
                                                      20)
                                                  .toString();

                                          UpdatedValues.setSitePotentialMt(
                                              _siteTotalPt.text);
                                          UpdatedValues.setSiteTotalPotential(
                                              _siteTotalBags.text);
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
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "Bags"),
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
                                        if (_siteTotalPt.text == null ||
                                            _siteTotalPt.text == "") {
                                          _siteTotalBags.clear();
                                        } else {
                                          _siteTotalBags.text =
                                              (double.parse(_siteTotalPt.text) *
                                                      20)
                                                  .toInt()
                                                  .toString();
                                          UpdatedValues.setSitePotentialMt(
                                              _siteTotalPt.text);
                                          UpdatedValues.setSiteTotalPotential(
                                              _siteTotalBags.text);
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
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: false),
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "MT"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 20, left: 5),
                            child: Text(
                              "Total Balance Potential",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
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
                                    controller: _siteTotalBalanceBags,
                                    onChanged: (value) {
                                      setState(() {
                                        // _totalBags.text = value ;
                                        if (_siteTotalBalanceBags.text ==
                                                null ||
                                            _siteTotalBalanceBags.text == "") {
                                          _siteTotalBalancePt.clear();
                                        } else {
                                          _siteTotalBalancePt.text = (int.parse(
                                                      _siteTotalBalanceBags
                                                          .text) /
                                                  20)
                                              .toString();

                                          UpdatedValues
                                              .setTotalBalancePotential(
                                                  _siteTotalBalanceBags.text);
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
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Bags",
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextFormField(
                                    controller: _siteTotalBalancePt,
                                    onChanged: (value) {
                                      setState(() {
                                        // _totalBags.text = value ;
                                        if (_siteTotalBalancePt.text == null ||
                                            _siteTotalBalancePt.text == "") {
                                          _siteTotalBalanceBags.clear();
                                        } else {
                                          _siteTotalBalanceBags.text =
                                              (double.parse(_siteTotalBalancePt
                                                          .text) *
                                                      20)
                                                  .toInt()
                                                  .toString();
                                          UpdatedValues
                                              .setTotalBalancePotential(
                                                  _siteTotalBalanceBags.text);
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
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "MT",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          DropdownButtonFormField<SiteProbabilityWinningEntity>(
                            value: _siteProbabilityWinningEntity,
                            items: viewSiteDataResponse.sitesModal != null &&
                                    viewSiteDataResponse.sitesModal
                                            .siteProbabilityWinningId !=
                                        null
                                ? [_siteProbabilityWinningEntity]
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label == null
                                                ? ""
                                                : label.siteProbabilityStatus,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: ColorConstants
                                                    .inputBoxHintColor,
                                                fontFamily: "Muli"),
                                          ),
                                          value: label,
                                        ))
                                    .toList()
                                : siteProbabilityWinningEntity
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label == null
                                                ? ""
                                                : label.siteProbabilityStatus,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: ColorConstants
                                                    .inputBoxHintColor,
                                                fontFamily: "Muli"),
                                          ),
                                          value: label,
                                        ))
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                labelProbabilityText =
                                    value.siteProbabilityStatus;
                                labelProbabilityId = value.id;
                                _siteProbabilityWinningEntity = value;
                                UpdatedValues.setSiteProbabilityWinningId(
                                    _siteProbabilityWinningEntity);
                              });
                            },
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Probability of winning",
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15),
                          //   child: Text(
                          //     "Mandatory",
                          //     style: TextStyle(
                          //       fontFamily: "Muli",
                          //       color: ColorConstants.inputBoxHintColorDark,
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //   ),
                          // ),
                          TextStyles.mandatoryText,
                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            controller: _completionStatus,
                            readOnly: true,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Competition Status",
                            ),
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                          ),
                          /*
                          DropdownButtonFormField<SiteCompetitionStatusEntity>(
                            value: _siteCompetitionStatusEntity,
                            items: viewSiteDataResponse.sitesModal != null &&
                                    viewSiteDataResponse
                                            .sitesModal.siteCompetitionId !=
                                        null
                                ? [_siteCompetitionStatusEntity]
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label == null
                                                ? ""
                                                : label.competitionStatus,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: ColorConstants
                                                    .inputBoxHintColor,
                                                fontFamily: "Muli"),
                                          ),
                                          value: label,
                                        ))
                                    .toList()
                                : siteCompetitionStatusEntity
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label == null
                                                ? ""
                                                : label.competitionStatus,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: ColorConstants
                                                    .inputBoxHintColor,
                                                fontFamily: "Muli"),
                                          ),
                                          value: label,
                                        ))
                                    .toList(),
                            // onChanged: (value) {
                            //   setState(() {
                            //     _siteCompetitionStatusEntity = value;
                            //     UpdatedValues.setSiteCompetitionId(
                            //         _siteCompetitionStatusEntity);
                            //   });
                            // },
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Competition Status",
                            ),
                          ),
                          */
                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            controller: _opportunityStatus,
                            readOnly: true,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Opportunity Status",
                            ),
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                          ),
                          /*
                          DropdownButtonFormField<SiteOpportunityStatusEntity>(
                            value: _siteOpportunitStatusEnity,
                            items: viewSiteDataResponse.sitesModal != null &&
                                    viewSiteDataResponse
                                            .sitesModal.siteOppertunityId !=
                                        null
                                ? [_siteOpportunitStatusEnity]
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label == null
                                                ? ""
                                                : label.opportunityStatus,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: ColorConstants
                                                    .inputBoxHintColor,
                                                fontFamily: "Muli"),
                                          ),
                                          value: label,
                                        ))
                                    .toList()
                                : siteOpportunityStatusEntity
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label == null
                                                ? ""
                                                : label.opportunityStatus,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: ColorConstants
                                                    .inputBoxHintColor,
                                                fontFamily: "Muli"),
                                          ),
                                          value: label,
                                        ))
                                    .toList(),
                            // onChanged: (value) {
                            //   setState(() {
                            //     _siteOpportunitStatusEnity = value;
                            //     UpdatedValues.setSiteOppertunityId(
                            //         _siteOpportunitStatusEnity);
                            //   });
                            // },
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Opportunity Status",
                            ),
                          ),

                           */
                          SizedBox(height: 25),
                          TextFormField(
                            controller: _ownerName,
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.length <= 0 ||
                                  value == null ||
                                  value == " " ||
                                  value.trim().isEmpty) {
                                return 'Please enter Owner Name';
                              }
                              return null;
                            },
                            onChanged: (data) {
                              setState(() {
                                UpdatedValues.setContactName(data);
                              });
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Owner Name"),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15),
                          //   child: Text(
                          //     "Mandatory",
                          //     style: TextStyle(
                          //       fontFamily: "Muli",
                          //       color: ColorConstants.inputBoxHintColorDark,
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //   ),
                          // ),
                          TextStyles.mandatoryText,
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
                              if (!Validations.isValidPhoneNumber(value)) {
                                return 'Enter valid Contact number';
                              }
                              return null;
                            },
                            onChanged: (data) {
                              setState(() {
                                UpdatedValues.setContactNumber(data);
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
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Contact Number",
                            ),
                          ),
                          TextStyles.mandatoryText,
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15),
                          //   child: Text(
                          //     "Mandatory",
                          //     style: TextStyle(
                          //       fontFamily: "Muli",
                          //       color: ColorConstants.inputBoxHintColorDark,
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //   ),
                          // ),
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
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(color: Colors.black26)),
                                  backgroundColor: Colors.transparent,
                                ),
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
                                    UpdatedValues.setSiteGeotag(geoTagType);
                                  });
                                  Get.dialog(Center(
                                    child: CircularProgressIndicator(),
                                  ));
                                  _getCurrentLocation();
                                },
                              ),
                              Text(
                                "Or",
                                style:
                                    TextStyle(fontFamily: "Muli", fontSize: 17),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side:
                                            BorderSide(color: Colors.black26)),
                                    backgroundColor: Colors.transparent,
                                  ),
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
                                    var data = [];
                                    data = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CustomMap()));
                                    setState(() {
                                      geoTagType = "M";
                                      UpdatedValues.setSiteGeotag(geoTagType);
                                    });
                                    _currentPosition =
                                        new LatLng(data[0], data[1]);
                                    _getAddressFromLatLng();
                                  }),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _plotNumber,
                            onChanged: (String data) {
                              UpdatedValues.setPlotNumber(_plotNumber.text);
                            },
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please enter Address ';
                            //   }
                            //
                            //   return null;
                            // },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Plot No.",
                            ),
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
                              onChanged: (String data) {
                                UpdatedValues.setSiteAddress(_siteAddress.text);
                              },
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstants.inputBoxHintColor,
                                  fontFamily: "Muli"),
                              keyboardType: TextInputType.text,
                              decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Address",
                              )),
                          SizedBox(height: 16),
                          TextFormField(
                            //initialValue: _pincode.toString(),
                            controller: _pincode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Pincode ';
                              }
                              // if (value.length <= 6) {
                              //   return 'Pincode is incorrect';
                              // }

                              return null;
                            },
                            onChanged: (String data) {
                              UpdatedValues.setSitePincode(_pincode.text);
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
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Pincode",
                            ),
                          ),
                          TextStyles.mandatoryText,
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _state,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter State ';
                              }

                              return null;
                            },
                            onChanged: (String data) {
                              UpdatedValues.setSiteState(_state.text);
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "State",
                            ),
                          ),
                          TextStyles.mandatoryText,
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _district,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter District ';
                              }

                              return null;
                            },
                            onChanged: (String data) {
                              UpdatedValues.setSiteDistrict(_district.text);
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "District",
                            ),
                          ),

                          TextStyles.mandatoryText,
                          SizedBox(height: 16),

                          TextFormField(
                            controller: _taluk,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Taluk ';
                              }

                              return null;
                            },
                            onChanged: (String data) {
                              UpdatedValues.setSiteTaluk(_taluk.text);
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Taluk",
                            ),
                          ),

                          TextStyles.mandatoryText,

                          SizedBox(height: 16),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(color: Colors.black26),
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, bottom: 10, top: 10),
                                child: Text(
                                  "UPLOAD PHOTOS",
                                  style: TextStyle(
                                      color: HexColor("#1C99D4"),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              onPressed: () async {
                                if (_imgDetails.length < 5) {
                                  _showPicker(context);
                                } else {
                                  Get.dialog(CustomDialogs().showMessage(
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _imgDetails.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                return showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: new Container(
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
                                                      color:
                                                          HexColor("#FFCD00"),
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
                            onChanged: (String data) {
                              UpdatedValues.setReraNumber(data);
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "RERA",
                            ),
                          ),

                          SizedBox(height: 16),

                          TextFormField(
                            controller: _dealerName,
                            readOnly: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Counter",
                            ),
                          ),

                          SizedBox(height: 16),

                          TextFormField(
                            controller: _so,
                            onChanged: (String data) {
                              UpdatedValues.setSoCode(data);
                            },
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.text,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "SO",
                            ),
                          ),

                          SizedBox(height: 51),

                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: HexColor("#1C99D4"),
                                ),
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
                                  if (_updateFormKey.currentState.validate()) {
                                    UpdatedValues updateRequest =
                                        new UpdatedValues();
                                    updateRequest.updateRequest(context);
                                  }
                                }),
                          ),
                          SizedBox(height: 40),
                        ]))))
      ],
    );
  }

  void toggleSwitchForProductDemo(bool value) {
    if (isSwitchedsiteProductDemo == false) {
      setState(() {
        isSwitchedsiteProductDemo = true;
        _siteProductDemo.text = "Y";
        UpdatedValues.setProductDemo(_siteProductDemo.text);
      });
    } else {
      setState(() {
        isSwitchedsiteProductDemo = false;
        _siteProductDemo.text = "N";
        UpdatedValues.setProductDemo(_siteProductDemo.text);
      });
    }
  }

  void toggleSwitchForOralBriefing(bool value) {
    if (isSwitchedsiteProductOralBriefing == false) {
      setState(() {
        isSwitchedsiteProductOralBriefing = true;
        _siteProductOralBriefing.text = "Y";
        UpdatedValues.setProductOralBriefing(_siteProductOralBriefing.text);
      });
    } else {
      setState(() {
        isSwitchedsiteProductOralBriefing = false;
        _siteProductOralBriefing.text = "N";
        UpdatedValues.setProductOralBriefing(_siteProductOralBriefing.text);
      });
    }
  }

  _getCurrentLocation() async {
    if (!(await GetCurrentLocation.checkLocationPermission())) {
      Get.back();
      Get.dialog(CustomDialogs().showMessage(
          "Please enable your location service from device settings"));
    } else {
      LocationDetails result;
      result = await GetCurrentLocation.getCurrentLocation();
      setState(() {
        _currentPosition = result.latLng;
        List<String> loc = result.loc;
        _siteAddress.text = "${loc[7]}, ${loc[6]}, ${loc[4]}";
        _district.text = "${loc[2]}";
        _state.text = "${loc[1]}";
        _pincode.text = "${loc[5]}";
        _taluk.text = "${loc[3]}";
        UpdatedValues.setSiteAddress(_siteAddress.text);
        UpdatedValues.setSiteDistrict(_district.text);
        UpdatedValues.setSiteState(_state.text);
        UpdatedValues.setSitePincode(_pincode.text);
        UpdatedValues.setSiteTaluk(_taluk.text);
        UpdatedValues.setSiteTaluk(_taluk.text);
        UpdatedValues.setSiteGeotagLat(_currentPosition.latitude);
        UpdatedValues.setSiteGeotagLong(_currentPosition.longitude);
      });
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _siteAddress.text =
            place.name + "," + place.thoroughfare + "," + place.subLocality;
        _district.text = place.subAdministrativeArea;
        _state.text = place.administrativeArea;
        _pincode.text = place.postalCode;
        _taluk.text = place.locality;
        UpdatedValues.setSiteAddress(_siteAddress.text);
        UpdatedValues.setSiteDistrict(_district.text);
        UpdatedValues.setSiteState(_state.text);
        UpdatedValues.setSitePincode(_pincode.text);
        UpdatedValues.setSiteTaluk(_taluk.text);
        UpdatedValues.setSiteGeotagLat(_currentPosition.latitude);
        UpdatedValues.setSiteGeotagLong(_currentPosition.longitude);
        //txt.text = place.postalCode;
      });
    } catch (e) {
      TsoLogger.printLog(e);
    }
  }

  _imgFromCamera() async {
    ImagePicker _picker = ImagePicker();
    XFile image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (image != null) {
        _imageList.add(File(image.path));
        _imgDetails.add(new ImageDetails("asset", File(image.path)));
        UpdatedValues.setImageList(_imageList);
      }
    });
  }

  _imgFromGallery() async {
    ImagePicker _picker = ImagePicker();
    XFile image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _imageList.add(File(image.path));
        _imgDetails.add(new ImageDetails("asset", File(image.path)));
        UpdatedValues.setImageList(_imageList);
      }
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
}

class ImageDetails {
  String from;
  File file;

  ImageDetails(this.from, this.file);
}
