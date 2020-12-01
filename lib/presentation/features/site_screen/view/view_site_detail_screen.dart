import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/UpdateDataRequest.dart'
    as updateResponse;
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class ViewSiteScreen extends StatefulWidget {
  int siteId;

  ViewSiteScreen(this.siteId);

  @override
  _ViewSiteScreenState createState() => _ViewSiteScreenState();
}

class _ViewSiteScreenState extends State<ViewSiteScreen>
    with SingleTickerProviderStateMixin {
  bool isSwitchedsiteProductDemo = false;
  bool isSwitchedsiteProductOralBriefing = false;
  bool addNextButtonDisable = false;
  bool viewMoreActive = false;
  String labelText;
  int labelId;

  ConstructionStageEntity _selectedConstructionType;
  ConstructionStageEntity _selectedConstructionTypeVisit;
  ConstructionStageEntity _selectedConstructionTypeVisitNextStage;
  SiteFloorsEntity _selectedSiteFloor;
  SiteFloorsEntity _selectedSiteVisitFloor;
  SiteFloorsEntity _selectedSiteVisitFloorNextStage;
  SiteBrandEntity _siteBrand;
  SiteBrandEntity _siteBrandNextStage;
  SiteStageEntity _siteStage;
  SiteProbabilityWinningEntity _siteProbabilityWinningEntity;
  SiteOpportunityStatusEntity _siteOpportunitStatusEnity;
  SiteCompetitionStatusEntity _siteCompetitionStatusEntity;
  List<File> _imageList = new List();
  int initialInfluencerLength;

  // SiteStageEntity _siteStageNextStage;
  var _siteBuiltupArea = new TextEditingController();
  var _siteProductDemo = new TextEditingController();
  var _siteProductOralBriefing = new TextEditingController();
  var _stagePotentialVisit = new TextEditingController();
  var _stagePotentialVisitNextStage = new TextEditingController();
  var _brandPriceVisit = new TextEditingController();
  var _brandPriceVisitNextStage = new TextEditingController();
  var _productSoldVisit = new TextEditingController();
  var _productSoldVisitNextStage = new TextEditingController();
  var _numberBagSuppliedVisit = new TextEditingController();
  var _dateofConstruction = new TextEditingController();
  var _dateofConstructionNextStage = new TextEditingController();
  var _nextVisitDate = new TextEditingController();
  var _dateOfBagSupplied = new TextEditingController();
  var _dateOfBagSuppliedNextStage = new TextEditingController();
  var _siteCurrentTotalBags = new TextEditingController();
  var _siteCurrentTotalBagsNextStage = new TextEditingController();
  var _comments = new TextEditingController();
  var _inactiveReasonText = new TextEditingController();
  var closureReasonText = new TextEditingController();

  //var _commentsRejectionController = new TextEditingController();

  var _siteTotalBags = new TextEditingController();
  var _siteTotalPt = new TextEditingController();
  var _siteTotalBalanceBags = new TextEditingController();
  var _siteTotalBalancePt = new TextEditingController();
  var _ownerName = new TextEditingController();
  var _contactNumber = new TextEditingController();
  var _stageStatus = new TextEditingController();
  var _stageStatusNextStage = new TextEditingController();

  //String _comment;
  var _rera = new TextEditingController();
  var _dealerName = new TextEditingController();
  var _so = new TextEditingController();
  var _plotNumber = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _myActivity;
  LocationResult _pickedLocation;
  Position _currentPosition = new Position();
  String _currentAddress;
  int _initialIndex = 0;
  String geoTagType;

  SitesModal sitesModal;
  List<SiteFloorsEntity> siteFloorsEntity = new List();
  List<SitephotosEntity> sitephotosEntity = new List();
  List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
  List<ConstructionStageEntity> constructionStageEntity = new List();
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity = new List();
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity = new List();
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity = new List();
  List<SiteBrandEntity> siteBrandEntity = new List();
  List<SiteInfluencerEntity> siteInfluencerEntity;
  List<InfluencerTypeEntity> influencerTypeEntity = new List();
  List<InfluencerCategoryEntity> influencerCategoryEntity = new List();

  List<SiteStageEntity> siteStageEntity = new List();
  List<InfluencerEntity> influencerEntity = new List();
  List<InfluencerDetail> _listInfluencerDetail = new List();

  // List<Influencer>

  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<SiteCommentsEntity> siteCommentsEntity = new List();

  List<ImageDetails> _imgDetails = new List();

  SiteController _siteController = Get.find();
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    //_controller.addListener(_handleTabSelection);
    print(widget.siteId);
    getSiteData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> getSiteData() async {
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _siteController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      print("AccessKey :: " + accessKeyModel.accessKey);
      await _siteController
          .getSitedetailsData(accessKeyModel.accessKey, widget.siteId)
          .then((data) {
        print("here");
        print(data);
        viewSiteDataResponse = data;

        print(viewSiteDataResponse);

        setState(() {
          addNextButtonDisable = false;
          constructionStageEntity =
              viewSiteDataResponse.constructionStageEntity;
          siteFloorsEntity = viewSiteDataResponse.siteFloorsEntity;
          siteBrandEntity = viewSiteDataResponse.siteBrandEntity;
          siteProbabilityWinningEntity =
              viewSiteDataResponse.siteProbabilityWinningEntity;
          siteCompetitionStatusEntity =
              viewSiteDataResponse.siteCompetitionStatusEntity;
          siteOpportunityStatusEntity =
              viewSiteDataResponse.siteOpportunityStatusEntity;
          siteCommentsEntity = viewSiteDataResponse.siteCommentsEntity;

          sitephotosEntity = viewSiteDataResponse.sitephotosEntity;
          influencerTypeEntity = viewSiteDataResponse.influencerTypeEntity;

          //  print(influencerTypeEntity.length);
          influencerCategoryEntity =
              viewSiteDataResponse.influencerCategoryEntity;

          if (sitephotosEntity != null) {
            for (int i = 0; i < sitephotosEntity.length; i++) {
              File file = new File(UrlConstants.baseUrlforImages +
                  "/" +
                  sitephotosEntity[i].photoName);
              _imgDetails.add(new ImageDetails("Network", file));
            }
          }

          influencerEntity = viewSiteDataResponse.influencerEntity;

          // print(viewSiteDataResponse.influencerEntity.length);
          if (viewSiteDataResponse.influencerEntity != null &&
              viewSiteDataResponse.influencerEntity.length > 0) {
            for (int i = 0;
                i < viewSiteDataResponse.influencerEntity.length;
                i++) {
              _listInfluencerDetail.add(new InfluencerDetail(
                  id: new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].id
                          .toString()),
                  inflContact: new TextEditingController(
                      text:
                          viewSiteDataResponse.influencerEntity[i].inflContact),
                  //createdBy: new TextEditingController(text: viewSiteDataResponse.influencerEntity[i].inflContact),
                  inflTypeId: new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].inflTypeId
                          .toString()),
                  inflTypeValue: inflTypeValue(new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].inflTypeId
                          .toString())),
                  inflCatId: new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].inflCatId
                          .toString()),
                  inflCatValue: inflCatValue(new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].inflCatId
                          .toString())),
                  inflName: new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].inflName),
                  ilpIntrested: new TextEditingController(
                      text: viewSiteDataResponse
                          .influencerEntity[i].ilpIntrested),
                  createdOn: new TextEditingController(
                      text: viewSiteDataResponse.influencerEntity[i].createdOn.toString()),
                  isExpanded: false));
            }
            initialInfluencerLength =
                viewSiteDataResponse.influencerEntity.length;
          }

          // _listInfluencerDetail.add(new InfluencerDetail(
          //     isExpanded: true
          // ));
          siteVisitHistoryEntity = viewSiteDataResponse.siteVisitHistoryEntity;
          print(viewSiteDataResponse.siteVisitHistoryEntity.length);
          sitesModal = viewSiteDataResponse.sitesModal;
          _siteBuiltupArea.text = sitesModal.siteBuiltArea;
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
          _siteTotalBags.text =
              (double.parse(_siteTotalPt.text) * 20).round().toString();
          // print(sitesModal.sitePlotNumber);
          _plotNumber.text = sitesModal.sitePlotNumber;
          _siteAddress.text = sitesModal.siteAddress;
          _pincode.text = sitesModal.sitePincode;
          _state.text = sitesModal.siteState;
          _district.text = sitesModal.siteDistrict;
          _taluk.text = sitesModal.siteTaluk;
          _rera.text = sitesModal.siteReraNumber;
          _dealerName.text = sitesModal.siteDealerName;
          _so.text = sitesModal.siteSoname;
          geoTagType = sitesModal.siteGeotagType;

          //   print(sitesModal.siteGeotagLatitude);
          if (sitesModal.siteGeotagLatitude != null &&
              sitesModal.siteGeotagLongitude != null &&
              sitesModal.siteGeotagLatitude != "null" &&
              sitesModal.siteGeotagLongitude != "null" &&
              sitesModal.siteGeotagLatitude != "" &&
              sitesModal.siteGeotagLongitude != "") {
            _currentPosition = new Position(
                latitude: double.parse(sitesModal.siteGeotagLatitude),
                longitude: double.parse(sitesModal.siteGeotagLongitude));
          }

          siteStageEntity = viewSiteDataResponse.siteStageEntity;
          for (int i = 0; i < siteStageEntity.length; i++) {
            if (viewSiteDataResponse.sitesModal.siteStageId.toString() ==
                siteStageEntity[i].id.toString()) {
              labelText = siteStageEntity[i].siteStageDesc;
              labelId = siteStageEntity[i].id;

              // _siteStage = new SiteStageEntity(
              //     id : siteStageEntity[i].id,
              //    siteStageDesc : siteStageEntity[i].siteStageDesc
              // );
              // _siteStage.id =siteStageEntity[i].id;
              // _siteStage.siteStageDesc = siteStageEntity[i].siteStageDesc;

              print(labelText);
              // _selectedValue.id = leadStatusEntity[i].id;
              // _selectedValue.leadStatusDesc = leadStatusEntity[i].leadStatusDesc;

            }
          }
        });
      });
      // Future.delayed(
      //     Duration.zero,
      //         () => Get.dialog(Center(),
      //         barrierDismissible: false));
      //  Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    //gv.selectedClass = widget.classroomId;
    return DefaultTabController(
        initialIndex: _initialIndex,
        length: 4,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              toolbarHeight: 180,
              title: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 210,
                      right: 0,
                      child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/Container.png',
                                fit: BoxFit.fill,
                              ),
                            ],
                          ))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 10, left: 5),
                            child: Text(
                              "Trade site details",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 25,
                                  color: HexColor("#006838"),
                                  fontFamily: "Muli"),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "ID: " + widget.siteId.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: "Muli",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 100),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 1.0, right: 1.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    //border: Border.all()
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[500],
                                          offset: Offset(5.0, 5.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 4.0)
                                    ]),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    // elevation: 100,
                                    value: _siteStage,
                                    items: siteStageEntity
                                        .map((label) => DropdownMenuItem(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  label.siteStageDesc,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: ColorConstants
                                                          .inputBoxHintColor,
                                                      fontFamily: "Muli"),
                                                ),
                                              ),
                                              value: label,
                                            ))
                                        .toList(),
                                    //  elevation: 0,
                                    iconSize: 40,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: (labelText != null)
                                          ? Text(labelText)
                                          : Text(""),
                                    ),

                                    // hint: Text('Rating'),
                                    onChanged: (value) {
                                      setState(() {
                                        // _siteStage = value;
                                        // labelId = _siteStage.id;
                                        // labelText = _siteStage.siteStageDesc;
                                        // print(labelId);

                                        if (value.id == 2) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.all(0.0),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    content: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Stack(
                                                            //

                                                            children: [
                                                              // Positioned(
                                                              //     top: 0,
                                                              //     left: 175,
                                                              //     right: 0,
                                                              //     child: Container(
                                                              //         color: Colors.white,
                                                              //         child: Column(
                                                              //           children: <Widget>[
                                                              //             Image.asset(
                                                              //               'assets/images/Container.png',
                                                              //               fit: BoxFit.fitHeight,
                                                              //             ),
                                                              //           ],
                                                              //         ))),

                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.03,
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.12,
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/rejected.png',
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Closed",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                30,
                                                                            color:
                                                                                HexColor("#B00020")),
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.03,
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "Please add your comment to complete this rejection",
                                                                          maxLines:
                                                                              2,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,

                                                                            //color: HexColor("#B00020")
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              closureReasonText,
                                                                          maxLength:
                                                                              100,
                                                                          onChanged:
                                                                              (value) async {},
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: ColorConstants.inputBoxHintColor,
                                                                              fontFamily: "Muli"),
                                                                          keyboardType:
                                                                              TextInputType.phone,
                                                                          maxLines:
                                                                              4,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  color: ColorConstants.backgroundColorBlue,
                                                                                  //color: HexColor("#0000001F"),
                                                                                  width: 1.0),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                                            ),
                                                                            labelText:
                                                                                "Comments",
                                                                            filled:
                                                                                false,
                                                                            focusColor:
                                                                                Colors.black,
                                                                            labelStyle: TextStyle(
                                                                                fontFamily: "Muli",
                                                                                color: ColorConstants.inputBoxHintColorDark,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 16.0),
                                                                            fillColor:
                                                                                ColorConstants.backgroundColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            RaisedButton(
                                                                          elevation:
                                                                              5,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                          ),
                                                                          color:
                                                                              HexColor("#1C99D4"),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10, top: 10),
                                                                            child:
                                                                                Text(
                                                                              "SUBMIT",
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 17),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            if (closureReasonText.text != null &&
                                                                                closureReasonText.text != "") {
                                                                              _siteStage = value;
                                                                              labelId = _siteStage.id;
                                                                              labelText = _siteStage.siteStageDesc;
                                                                              UpdateRequest();
                                                                            } else {
                                                                              Get.dialog(CustomDialogs().errorDialog("Please fill all details !!!"));
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.01,
                                                                      ),
                                                                      //         // Image.asset('assets/images/rejected.png'),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )));
                                              });
                                        } else if (value.id == 3) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.all(0.0),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    content: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Stack(
                                                            //

                                                            children: [
                                                              // Positioned(
                                                              //     top: 0,
                                                              //     left: 175,
                                                              //     right: 0,
                                                              //     child: Container(
                                                              //         color: Colors.white,
                                                              //         child: Column(
                                                              //           children: <Widget>[
                                                              //             Image.asset(
                                                              //               'assets/images/Container.png',
                                                              //               fit: BoxFit.fitHeight,
                                                              //             ),
                                                              //           ],
                                                              //         ))),

                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.03,
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.12,
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/rejected.png',
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Inactive",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                30,
                                                                            color:
                                                                                HexColor("#B00020")),
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.03,
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Text(
                                                                          "Please add your comment to complete this Inactive",
                                                                          maxLines:
                                                                              2,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,

                                                                            //color: HexColor("#B00020")
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.01,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _nextVisitDate,
                                                                          // validator: (value) {
                                                                          //   if (value.isEmpty) {
                                                                          //     return "Contact Name can't be empty";
                                                                          //   }
                                                                          //   //leagueSize = int.parse(value);
                                                                          //   return null;
                                                                          // },
                                                                          readOnly:
                                                                              true,
                                                                          onChanged:
                                                                              (data) {
                                                                            // setState(() {
                                                                            //   _contactName.text = data;
                                                                            // });
                                                                          },
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: ColorConstants.inputBoxHintColor,
                                                                              fontFamily: "Muli"),
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  color: ColorConstants.backgroundColorBlue,
                                                                                  //color: HexColor("#0000001F"),
                                                                                  width: 1.0),
                                                                            ),
                                                                            disabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.black26, width: 1.0),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.black26, width: 1.0),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                                            ),
                                                                            labelText:
                                                                                "Next Visit Date ",
                                                                            suffixIcon:
                                                                                IconButton(
                                                                              icon: Icon(
                                                                                Icons.date_range_rounded,
                                                                                size: 22,
                                                                                color: ColorConstants.clearAllTextColor,
                                                                              ),
                                                                              onPressed: () async {
                                                                                print("here");
                                                                                final DateTime picked = await showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: DateTime.now(),
                                                                                  firstDate: DateTime.now(),
                                                                                  lastDate: DateTime(2101),
                                                                                );

                                                                                setState(() {
                                                                                  final DateFormat formatter = DateFormat("yyyy-MM-dd");
                                                                                  final String formattedDate = formatter.format(picked);

                                                                                  _nextVisitDate.text = formattedDate;
                                                                                });
                                                                              },
                                                                            ),
                                                                            filled:
                                                                                false,
                                                                            focusColor:
                                                                                Colors.black,
                                                                            isDense:
                                                                                false,
                                                                            labelStyle: TextStyle(
                                                                                fontFamily: "Muli",
                                                                                color: ColorConstants.inputBoxHintColorDark,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 16.0),
                                                                            fillColor:
                                                                                ColorConstants.backgroundColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.01,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              _inactiveReasonText,
                                                                          maxLength:
                                                                              100,
                                                                          onChanged:
                                                                              (value) async {},
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: ColorConstants.inputBoxHintColor,
                                                                              fontFamily: "Muli"),
                                                                          keyboardType:
                                                                              TextInputType.phone,
                                                                          maxLines:
                                                                              4,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  color: ColorConstants.backgroundColorBlue,
                                                                                  //color: HexColor("#0000001F"),
                                                                                  width: 1.0),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
                                                                            ),
                                                                            errorBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                                            ),
                                                                            labelText:
                                                                                "Comments",
                                                                            filled:
                                                                                false,
                                                                            focusColor:
                                                                                Colors.black,
                                                                            labelStyle: TextStyle(
                                                                                fontFamily: "Muli",
                                                                                color: ColorConstants.inputBoxHintColorDark,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 16.0),
                                                                            fillColor:
                                                                                ColorConstants.backgroundColor,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            RaisedButton(
                                                                          elevation:
                                                                              5,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                          ),
                                                                          color:
                                                                              HexColor("#1C99D4"),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10, top: 10),
                                                                            child:
                                                                                Text(
                                                                              "SUBMIT",
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 17),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            if (_inactiveReasonText.text != null &&
                                                                                _inactiveReasonText.text != "") {
                                                                              _siteStage = value;
                                                                              labelId = _siteStage.id;
                                                                              labelText = _siteStage.siteStageDesc;
                                                                              UpdateRequest();
                                                                            } else {
                                                                              Get.dialog(CustomDialogs().errorDialog("Please fill all details !!!"));
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.01,
                                                                      ),
                                                                      //         // Image.asset('assets/images/rejected.png'),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )));
                                              });
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              elevation: 0,
              bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  //  indicatorColor: Colors.black,
                  labelColor: HexColor("#007CBF"),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: HexColor("#007CBF").withOpacity(0.1)),
                  tabs: [
                    Tab(
                      text: "Site Data",
                    ),
                    Tab(
                      text: "Visit Data",
                    ),
                    Tab(
                      text: "Influencer",
                    ),
                    Tab(
                      text: "Past Stage History",
                    ),
                  ]),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                siteDataView(),
                visitDataView(),
                influencerView(),
                pastStageHistoryview(),
              ],
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
                  },
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                              Get.toNamed(Routes.HOME_SCREEN);
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        DraftLeadListScreen()));
                          },
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
                          onPressed: () {
                            Get.toNamed(Routes.SEARCH_SCREEN);
                          },
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
            )
            //child:Text("classroomName")
            ));
  }

  Widget siteDataView() {
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
                        DropdownButtonFormField<ConstructionStageEntity>(
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
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Type of Construction",
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Site Built-up area",
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
                                  decoration: InputDecoration(
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
                                          color: Colors.black26, width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    labelText: "+ Floors",
                                    filled: false,
                                    focusColor: Colors.black,
                                    isDense: false,
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
                                    labelText: "Bags",
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
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    labelText: "MT",
                                    filled: false,
                                    //enabled: false,
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
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Owner Name",
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
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.backgroundColorBlue,
                                  //color: HexColor("#0000001F"),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Plot No.",
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.backgroundColorBlue,
                                  //color: HexColor("#0000001F"),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "RERA",
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
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.backgroundColorBlue,
                                  //color: HexColor("#0000001F"),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Dealer",
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
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.backgroundColorBlue,
                                  //color: HexColor("#0000001F"),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "SO",
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

  Widget visitDataView() {
    return SingleChildScrollView(
        child: Container(
            child: Form(
                child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current Stage",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        // color: HexColor("#000000DE"),
                        fontFamily: "Muli"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _initialIndex = 3;
                        _tabController.animateTo(3);
                      });
                    },
                    child: Text(
                      "View previous detail",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: HexColor("#F9A61A"),
                          fontFamily: "Muli"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
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
                          if (_siteTotalBalanceBags.text == null ||
                              _siteTotalBalanceBags.text == "") {
                            _siteTotalBalancePt.clear();
                          } else {
                            _siteTotalBalancePt.text =
                                (int.parse(_siteTotalBalanceBags.text) / 20)
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
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
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
                      controller: _siteTotalBalancePt,
                      onChanged: (value) {
                        setState(() {
                          // _totalBags.text = value ;
                          if (_siteTotalBalancePt.text == null ||
                              _siteTotalBalancePt.text == "") {
                            _siteTotalBalanceBags.clear();
                          } else {
                            _siteTotalBalanceBags.text =
                                (int.parse(_siteTotalBalancePt.text) * 20)
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black26,
                thickness: 1,
              ),
            ),
            DropdownButtonFormField<SiteFloorsEntity>(
              value: _selectedSiteVisitFloor,
              items: siteFloorsEntity
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.siteFloorTxt,
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
                  _selectedSiteVisitFloor = value;
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
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Floor",
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
            DropdownButtonFormField<ConstructionStageEntity>(
              value: _selectedConstructionTypeVisit,
              items: constructionStageEntity
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.constructionStageText,
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
                  _selectedConstructionTypeVisit = value;
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
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Type of Construction",
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
              controller: _stagePotentialVisit,
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
                labelText: "Stage Potential",
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
            DropdownButtonFormField<SiteBrandEntity>(
              value: _siteBrand,
              items: siteBrandEntity
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.brandName,
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
                  _siteBrand = value;
                  _productSoldVisit.text = _siteBrand.productName;
                  if (_siteBrand.brandName.toLowerCase() == "dalmia") {
                    _stageStatus.text = "WON";
                  } else {
                    _stageStatus.text = "LOST";
                  }
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
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Brand in use",
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
              controller: _brandPriceVisit,
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
                labelText: "Brand Price",
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
              controller: _productSoldVisit,
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstants.backgroundColorBlue,
                      //color: HexColor("#0000001F"),
                      width: 1.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF000000).withOpacity(0.4),
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
                labelText: "Product Sold",
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
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
              child: Text(
                "No. of Nags Supplied",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
                      controller: _dateOfBagSupplied,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Contact Name can't be empty";
                      //   }
                      //   //leagueSize = int.parse(value);
                      //   return null;
                      // },
                      readOnly: true,
                      onChanged: (data) {
                        // setState(() {
                        //   _contactName.text = data;
                        // });
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
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Date ",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: ColorConstants.clearAllTextColor,
                          ),
                          onPressed: () async {
                            print("here");
                            final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime.now(),
                            );

                            setState(() {
                              final DateFormat formatter =
                                  DateFormat("yyyy-MM-dd");
                              final String formattedDate =
                                  formatter.format(picked);

                              _dateOfBagSupplied.text = formattedDate;
                            });
                          },
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: _siteCurrentTotalBags,
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
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
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
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "No. Of Bags",
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
                ),
              ],
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
              controller: _stageStatus,
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
              keyboardType: TextInputType.text,
              enabled: false,
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
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color(0xFF000000).withOpacity(0.4),
                      width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Stage Status",
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
              controller: _dateofConstruction,
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return "Contact Name can't be empty";
              //   }
              //   //leagueSize = int.parse(value);
              //   return null;
              // },
              readOnly: true,
              onChanged: (data) {
                // setState(() {
                //   _contactName.text = data;
                // });
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
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Date of construction",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.date_range_rounded,
                    size: 22,
                    color: ColorConstants.clearAllTextColor,
                  ),
                  onPressed: () async {
                    print("here");
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime.now(),
                    );

                    setState(() {
                      final DateFormat formatter = DateFormat("yyyy-MM-dd");
                      final String formattedDate = formatter.format(picked);

                      _dateofConstruction.text = formattedDate;
                    });
                  },
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: !addNextButtonDisable
                    ? FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 10, top: 10),
                          child: Text(
                            "ADD NEXT STAGE",
                            style: TextStyle(
                                color: HexColor("#1C99D4"),
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            addNextButtonDisable = !addNextButtonDisable;
                          });
                        },
                      )
                    : FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 10, top: 10),
                          child: Text(
                            "HIDE NEXT STAGE",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                // letterSpacing: 2,
                                fontSize: 17),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            addNextButtonDisable = !addNextButtonDisable;
                          });
                        },
                      ),
              ),
            ),

            ////Add Next Stage Container

            addNextButtonDisable ? addNextStageContainer() : Container(),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),

            DropdownButtonFormField<SiteProbabilityWinningEntity>(
              value: _siteProbabilityWinningEntity,
              items: siteProbabilityWinningEntity
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.siteProbabilityStatus,
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
                  _siteProbabilityWinningEntity = value;
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
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Probability of winning",
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
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<SiteCompetitionStatusEntity>(
              value: _siteCompetitionStatusEntity,
              items: siteCompetitionStatusEntity
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.competitionStatus,
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
                  _siteCompetitionStatusEntity = value;
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
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Competition Status",
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
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<SiteOpportunityStatusEntity>(
              value: _siteOpportunitStatusEnity,
              items: siteOpportunityStatusEntity
                  .map((label) => DropdownMenuItem(
                        child: Text(
                          label.opportunityStatus,
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
                  _siteOpportunitStatusEnity = value;
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
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Opportunity Status",
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
              controller: _nextVisitDate,
              // validator: (value) {
              //   if (value.isEmpty) {
              //     return "Contact Name can't be empty";
              //   }
              //   //leagueSize = int.parse(value);
              //   return null;
              // },
              readOnly: true,
              onChanged: (data) {
                // setState(() {
                //   _contactName.text = data;
                // });
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
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                labelText: "Next Visit Date ",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.date_range_rounded,
                    size: 22,
                    color: ColorConstants.clearAllTextColor,
                  ),
                  onPressed: () async {
                    print("here");
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    setState(() {
                      final DateFormat formatter = DateFormat("yyyy-MM-dd");
                      final String formattedDate = formatter.format(picked);

                      _nextVisitDate.text = formattedDate;
                    });
                  },
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
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(height: 16),

            TextFormField(
              maxLines: 4,
              maxLength: 500,
              // initialValue: _comments.text,
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
                print(_comments.text);
                // setState(() {
                //   _comments.text = value;
                // });
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

            siteCommentsEntity != null && siteCommentsEntity.length != 0
                ? viewMoreActive
                    ? Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: siteCommentsEntity.length,
                                itemBuilder: (BuildContext context, int index) {
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
                                            siteCommentsEntity[index]
                                                    .creatorName ??
                                                "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          ),
                                          Text(
                                            siteCommentsEntity[index]
                                                    .siteCommentText ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 25),
                                          ),
                                          Text(
                                            siteCommentsEntity[index]
                                                    .createdOn
                                                    .toString() ??
                                                "",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                siteCommentsEntity[
                                        siteCommentsEntity.length - 1]
                                    .creatorName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Text(
                                siteCommentsEntity[
                                        siteCommentsEntity.length - 1]
                                    .siteCommentText,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 25),
                              ),
                              Text(
                                siteCommentsEntity[
                                        siteCommentsEntity.length - 1]
                                    .createdOn
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
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

            Center(
              child: FlatButton(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(0),
                //     side: BorderSide(color: Colors.black26)),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
                  child: !viewMoreActive
                      ? Text(
                          "VIEW MORE COMMENT (" +
                              siteCommentsEntity.length.toString() +
                              ")",
                          style: TextStyle(
                              color: HexColor("##F9A61A"),
                              fontWeight: FontWeight.bold,
                              // letterSpacing: 2,
                              fontSize: 17),
                        )
                      : Text(
                          "VIEW LESS COMMENT (" +
                              siteCommentsEntity.length.toString() +
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
                },
              ),
            ),

            SizedBox(height: 35),

            Center(
              child: RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: HexColor("#1C99D4"),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
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
          ]),
    ))));
  }

  Widget influencerView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
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
                                  _listInfluencerDetail[index].isExpanded
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listInfluencerDetail[index]
                                                      .isExpanded =
                                                  !_listInfluencerDetail[index]
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listInfluencerDetail[index]
                                                      .isExpanded =
                                                  !_listInfluencerDetail[index]
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
                                  _listInfluencerDetail[index].isExpanded
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listInfluencerDetail[index]
                                                      .isExpanded =
                                                  !_listInfluencerDetail[index]
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _listInfluencerDetail[index]
                                                      .isExpanded =
                                                  !_listInfluencerDetail[index]
                                                      .isExpanded;
                                            });
                                            // _getCurrentLocation();
                                          },
                                        ),
                                ],
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller:
                                    _listInfluencerDetail[index].inflContact,
                                maxLength: 10,
                                onChanged: (value) async {
                                  bool match = false;
                                  if (value.length < 10) {
                                    // _listInfluencerDetail[
                                    // index]
                                    //     .inflContact
                                    //     .clear();
                                    if (_listInfluencerDetail[index].inflName !=
                                        null) {
                                      _listInfluencerDetail[index]
                                          .inflName
                                          .clear();
                                      _listInfluencerDetail[index]
                                          .inflTypeValue
                                          .clear();
                                      _listInfluencerDetail[index]
                                          .inflCatValue
                                          .clear();
                                    }
                                  } else if (value.length == 10) {
                                    var bodyEncrypted = {
                                      //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
                                      "inflContact": value
                                    };

                                    for (int i = 0;
                                        i < _listInfluencerDetail.length - 1;
                                        i++) {
                                      if (value ==
                                          _listInfluencerDetail[i]
                                              .inflContact
                                              .text) {
                                        match = true;
                                        break;
                                      }
                                    }

                                    if (match) {
                                      Get.dialog(CustomDialogs().errorDialog(
                                          "Already added influencer : " +
                                              value));
                                    } else {
                                      String empId;
                                      String mobileNumber;
                                      String name;
                                      Future<SharedPreferences> _prefs =
                                          SharedPreferences.getInstance();
                                      await _prefs
                                          .then((SharedPreferences prefs) {
                                        empId = prefs.getString(
                                                StringConstants.employeeId) ??
                                            "empty";
                                        mobileNumber = prefs.getString(
                                                StringConstants.mobileNumber) ??
                                            "empty";
                                        name = prefs.getString(
                                                StringConstants.employeeName) ??
                                            "empty";
                                        print(_comments.text);
                                      });
                                      AddLeadsController _addLeadsController =
                                          Get.find();
                                      _addLeadsController.phoneNumber = value;
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
                                          InfluencerDetail inflDetail = data;
                                          print(inflDetail.inflName.text);

                                          setState(() {
                                            if (inflDetail.inflName.text !=
                                                "null") {
                                              _listInfluencerDetail[index]
                                                      .inflContact =
                                                  new TextEditingController();
                                              ;
                                              _listInfluencerDetail[index]
                                                      .inflName =
                                                  new TextEditingController();
                                              FocusScope.of(context).unfocus();
                                              //  print(inflDetail.inflName.text);
                                              _listInfluencerDetail[index]
                                                      .inflTypeId =
                                                  new TextEditingController();
                                              _listInfluencerDetail[index]
                                                      .inflCatId =
                                                  new TextEditingController();
                                              _listInfluencerDetail[index]
                                                      .inflTypeValue =
                                                  new TextEditingController();
                                              _listInfluencerDetail[index]
                                                      .inflCatValue =
                                                  new TextEditingController();

                                              print(inflDetail.inflName);

                                              _listInfluencerDetail[index]
                                                      .inflContact =
                                                  inflDetail.inflContact;
                                              _listInfluencerDetail[index]
                                                      .inflName =
                                                  inflDetail.inflName;
                                              _listInfluencerDetail[index].id =
                                                  inflDetail.id;
                                              _listInfluencerDetail[index]
                                                      .ilpIntrested =
                                                  inflDetail.ilpIntrested;
                                              _listInfluencerDetail[index]
                                                      .createdOn =
                                                  inflDetail.createdOn;
                                              _listInfluencerDetail[index]
                                                      .inflTypeValue =
                                                  inflDetail.inflTypeValue;
                                              _listInfluencerDetail[index]
                                                      .inflCatValue =
                                                  inflDetail.inflCatValue;

                                              print(_listInfluencerDetail[index]
                                                  .inflName);

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
                                                  _listInfluencerDetail[index]
                                                          .inflTypeId =
                                                      inflDetail.inflTypeId;
                                                  //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                  _listInfluencerDetail[index]
                                                      .inflTypeValue
                                                      .text = influencerTypeEntity[
                                                          influencerTypeEntity[
                                                                      i]
                                                                  .inflTypeId -
                                                              1]
                                                      .inflTypeDesc;
                                                  break;
                                                } else {
                                                  // _listInfluencerDetail[
                                                  // index]
                                                  //     .inflContact
                                                  //     .clear();
                                                  // _listInfluencerDetail[
                                                  // index]
                                                  //     .inflName
                                                  //     .clear();
                                                  _listInfluencerDetail[index]
                                                      .inflTypeId
                                                      .clear();
                                                  _listInfluencerDetail[index]
                                                      .inflTypeValue
                                                      .clear();
                                                }
                                              }
                                              print(_listInfluencerDetail[index]
                                                  .inflName);
                                              // _influencerType.text = influencerTypeEntity[inflDetail.inflTypeId].inflTypeDesc;

                                              for (int i = 0;
                                                  i <
                                                      influencerCategoryEntity
                                                          .length;
                                                  i++) {
                                                if (influencerCategoryEntity[i]
                                                        .inflCatId
                                                        .toString() ==
                                                    inflDetail.inflCatId.text) {
                                                  _listInfluencerDetail[index]
                                                          .inflCatId =
                                                      inflDetail.inflCatId;
                                                  //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                  _listInfluencerDetail[index]
                                                          .inflCatValue
                                                          .text =
                                                      influencerCategoryEntity[
                                                              influencerCategoryEntity[
                                                                          i]
                                                                      .inflCatId -
                                                                  1]
                                                          .inflCatDesc;
                                                  break;
                                                } else {
                                                  _listInfluencerDetail[index]
                                                      .inflCatId
                                                      .clear();
                                                  _listInfluencerDetail[index]
                                                      .inflCatValue
                                                      .clear();
                                                }
                                              }
                                            } else {
                                              _listInfluencerDetail[index]
                                                  .inflContact
                                                  .clear();
                                              _listInfluencerDetail[index]
                                                  .inflName
                                                  .clear();
                                            }
                                          });
                                          Get.back();
                                        });
                                      });

                                      print("Dhawan :: ");
                                    }
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
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                //  initialValue: _listInfluencerDetail[index].inflName,
                                controller:
                                    _listInfluencerDetail[index].inflName,

                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter Influencer Number ';
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
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller:
                                    _listInfluencerDetail[index].inflTypeValue,
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter Influencer Number ';
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
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller:
                                    _listInfluencerDetail[index].inflCatValue,
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please enter Influencer Number ';
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
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
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
                  padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
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
                  // //  print(_listInfluencerDetail[
                  //   _listInfluencerDetail.length - 1]
                  //       .inflName);
                  if (_listInfluencerDetail != null &&
                      _listInfluencerDetail.length != 0) {
                    if (_listInfluencerDetail[_listInfluencerDetail.length - 1]
                                .inflName !=
                            null &&
                        _listInfluencerDetail[_listInfluencerDetail.length - 1]
                                .inflName
                                .text !=
                            "null" &&
                        !_listInfluencerDetail[_listInfluencerDetail.length - 1]
                            .inflName
                            .text
                            .isNullOrBlank) {
                      InfluencerDetail infl =
                          new InfluencerDetail(isExpanded: true);

                      // Item item = new Item(
                      //     headerValue: "agx ", expandedValue: "dnxcx");
                      setState(() {
                        // _data.add(item);
                        _listInfluencerDetail[_listInfluencerDetail.length - 1]
                            .isExpanded = false;
                        _listInfluencerDetail.add(infl);
                      });
                    } else {
                      print("Error : Please fill previous influencer first");
                      Get.dialog(CustomDialogs().errorDialog(
                          "Please fill previous influencer first"));
                    }
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget pastStageHistoryview() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: siteVisitHistoryEntity.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DateFormat formatter = DateFormat('dd-MMM-yyyy');
                        String selectedDateString = formatter.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                siteVisitHistoryEntity[index].createdOn));

                        String constructionDateString =
                            siteVisitHistoryEntity[index].constructionDate;

                        if (!siteVisitHistoryEntity[index].isExpanded) {
                          return Column(
                            // mainAxisAlignment:
                            // MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Visit Date:" + selectedDateString,
                                    style: TextStyle(
                                        //      fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  siteVisitHistoryEntity[index].isExpanded
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              siteVisitHistoryEntity[index]
                                                      .isExpanded =
                                                  !siteVisitHistoryEntity[index]
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              siteVisitHistoryEntity[index]
                                                      .isExpanded =
                                                  !siteVisitHistoryEntity[index]
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
                                    "Visit Date:" + selectedDateString,
                                    style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  siteVisitHistoryEntity[index].isExpanded
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              siteVisitHistoryEntity[index]
                                                      .isExpanded =
                                                  !siteVisitHistoryEntity[index]
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
                                                color: HexColor("#F9A61A"),
                                                fontWeight: FontWeight.bold,
                                                // letterSpacing: 2,
                                                fontSize: 17),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              siteVisitHistoryEntity[index]
                                                      .isExpanded =
                                                  !siteVisitHistoryEntity[index]
                                                      .isExpanded;
                                            });
                                            // _getCurrentLocation();
                                          },
                                        ),
                                ],
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: siteVisitHistoryEntity[index]
                                    .floorId
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Floor",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: constructionStageDesc(
                                    siteVisitHistoryEntity[index]
                                        .constructionStageId),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Stage of construction",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: siteVisitHistoryEntity[index]
                                    .stagePotential,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Stage Potential",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: brandValue(
                                    siteVisitHistoryEntity[index].brandId),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Brand in use",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue:
                                    siteVisitHistoryEntity[index].brandPrice,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Brand Price",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: brandProductValue(
                                    siteVisitHistoryEntity[index].brandId),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Product Sold",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue:
                                    siteVisitHistoryEntity[index].stageStatus,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Stage Status",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                initialValue: constructionDateString,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            ColorConstants.backgroundColorBlue,
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
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.0),
                                  ),
                                  enabled: false,
                                  labelText: "Date of construction",
                                  filled: false,
                                  focusColor: Colors.black,
                                  labelStyle: TextStyle(
                                      fontFamily: "Muli",
                                      color:
                                          ColorConstants.inputBoxHintColorDark,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                  fillColor: ColorConstants.backgroundColor,
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
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(height: 16),
            Center(
              child: RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: HexColor("#1C99D4"),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
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
          ],
        )),
      ),
    );
  }

  Widget addNextStageContainer() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.black26,
            thickness: 1,
          ),
        ),
        DropdownButtonFormField<SiteFloorsEntity>(
          value: _selectedSiteVisitFloorNextStage,
          items: siteFloorsEntity
              .map((label) => DropdownMenuItem(
                    child: Text(
                      label.siteFloorTxt,
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
              _selectedSiteVisitFloorNextStage = value;
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
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Floor",
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
        DropdownButtonFormField<ConstructionStageEntity>(
          value: _selectedConstructionTypeVisitNextStage,
          items: constructionStageEntity
              .map((label) => DropdownMenuItem(
                    child: Text(
                      label.constructionStageText,
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
              _selectedConstructionTypeVisitNextStage = value;
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
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Type of Construction",
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
          controller: _stagePotentialVisitNextStage,
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
                  color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Stage Potential",
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
        DropdownButtonFormField<SiteBrandEntity>(
          value: _siteBrandNextStage,
          items: siteBrandEntity
              .map((label) => DropdownMenuItem(
                    child: Text(
                      label.brandName,
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
              _siteBrandNextStage = value;
              _productSoldVisitNextStage.text = _siteBrandNextStage.productName;
              if (_siteBrandNextStage.brandName.toLowerCase() == "dalmia") {
                _stageStatusNextStage.text = "WON";
              } else {
                _stageStatusNextStage.text = "LOST";
              }
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
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Brand in use",
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
          controller: _brandPriceVisitNextStage,
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
                  color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Brand Price",
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
          controller: _productSoldVisitNextStage,
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
                  color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Product Sold",
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
          padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
          child: Text(
            "No. of Nags Supplied",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
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
                  controller: _dateOfBagSuppliedNextStage,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return "Contact Name can't be empty";
                  //   }
                  //   //leagueSize = int.parse(value);
                  //   return null;
                  // },
                  readOnly: true,
                  onChanged: (data) {
                    // setState(() {
                    //   _contactName.text = data;
                    // });
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
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26, width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    labelText: "Date ",
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.date_range_rounded,
                        size: 22,
                        color: ColorConstants.clearAllTextColor,
                      ),
                      onPressed: () async {
                        print("here");
                        final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now(),
                        );

                        setState(() {
                          final DateFormat formatter = DateFormat("yyyy-MM-dd");
                          final String formattedDate = formatter.format(picked);

                          _dateOfBagSuppliedNextStage.text = formattedDate;
                        });
                      },
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _siteCurrentTotalBagsNextStage,
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
                          color: const Color(0xFF000000).withOpacity(0.4),
                          width: 1.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.4),
                          width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    labelText: "No. Of Bags",
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
            ),
          ],
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
          controller: _stageStatusNextStage,
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
          keyboardType: TextInputType.text,
          enabled: false,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstants.backgroundColorBlue,
                  //color: HexColor("#0000001F"),
                  width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color(0xFF000000).withOpacity(0.4), width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Stage Status",
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
          controller: _dateofConstructionNextStage,
          // validator: (value) {
          //   if (value.isEmpty) {
          //     return "Contact Name can't be empty";
          //   }
          //   //leagueSize = int.parse(value);
          //   return null;
          // },
          readOnly: true,
          onChanged: (data) {
            // setState(() {
            //   _contactName.text = data;
            // });
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
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            labelText: "Planned Start Date of construction",
            suffixIcon: IconButton(
              icon: Icon(
                Icons.date_range_rounded,
                size: 22,
                color: ColorConstants.clearAllTextColor,
              ),
              onPressed: () async {
                print("here");
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101));

                setState(() {
                  final DateFormat formatter = DateFormat("yyyy-MM-dd");
                  final String formattedDate = formatter.format(picked);

                  _dateofConstructionNextStage.text = formattedDate;
                });
              },
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
      ],
    ));
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

  constructionStageDesc(int constructionStageId) {
    for (int i = 0; i < constructionStageEntity.length; i++) {
      if (constructionStageEntity[i].id == constructionStageId) {
        return constructionStageEntity[i].constructionStageText;
      }
    }
  }

  brandValue(int brandId) {
    for (int i = 0; i < siteBrandEntity.length; i++) {
      if (siteBrandEntity[i].id == brandId) {
        return siteBrandEntity[i].brandName;
      }
    }
  }

  brandProductValue(int brandId) {
    for (int i = 0; i < siteBrandEntity.length; i++) {
      if (siteBrandEntity[i].id == brandId) {
        return siteBrandEntity[i].productName;
      }
    }
  }

  inflTypeValue(TextEditingController inflTypeId) {
    for (int i = 0; i < influencerTypeEntity.length; i++) {
      if (influencerTypeEntity[i].inflTypeId == int.parse(inflTypeId.text)) {
        return new TextEditingController(
            text: influencerTypeEntity[i].inflTypeDesc);
      }
    }
  }

  inflCatValue(TextEditingController inflCatId) {
    for (int i = 0; i < influencerCategoryEntity.length; i++) {
      if (influencerCategoryEntity[i].inflCatId == int.parse(inflCatId.text)) {
        return new TextEditingController(
            text: influencerCategoryEntity[i].inflCatDesc);
      }
    }
  }

  Future<void> UpdateRequest() async {
    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";

      List<SiteCommentsEntity> newSiteCommentsEntity = new List();
      newSiteCommentsEntity.add(new SiteCommentsEntity(
          siteId: widget.siteId,
          siteCommentText: _comments.text,
          creatorName: name,
          createdBy: empId));

      siteVisitHistoryEntity.add(new SiteVisitHistoryEntity(
        totalBalancePotential: _siteTotalBalancePt.text,
        constructionStageId: _selectedConstructionTypeVisit.id,
        floorId: _selectedSiteVisitFloor.id,
        stagePotential: _stagePotentialVisit.text,
        brandId: _siteBrand.id,
        brandPrice: _brandPriceVisit.text,
        constructionDate: _dateofConstruction.text,
        siteId: widget.siteId,
        supplyDate: _dateOfBagSupplied.text,
        supplyQty: _stagePotentialVisit.text,
        stageStatus: _stageStatus.text,
        createdBy: empId,
      ));

      print(_siteBrandNextStage.id);

      siteNextStageEntity.add(new SiteNextStageEntity(
        siteId: widget.siteId,
        constructionStageId: _selectedConstructionTypeVisitNextStage.id,
        stagePotential: _stagePotentialVisitNextStage.text,
        brandId: _siteBrandNextStage.id,
        brandPrice: _brandPriceVisitNextStage.text,
        stageStatus: _stageStatusNextStage.text,
        constructionStartDt: _dateofConstructionNextStage.text,
        nextStageSupplyDate: _dateOfBagSuppliedNextStage.text,
        nextStageSupplyQty: _siteCurrentTotalBagsNextStage.text,
        createdBy: empId,
      ));

      List<updateResponse.SitePhotosEntity> newSitePhotoEntity = new List();
      // sitephotosEntity.clear();
      for (int i = 0; i < _imageList.length; i++) {
        sitephotosEntity.add(
            new SitephotosEntity(photoName: path.basename(_imageList[i].path)));
      }

      List<updateResponse.SiteInfluencerEntityNew> newInfluencerEntity =
          new List();

      if(_listInfluencerDetail.length ==0) {
        for (int i = initialInfluencerLength;
        i < _listInfluencerDetail.length;
        i++) {
          newInfluencerEntity.add(new updateResponse.SiteInfluencerEntityNew(
              inflId: int.parse(_listInfluencerDetail[i].id.text),
              siteId: widget.siteId,
              isDelete: "N",
              createdBy: empId));
        }
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
          "noOfFloors": _selectedSiteFloor.siteFloorTxt,
          "productDemo": _siteProductDemo.text,
          "productOralBriefing": _siteProductOralBriefing.text,
          "soCode": viewSiteDataResponse.sitesModal.siteSoId,
          "inactiveReasonText":
          (_inactiveReasonText.text != "") ? _inactiveReasonText.text : null,
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
        };

        _siteController.updateLeadData(
            updateDataRequest, _imageList, context, widget.siteId);

        Get.back();
      }
    );
  }
}

class ImageDetails {
  String from;
  File file;

  ImageDetails(this.from, this.file);
}