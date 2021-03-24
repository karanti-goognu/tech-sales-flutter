import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz_unsafe.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/helper/brand_name_db_config.dart';
import 'package:flutter_tech_sales/helper/database/sitelist_db_helper.dart';
import 'package:flutter_tech_sales/helper/database_helper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SiteRefreshDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/UpdateDataRequest.dart'
    as updateResponse;
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/util.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/utils/constants/db_constants.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:sqflite/sqflite.dart';

class ViewSiteScreen extends StatefulWidget {
  int siteId;

  ViewSiteScreen(this.siteId);

  @override
  _ViewSiteScreenState createState() => _ViewSiteScreenState();
}

class _ViewSiteScreenState extends State<ViewSiteScreen>
    with SingleTickerProviderStateMixin {
   //final db = DatabaseHelper();
  bool fromDropDown=false;
  // final db = BrandNameDBHelper();
  static final db= DatabaseHelper();

  FocusNode myFocusNode;
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
  String visitDataDealer;
  String visitDataSubDealer;
  String isUserOnline="Offline";
//  static bool isUserOnlineStatus=false;

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
  int initialInfluencerLength = 0;
  BrandModelforDB _siteBrandFromLocalDB;

  BrandModelforDB _siteBrandFromLocalDBNextStage;

  BrandModelforDB _siteProductFromLocalDB;

  BrandModelforDB _siteProductFromLocalDBNextStage;

  List<DropdownMenuItem<String>> productSoldVisitSite = new List();

   SiteStageEntity _siteStageNextStage;
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
  final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
  SitesModal sitesModal;
  SitesModal _sitesModel;

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
  List<SiteStageEntity> siteStageEntityNextStage = new List();
  List<InfluencerEntity> influencerEntity = new List();
  List<InfluencerDetail> _listInfluencerDetail = new List();

  // List<Influencer>
  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<SiteCommentsEntity> siteCommentsEntity = new List();
  List<ImageDetails> _imgDetails = new List();
  SiteController _siteController = Get.find();
  List<CounterListModel> counterListModel = new List();
  List<DealerForDb> dealerEntityForDb = new List();
  List<CounterListModel> subDealerList = new List();
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  TabController _tabController;

  CounterListModel selectedSubDealer = CounterListModel();
  DatabaseHelper _helper;
  StreamSubscription<DataConnectionStatus> listener;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _helper=new DatabaseHelper();
    _tabController = TabController(vsync: this, length: 4);
    checkConnection();
    //_controller.addListener(_handleTabSelection);
    // print(widget.siteId);
 // getSiteData();
    getConstructionData();




  }


  checkConnection() async {
    internetChecking().then((result){
      _siteController.isUserOnlineStatus=result;
    });
    listener = DataConnectionChecker().onStatusChange.listen((status) {
       switch (status){
        case DataConnectionStatus.connected:
           _siteController.isUserOnlineStatus=true;
           break;
        case DataConnectionStatus.disconnected:
           _siteController.isUserOnlineStatus=false;
           break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }


  /*Get side details from db*/
  getSiteDetailsDataFromDb(int siteId){
    db.fetchMapList(DbConstants.TABLE_SITE_LIST, null, "${DbConstants.COL_SITE_ID} =?",[siteId] , null, null, null, null, null).then((value){
      value.forEach((element) {
        if(mounted)
          setState(() {
          _sitesModel= SitesModal.fromJson(element);
          _updateWidgets();
          });

      });

    });
  }


  /*get construction data from tables*/
  getConstructionData() async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));

    SitesDBProvider model = ScopedModel.of(this.context);
    model.fetchConstructionStageEntityData().then((value)  {
      if(mounted)
      setState(() {
        constructionStageEntity.addAll(value);
        constructionStageEntityNew.addAll(value);
        constructionStageEntityNewNextStage.addAll(value);

      });

    });

    model.fetchBrandData().then((value)  {
      if(mounted)
      setState(() {
        siteBrandEntityfromLoaclDB.addAll(value);
      });


    });


/*set floor data in list*/
    await model.fetchFloorsData().then((value){
      if(mounted)
      setState(() {
        siteFloorsEntity.addAll(value);
        siteFloorsEntityNew.addAll(value);
        siteFloorsEntityNewNextStage.addAll(value);
      });


    });


/*set floor data in list*/
    await model.fetchVisitHistoryData().then((value){
      if(mounted)
      setState(() {
        siteVisitHistoryEntity.addAll(value);
      });
    });

    await model.fetchProWinningData().then((value){
      if(mounted)
      setState(() {
        siteProbabilityWinningEntity.addAll(value);
      });
    });

 await model.fetchCompetitionStatusData().then((value){
   if(mounted)
      setState(() {
        siteCompetitionStatusEntity.addAll(value);
      });
    });

 await model.fetchOpportunityStatusData().then((value){
   if(mounted)
      setState(() {
        siteOpportunityStatusEntity.addAll(value);
      });
    });


 await model.fetchCommentEntityData().then((value){
   if(mounted)
      setState(() {
        siteCommentsEntity.addAll(value);
      });
    });


 await model.fetchPhotoData().then((value){
   if(mounted)
      setState(() {
        sitephotosEntity.addAll(value);
      });
    });

 await model.fetchInfluencerTypeData().then((value){
   if(mounted)
      setState(() {
        influencerTypeEntity.addAll(value);
      });
    });



 await model.fetchInfluencerCategoryData().then((value){
   if(mounted)
      setState(() {
        influencerCategoryEntity.addAll(value);
      });
    });


 await model.fetchInfluencerData().then((value){
   if(mounted)
      setState(() {
        influencerEntity.addAll(value);
      });
    });

 await model.fetchSiteInfluencerEntityData().then((value){
   if(mounted)
      setState(() {
        siteInfluencerEntity.addAll(value);
      });
    });


 await model.fetchSiteStageEntityData().then((value){
   print("fetchSiteStageEntityData   ${value.length}");
   if(mounted)
      setState(() {
        siteStageEntity.addAll(value);
        siteStageEntityNextStage.addAll(value);
      });
    });

   await model.fetchCounterDealersData().then((value){
     if(mounted)
      setState(() {
        counterListModel.addAll(value);
      });
    });
 await model.fetchDealerData().then((value){
   if(mounted)
      setState(() {
        dealerEntityForDb.addAll(value);
       });
    });


    getSiteDetailsDataFromDb(widget.siteId);


  }


  @override
  void dispose() {
    _tabController.dispose();
    // myFocusNode.dispose();
    super.dispose();
  }

  /*Update the values in widgets*/
  _updateWidgets() async {

    _siteProductDemo.text = _sitesModel.siteProductDemo;
    _plotNumber.text = _sitesModel.sitePlotNumber;
    _pincode.text = _sitesModel.sitePincode;
    _state.text = _sitesModel.siteState;
    _district.text = _sitesModel.siteDistrict;
    _taluk.text = _sitesModel.siteTaluk;
    _rera.text = _sitesModel.siteReraNumber;
    _so.text = _sitesModel.siteSoname;
    geoTagType = _sitesModel.siteGeotagType;
    _siteBuiltupArea.text = _sitesModel.siteBuiltArea;
    _ownerName.text = _sitesModel.siteOwnerName;
    _contactNumber.text = _sitesModel.siteOwnerContactNumber;
    _siteTotalPt.text = _sitesModel.siteTotalSitePotential;
    _inactiveReasonText.text=_sitesModel.inactiveReasonText;
   // _sitesEntity.siteStageId;

    _siteProductDemo.text = _sitesModel.siteProductDemo;
    if (_siteProductDemo.text == 'N') {
      isSwitchedsiteProductDemo = false;
    } else {
      isSwitchedsiteProductDemo = true;
    }
    _siteProductOralBriefing.text = _sitesModel.siteProductOralBriefing;

    if (_siteProductOralBriefing.text == 'N') {
      isSwitchedsiteProductOralBriefing = false;
    } else {
      isSwitchedsiteProductOralBriefing = true;
    }
    _siteTotalPt.text = _sitesModel.siteTotalSitePotential;

    if (_siteTotalPt.text == null ||
        _siteTotalPt.text == "") {
      _siteTotalBags.clear();
    } else {
      _siteTotalBags.text = (double.parse(_siteTotalPt.text) * 20).round().toString();
    }


    if (_sitesModel.noOfFloors != null ||
         _sitesModel.noOfFloors != 0) {
       for (int i = 0; i < siteFloorsEntity.length; i++) {
         if (_sitesModel.noOfFloors.toString() ==
             siteFloorsEntity[i].id.toString()) {
           _selectedSiteFloor = siteFloorsEntity[i];
         }
       }
     }



     for (int i = 0; i < constructionStageEntity.length; i++) {
       if (_sitesModel.siteConstructionId.toString() ==
           constructionStageEntity[i].id.toString()) {
         _selectedConstructionType = constructionStageEntity[i];
       }
     }


    if (sitephotosEntity != null) {
      for (int i = 0; i < sitephotosEntity.length; i++) {
        File file = new File(UrlConstants.baseUrlforImagesSites +
            "/" +
            sitephotosEntity[i].photoName);
        _imgDetails.add(new ImageDetails("Network", file));
      }
    }



    if (_sitesModel.siteCompetitionId != null) {
      for (int i = 0; i < siteCompetitionStatusEntity.length; i++) {
        if (_sitesModel.siteCompetitionId
            .toString() ==
            siteCompetitionStatusEntity[i].id.toString()) {
          _siteCompetitionStatusEntity = siteCompetitionStatusEntity[i];
        }
      }
    }

    addNextButtonDisable = false;
    siteScore = _sitesModel.siteScore;


    if (influencerEntity != null &&
        influencerEntity.length > 0) {
      for (int i = 0;
      i < influencerEntity.length;
      i++) {
        int originalId;
        for (int j = 0; j < siteInfluencerEntity.length; j++) {
          if (influencerEntity[i].id ==
              siteInfluencerEntity[j].inflId) {
            influencerEntity[i].isPrimary =
                siteInfluencerEntity[j].isPrimary;
            originalId = siteInfluencerEntity[j].id;
            break;
          }
        }

        _listInfluencerDetail.add(new InfluencerDetail(
            originalId: originalId,
            isPrimary: influencerEntity[i].isPrimary,
            isPrimarybool:
            influencerEntity[i].isPrimary == "Y"
                ? true
                : false,
            id: new TextEditingController(
                text: influencerEntity[i].id
                    .toString()),
            inflContact: new TextEditingController(
                text:
                influencerEntity[i].inflContact),
            inflTypeId: new TextEditingController(
                text: influencerEntity[i].inflTypeId
                    .toString()),
            inflTypeValue: inflTypeValue(new TextEditingController(
                text: influencerEntity[i].inflTypeId
                    .toString())),
            inflCatId: new TextEditingController(
                text:influencerEntity[i].inflCatId
                    .toString()),
            inflCatValue: inflCatValue(new TextEditingController(
                text: influencerEntity[i].inflCatId
                    .toString())),
            inflName:
            new TextEditingController(text: influencerEntity[i].inflName),
            ilpIntrested: new TextEditingController(text: influencerEntity[i].ilpIntrested),
            createdOn: new TextEditingController(text:influencerEntity[i].createdOn.toString()),
            isExpanded: false));
      }
      initialInfluencerLength =
          influencerEntity.length;
    }

    if (_sitesModel.siteGeotagLatitude != null &&
        _sitesModel.siteGeotagLongitude != null &&
        _sitesModel.siteGeotagLatitude != "null" &&
        _sitesModel.siteGeotagLongitude != "null" &&
        _sitesModel.siteGeotagLatitude != "" &&
        _sitesModel.siteGeotagLongitude != "") {
      _currentPosition = new Position(
          latitude: double.parse(_sitesModel.siteGeotagLatitude),
          longitude: double.parse(_sitesModel.siteGeotagLongitude));
    }

    print("siteStageEntity ???  ${siteStageEntity.length}");

    for (int i = 0; i < siteStageEntity.length; i++) {
      if (_sitesModel.siteStageId.toString() ==
          siteStageEntity[i].id.toString()) {
        labelText = siteStageEntity[i].siteStageDesc;
        labelId = siteStageEntity[i].id;
      }


    }

    if (_sitesModel.siteProbabilityWinningId !=
        null) {
      for (int i = 0; i < siteProbabilityWinningEntity.length; i++) {
        if (_sitesModel.siteProbabilityWinningId
            .toString() ==
            siteProbabilityWinningEntity[i].id.toString()) {
          labelProbabilityId = siteProbabilityWinningEntity[i].id;
          _siteProbabilityWinningEntity = siteProbabilityWinningEntity[i];
        }
      }
    }

    if (_sitesModel.siteProbabilityWinningId !=
        null) {
      for (int i = 0; i < siteProbabilityWinningEntity.length; i++) {
        if (_sitesModel.siteProbabilityWinningId
            .toString() ==
            siteProbabilityWinningEntity[i].id.toString()) {
          labelProbabilityId = siteProbabilityWinningEntity[i].id;
          _siteProbabilityWinningEntity = siteProbabilityWinningEntity[i];
        }
      }
    }
    if ( _sitesModel.siteOppertunityId != null) {
      for (int i = 0; i < siteOpportunityStatusEntity.length; i++) {
        if ( _sitesModel.siteOppertunityId
            .toString() ==
            siteOpportunityStatusEntity[i].id.toString()) {
          _siteOpportunitStatusEnity = siteOpportunityStatusEntity[i];
        }
      }
    }


    // for (int i = 0; i < counterListModel.length; i++) {
    //   int id = await BrandNameDbConfig.addDealer(DealerForDb(
    //       counterListModel[i].soldToParty,
    //       counterListModel[i].soldToPartyName));
    //   print("ADDED :  $id");
    // }


    myFocusNode = FocusNode();
    myFocusNode.requestFocus();


   Get.back();



   }



  Future<void> getSiteData() async {
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _siteController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      // print("AccessKey :: " + accessKeyModel.accessKey);
      await _siteController
          .getSitedetailsData(accessKeyModel.accessKey, widget.siteId)
          .then((data) async {
        print("here");
        viewSiteDataResponse = data;

        // print(viewSiteDataResponse);
        await BrandNameDbConfig.clearTable();
        siteBrandEntity = viewSiteDataResponse!=null?viewSiteDataResponse.siteBrandEntity: List<SiteBrandEntity>();


        for (int i = 0; i < siteBrandEntity.length; i++) {
          await BrandNameDbConfig.addBrandName(new BrandModelforDB(siteBrandEntity[i].id,
              siteBrandEntity[i].brandName, siteBrandEntity[i].productName));
        }

        // print("list Size");
        siteBrandEntityfromLoaclDB = await BrandNameDbConfig.fetchAllDistinctBrand();
        dealerEntityForDb = await BrandNameDbConfig.fetchAllDistinctDealers();
        dealerEntityForDb.forEach((e) => print(e.toMapForDb().toString()));

      });
      // Future.delayed(
      //     Duration.zero,
      //         () => Get.dialog(Center(),
      //         barrierDismissible: false));
      //  Get.back();
    });
  }


  /*Get side details from db*/

  @override
  Widget build(BuildContext context) {
    // print(viewSiteDataResponse.counterListModel.forEach((element) {print(element);}));
    //gv.selectedClass = widget.classroomId;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context)
            .requestFocus(new FocusNode());
      },
      child: Stack(
       alignment: Alignment.topCenter,
        children: [
          DefaultTabController(
              initialIndex: _initialIndex,
              length: 4,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                resizeToAvoidBottomPadding: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  toolbarHeight: 180,
                  titleSpacing: 0,
                  title: Stack(
                    alignment: Alignment.topLeft,
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
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ))),

                      Column(
                       // crossAxisAlignment: CrossAxisAlignment.start,
                      //  mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [


                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 3.0, bottom: 3, left: 5),
                                child: Text(
                                  "Trade site details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: SizeConfig.safeBlockHorizontal*5.3,
                                      color: HexColor("#006838"),
                                      fontFamily: "Muli"),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
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
                                        fontSize: SizeConfig.safeBlockHorizontal*5.2,
                                        color: Colors.black,
                                        fontFamily: "Muli",
                                      ),
                                    ),
                                    siteScore != 0.0
                                        ? Text(
                                      "Site Score: " + siteScore.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: HexColor("#002A64"),
                                        fontFamily: "Muli",
                                      ),
                                    )
                                        : Container(),
                                  ],
                                ),
                                SizedBox(width: 50),

                                Expanded(
                                  child: Container(
                                    padding:
                                    const EdgeInsets.only(left: 1.0, right: 1.0),
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
                                          if(mounted)
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
                                                            width:
                                                            MediaQuery.of(context)
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
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.03,
                                                                          ),
                                                                          Container(
                                                                            width: MediaQuery.of(context)
                                                                                .size
                                                                                .width *
                                                                                0.3,
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
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
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
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
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                10.0),
                                                                            child:
                                                                            TextFormField(
                                                                              controller:
                                                                              closureReasonText,
                                                                              maxLength:
                                                                              100,
                                                                              onChanged:
                                                                                  (value) async {},
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  18,
                                                                                  color:
                                                                                  ColorConstants.inputBoxHintColor,
                                                                                  fontFamily: "Muli"),
                                                                              keyboardType:
                                                                              TextInputType.text,
                                                                              maxLines:
                                                                              4,
                                                                              decoration:
                                                                              FormFieldStyle.buildInputDecoration(labelText: "Comments"),
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
                                                                              color: HexColor(
                                                                                  "#1C99D4"),
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                    bottom: 10,
                                                                                    top: 10),
                                                                                child:
                                                                                Text(
                                                                                  "SUBMIT",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      letterSpacing: 1,
                                                                                      fontSize: 17),
                                                                                ),
                                                                              ),
                                                                              onPressed:
                                                                                  () async {
                                                                                if (closureReasonText.text != null &&
                                                                                    closureReasonText.text != "") {
                                                                                  _siteStage =
                                                                                      value;
                                                                                  labelId =
                                                                                      _siteStage.id;
                                                                                  labelText =
                                                                                      _siteStage.siteStageDesc;
                                                                                  if(mounted)
                                                                                  setState(() {
                                                                                    fromDropDown = true;
                                                                                  });
                                                                                  UpdateRequest();
                                                                                } else {
                                                                                  Get.dialog(CustomDialogs().errorDialog("Please fill all details !!!"));
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
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
                                                            width:
                                                            MediaQuery.of(context)
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
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.03,
                                                                          ),
                                                                          Container(
                                                                            width: MediaQuery.of(context)
                                                                                .size
                                                                                .width *
                                                                                0.3,
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
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
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
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
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.01,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                10.0),
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
                                                                                  fontSize:
                                                                                  18,
                                                                                  color:
                                                                                  ColorConstants.inputBoxHintColor,
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
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.black26, width: 1.0),
                                                                                ),
                                                                                enabledBorder:
                                                                                OutlineInputBorder(
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.black26, width: 1.0),
                                                                                ),
                                                                                errorBorder:
                                                                                OutlineInputBorder(
                                                                                  borderSide:
                                                                                  BorderSide(color: Colors.red, width: 1.0),
                                                                                ),
                                                                                labelText:
                                                                                "Next Visit Date ",
                                                                                suffixIcon:
                                                                                IconButton(
                                                                                  icon:
                                                                                  Icon(
                                                                                    Icons.date_range_rounded,
                                                                                    size: 22,
                                                                                    color: ColorConstants.clearAllTextColor,
                                                                                  ),
                                                                                  onPressed:
                                                                                      () async {
                                                                                    print("here");
                                                                                    final DateTime picked = await showDatePicker(
                                                                                      context: context,
                                                                                      initialDate: DateTime.now(),
                                                                                      firstDate: DateTime.now(),
                                                                                      lastDate: DateTime(2101),
                                                                                    );

                                                                                    if(mounted)

                                                                                    setState(() {
                                                                                      final DateFormat formatter = DateFormat("yyyy-MM-dd");
                                                                                      if(picked!=null) {
                                                                                        final String formattedDate = formatter
                                                                                            .format(
                                                                                            picked);
                                                                                        _nextVisitDate
                                                                                            .text =
                                                                                            formattedDate;
                                                                                      }
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
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.01,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                10.0),
                                                                            child:
                                                                            TextFormField(
                                                                              controller:
                                                                              _inactiveReasonText,
                                                                              maxLength:
                                                                              100,
                                                                              onChanged:
                                                                                  (value) async {},
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  18,
                                                                                  color:
                                                                                  ColorConstants.inputBoxHintColor,
                                                                                  fontFamily: "Muli"),
                                                                              keyboardType:
                                                                              TextInputType.text,
                                                                              maxLines:
                                                                              4,
                                                                              decoration:
                                                                              FormFieldStyle.buildInputDecoration(
                                                                                labelText:
                                                                                "Comments",
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
                                                                              color: HexColor(
                                                                                  "#1C99D4"),
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                    bottom: 10,
                                                                                    top: 10),
                                                                                child:
                                                                                Text(
                                                                                  "SUBMIT",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      letterSpacing: 1,
                                                                                      fontSize: 17),
                                                                                ),
                                                                              ),
                                                                              onPressed:
                                                                                  () async {
                                                                                if (_inactiveReasonText.text != null &&
                                                                                    _inactiveReasonText.text != "") {
                                                                                  _siteStage =
                                                                                      value;
                                                                                  labelId =
                                                                                      _siteStage.id;
                                                                                  labelText =
                                                                                      _siteStage.siteStageDesc;
                                                                                  if(mounted)
                                                                                  setState(() {
                                                                                    fromDropDown = true;
                                                                                  });
                                                                                  UpdateRequest();
                                                                                } else {
                                                                                  Get.dialog(CustomDialogs().errorDialog("Please fill all details !!!"));
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
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
                    // SiteDataView(siteId: widget.siteId,),
                    visitDataView(),
                    // VisitDataView(siteId: widget.siteId,),
                    influencerView(),
                    // InfluencerView(),
                    pastStageHistoryview(),
                    // PastStageHistoryView()
                  ],
                ),
                floatingActionButton: BackFloatingButton(),
                floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomNavigator(),
                //child:Text("classroomName")
              )),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Obx(()=>

                      Padding(
                        padding:  EdgeInsets.only(top: SizeConfig.screenHeightSafeTop),
                        child: new Container(
                          alignment: Alignment.center,
                          height: SizeConfig.screenHeight*.01,
                          color: _siteController.isUserOnlineStatus?  Colors.green: Colors.red,

                        ),
                      )
                  )
              ),
            ],
          ),
        ],
      ),
    );
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
                            if(mounted)
                            setState(() {
                              _selectedConstructionType = value;

                            });
                            print("construction ${_selectedConstructionType.id}");
                          },
                          decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Type of Construction"),
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
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Site Built-up area")),
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
                                fontSize: SizeConfig.safeBlockHorizontal*5.2,
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
                                    if(mounted)
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      _selectedSiteFloor = value;
                                      print("_selectedSiteFloor    ${_selectedSiteFloor.id}");
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Site Demo conducted",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal*5.2,
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
                                    fontSize: SizeConfig.safeBlockHorizontal*4.5,
                                    // color: HexColor("#000000DE"),
                                    fontFamily: "Muli"),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.safeBlockHorizontal*4.5,
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
                                        fontSize: SizeConfig.safeBlockHorizontal*4.5,
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
                                    fontSize: SizeConfig.safeBlockHorizontal*4.5,
                                    // color: HexColor("#000000DE"),
                                    fontFamily: "Muli"),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.safeBlockHorizontal*4.5,
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
                                        fontSize: SizeConfig.safeBlockHorizontal*4.5,
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
                                fontSize: SizeConfig.safeBlockHorizontal*5.3,
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
                                    if(mounted)
                                    setState(() {
                                      // _totalBags.text = value ;
                                      if (_siteTotalBags.text == null ||
                                          _siteTotalBags.text == "") {
                                        _siteTotalPt.clear();
                                      } else {
                                        _siteTotalPt.text =
                                            (int.parse(_siteTotalBags.text) / 20)
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
                                    if(mounted)
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
                                  decoration:
                                      FormFieldStyle.buildInputDecoration(
                                          labelText: "MT"),
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
                          // onChanged: (data) {
                          //   setState(() {
                          //     _ownerName.text = data;
                          //   });
                          // },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          keyboardType: TextInputType.text,
                          decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Owner Name"),
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
                          // onChanged: (data) {
                          //   _contactNumber..text = checkNumber(data)
                          //     ..selection = TextSelection.collapsed(offset: 0);
                          //   setState(() {
                          //     _contactNumber.text = data;
                          //   });
                          // },
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
                                fontSize: SizeConfig.safeBlockHorizontal*5.3,
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
                                if(mounted)
                                setState(() {
                                  geoTagType = "A";
                                });
                                Get.dialog(Center(
                                  child: CircularProgressIndicator(),
                                ));

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
                                internetChecking().then((result) async {
                                  if (!result) {
                                    Get.dialog(CustomDialogs().errorDialog(
                                    StringConstants.MANUAL_NOT_ACCESS));

                                    // Get.snackbar(
                                    //     "No internet connection.", "",
                                    //     colorText: Colors.white,
                                    //     backgroundColor: Colors.red,
                                    //     snackPosition: SnackPosition.BOTTOM);



                                  }else{
                                    if(mounted)
                                    setState(() {
                                      geoTagType = "M";
                                    });
                                    LocationResult result =
                                        await showLocationPicker(
                                      context,
                                      StringConstants.API_Key,
                                      initialCenter: LatLng(31.1975844, 29.9598339),
                                      automaticallyAnimateToCurrentLocation: true,
                                      myLocationButtonEnabled: true,
                                      layersButtonEnabled: false,

                                    );
                                    print("result.... = $result");
                                    if(mounted)
                                    setState(() {
                                      _pickedLocation = result;
                                      _currentPosition = new Position(
                                          latitude: _pickedLocation!=null?_pickedLocation.latLng.latitude:0.0,
                                          longitude: _pickedLocation!=null?_pickedLocation.latLng.longitude:0.0);
                                      _getAddressFromLatLng();
                                      //print(_pickedLocation.latLng.latitude);
                                    });
                                  }
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Pincode",
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "State",
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "District",
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Taluk",
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
                              side: BorderSide(color: Colors.black26),
                            ),
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
                              internetChecking().then((result){
                                if (!result){
                                  Get.dialog(CustomDialogs().errorDialog(
                                      StringConstants.PHOTO_NOT_UPLOAD));

                                  return ;
                                }else{
                                  if (_imgDetails.length < 5) {
                                    _showPicker(context);
                                  } else {
                                    Get.dialog(CustomDialogs().errorDialog(
                                        "You can add only upto 5 photos"));
                                  }
                                }

                              });


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
                                              internetChecking().then((result){
                                                if (!result){
                                                  Get.snackbar(
                                                      "No internet connection.", "",
                                                      colorText: Colors.white,
                                                      backgroundColor: Colors.red,
                                                      snackPosition: SnackPosition.BOTTOM);

                                                }else{
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
                                                }

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
                                                    if(mounted)
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "RERA",
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Dealer",
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
                          decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "SO",
                          ),
                        ),

                        SizedBox(height: 16),

                        SizedBox(height: 35),
             /*Site data update button*/
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
                            onPressed: () {
                             // UpdateRequest();
                              _updateSiteDataFromDb();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current Stage",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal*5,
                        // color: HexColor("#000000DE"),
                        fontFamily: "Muli"),
                  ),
                  GestureDetector(
                    onTap: () {
                      if(mounted)
                      setState(() {
                        _initialIndex = 3;
                        _tabController.animateTo(3);
                      });
                    },
                    child: Text(
                      "View previous detail",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.safeBlockHorizontal*4,
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
                    fontSize: SizeConfig.safeBlockHorizontal*5.3,
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
                        if(mounted)
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
                      decoration: FormFieldStyle.buildInputDecoration(
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
                        if(mounted)
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
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "MT",
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
            DropdownButtonFormField<ConstructionStageEntity>(
              value: _selectedConstructionTypeVisit,
              items: constructionStageEntityNew
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
                if(mounted)
                setState(() {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _selectedConstructionTypeVisit = value;
                  print(_selectedConstructionTypeVisit.id);
                  siteFloorsEntityNew = new List();
                  _selectedSiteVisitFloor = null;
                  if (_selectedConstructionTypeVisit.id == 1 ||
                      _selectedConstructionTypeVisit.id == 2 ||
                      _selectedConstructionTypeVisit.id == 3) {
                    // siteFloorsEntityNew = new List();
                    siteFloorsEntityNew.add(new SiteFloorsEntity(
                        id: siteFloorsEntity[0].id,
                        siteFloorTxt: siteFloorsEntity[0].siteFloorTxt));
                  } else {
                    for (int i = 1; i < siteFloorsEntity.length; i++) {
                      siteFloorsEntityNew.add(new SiteFloorsEntity(
                          id: siteFloorsEntity[i].id,
                          siteFloorTxt: siteFloorsEntity[i].siteFloorTxt));
                    }
                  }
                });
              },
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Type of Construction",
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
            DropdownButtonFormField<SiteFloorsEntity>(
              value: _selectedSiteVisitFloor,
              items: siteFloorsEntityNew
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
                if(mounted)
                setState(() {
                  _selectedSiteVisitFloor = value;

                  // constructionStageEntityNew = new List();
                  // _selectedConstructionTypeVisit= null;
                  // if(_selectedSiteVisitFloor.id == 1 ){
                  //   // siteFloorsEntityNew = new List();
                  //   for(int i=0;i<3;i++){
                  //     constructionStageEntityNew.add(new ConstructionStageEntity(
                  //       id: constructionStageEntity[i].id,
                  //       constructionStageText: constructionStageEntity[i].constructionStageText
                  //     ));
                  //   }
                  // }
                  // else{
                  //
                  //   for(int i=3;i<constructionStageEntity.length;i++){
                  //     constructionStageEntityNew.add(new ConstructionStageEntity(
                  //         id: constructionStageEntity[i].id,
                  //         constructionStageText: constructionStageEntity[i].constructionStageText
                  //     ));
                  //   }
                  // }
                });
              },
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Floor",
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
              keyboardType: TextInputType.number,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Stage Potential",
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
            DropdownButtonFormField<BrandModelforDB>(
              value: _siteBrandFromLocalDB,
              items: siteBrandEntityfromLoaclDB
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
              onChanged: (value) async {
                FocusScope.of(context).requestFocus(new FocusNode());
                print("Brand Value");
                print(value);
                siteProductEntityfromLoaclDB = new List();
                _siteProductFromLocalDB = null;
                List<BrandModelforDB> _siteProductEntityfromLoaclDB =
                    await BrandNameDbConfig.fetchAllDistinctProduct(value.brandName);
                if(mounted)
                setState(() {
                  _siteBrandFromLocalDB = value;
                  print("_siteBrandFromLocalDB   ${_siteBrandFromLocalDB.id}   ${_siteBrandFromLocalDB.brandName} ${_siteBrandFromLocalDB.productName}");

                  siteProductEntityfromLoaclDB = _siteProductEntityfromLoaclDB;
                  // _productSoldVisit.text = _siteBrand.productName;
                  if (_siteBrandFromLocalDB.brandName.toLowerCase() ==
                      "dalmia") {
                    _stageStatus.text = "WON";
                  } else {
                    _stageStatus.text = "LOST";
                  }
                });
              },
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Brand In Use",
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
            DropdownButtonFormField<BrandModelforDB>(
                value: _siteProductFromLocalDB,
                items: siteProductEntityfromLoaclDB
                    .map((label) => DropdownMenuItem(
                          child: Text(
                            label.productName,
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
                  print("Product Value");
                  if(mounted)
                  setState(() {
                    _siteProductFromLocalDB = value;
                    print(_siteProductFromLocalDB.id);
                  });
                },
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Product Sold")),
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
            DropdownButtonFormField(
              items: dealerEntityForDb
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text('${e.dealerName} (${e.id})',
                              style: TextStyle(fontSize: 14)),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                print(" Dealer Value");
                print(value);
                selectedSubDealer = null;
                if(mounted)
                setState(() {
                  subDealerList = new List();
                  visitDataDealer = value.toString();
                  subDealerList = counterListModel
                      .where((e) => e.soldToParty == visitDataDealer)
                      .toList();
                  selectedSubDealer = subDealerList[0];
                  visitDataSubDealer = subDealerList[0].shipToParty;
                });
              },
              style: FormFieldStyle.formFieldTextStyle,
              decoration:
                  FormFieldStyle.buildInputDecoration(labelText: "Dealer"),
              validator: (value) =>
                  value == null ? 'Please select Dealer' : null,
            ),
            SizedBox(height: 16),
            subDealerList.isEmpty
                ? Container()
                : DropdownButtonFormField(
                    items: subDealerList.isNotEmpty
                        ? subDealerList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Text(
                                      '${e.shipToPartyName} (${e.shipToParty})',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ))
                            .toList()
                        : [
                            DropdownMenuItem(
                                child: Text("No Sub Dealer"), value: "0")
                          ],
                    value: selectedSubDealer,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please select Sub-Dealer'
                        : null,
                    onChanged: (value) {
                      // print("Sub Dealer Value");
                      // print(value.shipToParty.toString());
                      if(mounted)
                      setState(() {
                        visitDataSubDealer = value.shipToParty.toString();
                      });
                      print(visitDataSubDealer);
                    },
                    style: FormFieldStyle.formFieldTextStyle,
                    decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "Sub-Dealer"),
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
              keyboardType: TextInputType.number,
              decoration:
                  FormFieldStyle.buildInputDecoration(labelText: "Brand Price"),
              // InputDecoration(
              //   focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(
              //         color: ColorConstants.backgroundColorBlue,
              //         //color: HexColor("#0000001F"),
              //         width: 1.0),
              //   ),
              //   enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(
              //         color: const Color(0xFF000000).withOpacity(0.4),
              //         width: 1.0),
              //   ),
              //   errorBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.red, width: 1.0),
              //   ),
              //   labelText: "Brand Price",
              //   filled: false,
              //   focusColor: Colors.black,
              //   labelStyle: TextStyle(
              //       fontFamily: "Muli",
              //       color: ColorConstants.inputBoxHintColorDark,
              //       fontWeight: FontWeight.normal,
              //       fontSize: 16.0),
              //   fillColor: ColorConstants.backgroundColor,
              // ),
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
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
              child: Text(
                "No. of Bags Supplied",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal*5.1,
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
                            if(mounted)
                            setState(() {
                              final DateFormat formatter = DateFormat("yyyy-MM-dd");
                              if(picked!=null) {
                                final String formattedDate = formatter.format(
                                    picked);
                                _dateOfBagSupplied.text = formattedDate;
                              }
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
                Text(_siteCurrentTotalBags.text),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
                      controller: _siteCurrentTotalBags,
                      onChanged: (v) {
                        print(v);
                      },
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
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "No. Of Bags",
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
              readOnly: true,
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Stage Status",
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
              // decoration: InputDecoration(
              //   focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(
              //         color: ColorConstants.backgroundColorBlue,
              //         //color: HexColor("#0000001F"),
              //         width: 1.0),
              //   ),
              //   disabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.black26, width: 1.0),
              //   ),
              //   enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.black26, width: 1.0),
              //   ),
              //   errorBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.red, width: 1.0),
              //   ),
              //   labelText: "Date of construction",
              //   suffixIcon: IconButton(
              //     icon: Icon(
              //       Icons.date_range_rounded,
              //       size: 22,
              //       color: ColorConstants.clearAllTextColor,
              //     ),
              //     onPressed: () async {
              //       print("here");
              //       final DateTime picked = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(2001),
              //         lastDate: DateTime.now(),
              //       );
              //
              //       setState(() {
              //         final DateFormat formatter = DateFormat("yyyy-MM-dd");
              //         final String formattedDate = formatter.format(picked);
              //
              //         _dateofConstruction.text = formattedDate;
              //       });
              //     },
              //   ),
              //   filled: false,
              //   focusColor: Colors.black,
              //   isDense: false,
              //   labelStyle: TextStyle(
              //       fontFamily: "Muli",
              //       color: ColorConstants.inputBoxHintColorDark,
              //       fontWeight: FontWeight.normal,
              //       fontSize: 16.0),
              //   fillColor: ColorConstants.backgroundColor,
              // ),
              decoration: FormFieldStyle.buildInputDecoration(
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
                    if(mounted)
                    setState(() {
                      final DateFormat formatter = DateFormat("yyyy-MM-dd");
                      if(picked!=null) {
                        final String formattedDate = formatter.format(picked);
                        _dateofConstruction.text = formattedDate;
                      }
                    });
                  },
                ),
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
                          if(mounted)
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
                          if(mounted)
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
              onChanged: (value) {
                if(mounted)
                setState(() {
                  labelProbabilityText = value.siteProbabilityStatus;
                  labelProbabilityId = value.id;
                  _siteProbabilityWinningEntity = value;
                });
              },
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Probability of winning",
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
              onChanged: (value) {
                if(mounted)
                setState(() {
                  _siteCompetitionStatusEntity = value;
                });
              },
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Competition Status",
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
                              fontSize: 16,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                        ),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                if(mounted)
                setState(() {
                  _siteOpportunitStatusEnity = value;
                });
              },
              decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Opportunity Status",
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
                    if(mounted)
                    setState(() {
                      final DateFormat formatter = DateFormat("yyyy-MM-dd");
                      if(picked!=null) {
                        final String formattedDate = formatter.format(picked);
                        _nextVisitDate.text = formattedDate;
                      }
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
                                            formatter.format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        siteCommentsEntity[
                                                                siteCommentsEntity
                                                                        .length -
                                                                    1]
                                                            .createdOn)) ??
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
                                    .creatorName??"",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Text(
                                siteCommentsEntity[
                                        siteCommentsEntity.length - 1]
                                    .siteCommentText??"",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 25),
                              ),
                              Text(
                                formatter.format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        siteCommentsEntity[
                                                siteCommentsEntity.length - 1]
                                            .createdOn??0)),
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
                  //visitData
                  _updateSiteDataFromDb();
                 // _insertVisitDataFromDb();
                //  UpdateRequest();
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
                                  Switch(
                                    onChanged: (value) {
                                      setState(() {
                                        if (value) {
                                          for (int i = 0;
                                              i < _listInfluencerDetail.length;
                                              i++) {
                                            if (i == index) {
                                              _listInfluencerDetail[i]
                                                  .isPrimarybool = value;
                                            } else {
                                              _listInfluencerDetail[i]
                                                  .isPrimarybool = !value;
                                            }
                                          }
                                        } else {
                                          Get.dialog(CustomDialogs().errorDialog(
                                              "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                        }
                                      });
                                    },
                                    value: _listInfluencerDetail[index]
                                        .isPrimarybool,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                        HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Secondary",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                  Switch(
                                    onChanged: (value) {
                                      setState(() {
                                        if (value) {
                                          for (int i = 0;
                                              i < _listInfluencerDetail.length;
                                              i++) {
                                            if (i == index) {
                                              _listInfluencerDetail[i]
                                                  .isPrimarybool = value;
                                            } else {
                                              _listInfluencerDetail[i]
                                                  .isPrimarybool = !value;
                                            }
                                          }
                                        } else {
                                          Get.dialog(CustomDialogs().errorDialog(
                                              "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                        }
                                      });
                                    },
                                    value: _listInfluencerDetail[index]
                                        .isPrimarybool,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                        HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),
                                  Text(
                                    "Primary",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: _listInfluencerDetail[index]
                                                .isPrimarybool
                                            ? HexColor("#009688")
                                            : Colors.black,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                ],
                              ),
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
                                              _listInfluencerDetail[index]
                                                  .createdBy = empId;
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
                                              if (_listInfluencerDetail[index]
                                                      .inflContact !=
                                                  null) {
                                                _listInfluencerDetail[index]
                                                    .inflContact
                                                    .clear();
                                                _listInfluencerDetail[index]
                                                    .inflName
                                                    .clear();
                                              }

                                              // Get.back();
                                              return Get.dialog(CustomDialogs()
                                                  .showDialog(
                                                      "No influencer registered with this number"));
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
                                  labelText: "Mobile Number",
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
                                  labelText: "Name",
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
                                  labelText: "Type",
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
                                  labelText: "Category",
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
                  /*Internet check */
                  internetChecking().then((result){
                    if (!result){
                      Get.snackbar(
                          "No internet connection.", "",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);

                      }else{

                      if (_listInfluencerDetail.length == 0) {
                        setState(() {
                          _listInfluencerDetail.add(new InfluencerDetail(
                              isExpanded: true, isPrimarybool: true));
                        });
                      } else if (_listInfluencerDetail[
                      _listInfluencerDetail.length - 1]
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
                        InfluencerDetail infl = new InfluencerDetail(
                            isExpanded: true, isPrimarybool: false);

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
                        Get.dialog(CustomDialogs()
                            .errorDialog("Please fill previous influencer first"));
                      }
                    }

                  });



                },
              ),
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
                    "UPDATE",  //iNFluncer
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
                        print("00000000" +
                            json.encode(siteVisitHistoryEntity[0]));
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
                                readOnly: true,
                                initialValue: siteVisitHistoryEntity[index]
                                    .floorId
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Floor",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue: constructionStageDesc(
                                    siteVisitHistoryEntity[index]
                                        .constructionStageId),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Stage of construction",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue: siteVisitHistoryEntity[index]
                                    .stagePotential,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Stage Potential",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue: brandValue(
                                    siteVisitHistoryEntity[index].brandId),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                    labelText: "Brand in use"),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].brandPrice,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.number,
                                decoration: FormFieldStyle.buildInputDecoration(
                                    labelText: "Brand Price"),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue: brandProductValue(
                                    siteVisitHistoryEntity[index].brandId),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Product Sold",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].stageStatus,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Stage Status",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue: constructionDateString,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Date of construction",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].receiptNumber,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Receipt Number",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue: siteVisitHistoryEntity[index]
                                            .isAuthorised
                                            .toLowerCase() ==
                                        'y'
                                    ? "Yes"
                                    : "No",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Is Authorized",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].soldToParty,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Dealer",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].shipToParty,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Sub-Dealer",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].supplyQty,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Supplied Quantity",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                readOnly: true,
                                initialValue:
                                    siteVisitHistoryEntity[index].supplyDate,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.text,
                                decoration: FormFieldStyle.buildInputDecoration(
                                  labelText: "Supplied Date",
                                ),
                              ),
                              // SizedBox(height: 16),
                              // TextFormField(
                              //   readOnly: true,
                              //   initialValue:
                              //   siteVisitHistoryEntity[index].shipToParty,
                              //   style: TextStyle(
                              //       fontSize: 18,
                              //       color: ColorConstants.inputBoxHintColor,
                              //       fontFamily: "Muli"),
                              //   keyboardType: TextInputType.text,
                              //   decoration: FormFieldStyle.buildInputDecoration(
                              //     labelText: "Next Visit Date",
                              //   ),
                              // ),
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
                  _updateSiteDataFromDb();
                 // UpdateRequest();
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
        DropdownButtonFormField<ConstructionStageEntity>(
          value: _selectedConstructionTypeVisitNextStage,
          items: constructionStageEntityNewNextStage
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
              print(_selectedConstructionTypeVisitNextStage.id);
              siteFloorsEntityNewNextStage = new List();
              _selectedSiteVisitFloorNextStage = null;
              if (_selectedConstructionTypeVisitNextStage.id == 1 ||
                  _selectedConstructionTypeVisitNextStage.id == 2 ||
                  _selectedConstructionTypeVisitNextStage.id == 3) {
                // siteFloorsEntityNew = new List();
                siteFloorsEntityNewNextStage.add(new SiteFloorsEntity(
                    id: siteFloorsEntity[0].id,
                    siteFloorTxt: siteFloorsEntity[0].siteFloorTxt));
              } else {
                for (int i = 1; i < siteFloorsEntity.length; i++) {
                  siteFloorsEntityNewNextStage.add(new SiteFloorsEntity(
                      id: siteFloorsEntity[i].id,
                      siteFloorTxt: siteFloorsEntity[i].siteFloorTxt));
                }
              }
            });
          },
          decoration: FormFieldStyle.buildInputDecoration(
              labelText: "Type of Construction"),
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
        DropdownButtonFormField<SiteFloorsEntity>(
          value: _selectedSiteVisitFloorNextStage,
          items: siteFloorsEntityNewNextStage
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

              // constructionStageEntityNewNextStage = new List();
              // _selectedConstructionTypeVisitNextStage= null;
              // if(_selectedSiteVisitFloor.id == 1 ){
              //   // siteFloorsEntityNew = new List();
              //   for(int i=0;i<3;i++){
              //     constructionStageEntityNewNextStage.add(new ConstructionStageEntity(
              //         id: constructionStageEntity[i].id,
              //         constructionStageText: constructionStageEntity[i].constructionStageText
              //     ));
              //   }
              // }
              // else{
              //
              //   for(int i=3;i<constructionStageEntity.length;i++){
              //     constructionStageEntityNewNextStage.add(new ConstructionStageEntity(
              //         id: constructionStageEntity[i].id,
              //         constructionStageText: constructionStageEntity[i].constructionStageText
              //     ));
              //   }
              // }
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
          decoration: FormFieldStyle.buildInputDecoration(
            labelText: "Stage Potential",
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
        DropdownButtonFormField<BrandModelforDB>(
          value: _siteBrandFromLocalDBNextStage,
          items: siteBrandEntityfromLoaclDB
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
          onChanged: (value) async {
            siteProductEntityfromLoaclDBNextStage = new List();
            _siteProductFromLocalDBNextStage = null;
            List<BrandModelforDB> _siteProductEntityfromLoaclDB =
                await BrandNameDbConfig.fetchAllDistinctProduct(value.brandName);
            setState(() {
              _siteBrandFromLocalDBNextStage = value;

              siteProductEntityfromLoaclDBNextStage =
                  _siteProductEntityfromLoaclDB;
              // _productSoldVisit.text = _siteBrand.productName;
              if (_siteBrandFromLocalDBNextStage.brandName.toLowerCase() ==
                  "dalmia") {
                _stageStatusNextStage.text = "WON";
              } else {
                _stageStatusNextStage.text = "LOST";
              }
            });
          },
          decoration:
              FormFieldStyle.buildInputDecoration(labelText: "Brand in use"),
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
          keyboardType: TextInputType.number,
          decoration: FormFieldStyle.buildInputDecoration(
            labelText: "Brand Price",
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
        DropdownButtonFormField<BrandModelforDB>(
          value: _siteProductFromLocalDBNextStage,
          items: siteProductEntityfromLoaclDBNextStage
              .map((label) => DropdownMenuItem(
                    child: Text(
                      label.productName,
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
              _siteProductFromLocalDBNextStage = value;
              print(_siteProductFromLocalDBNextStage.id);
            });
          },
          decoration: FormFieldStyle.buildInputDecoration(
            labelText: "Product Sold",
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
            "No. of Bags Supplied",
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
                          if(picked!=null) {
                            final String formattedDate = formatter.format(
                                picked);
                            _dateOfBagSuppliedNextStage.text = formattedDate;
                          }
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
                  onChanged: (v) {
                    print(v);
                    print('hi');
                  },
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "No. Of Bags"),
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
        // TextFormField(
        //   controller: _stageStatusNextStage,
        //   validator: (value) {
        //     if (value.isEmpty) {
        //       return 'Please enter Site Built-Up Area ';
        //     }
        //
        //     return null;
        //   },
        //   style: TextStyle(
        //       fontSize: 18,
        //       color: ColorConstants.inputBoxHintColor,
        //       fontFamily: "Muli"),
        //   keyboardType: TextInputType.text,
        //   enabled: false,
        //   decoration:
        //       FormFieldStyle.buildInputDecoration(labelText: "Stage Status//"),
        // ),
        DropdownButtonFormField<SiteStageEntity>(
          value: _siteStageNextStage,
          items: siteStageEntityNextStage
              .map((label) => DropdownMenuItem(
            child: Text(
              label.siteStageDesc,
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.inputBoxHintColor,
                  fontFamily: "Muli"),
            ),
            value: label,
          ))
              .toList(),

          // hint: Text('Rating'),
          onChanged: (value) {
            setState(() {
              _siteStageNextStage = value;


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
            labelText: "Stage Status",
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
        //siteStageEntityNextStage
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
          decoration: FormFieldStyle.buildInputDecoration(
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
                  if(picked!=null) {
                    final String formattedDate = formatter.format(picked);
                    _dateofConstructionNextStage.text = formattedDate;
                  }
                });
              },
            ),
          ),
          // decoration: InputDecoration(
          //   focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //         color: ColorConstants.backgroundColorBlue,
          //         //color: HexColor("#0000001F"),
          //         width: 1.0),
          //   ),
          //   disabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.black26, width: 1.0),
          //   ),
          //   enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.black26, width: 1.0),
          //   ),
          //   errorBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.red, width: 1.0),
          //   ),
          //   labelText: "Planned Start Date of construction",
          //   suffixIcon: IconButton(
          //     icon: Icon(
          //       Icons.date_range_rounded,
          //       size: 22,
          //       color: ColorConstants.clearAllTextColor,
          //     ),
          //     onPressed: () async {
          //       print("here");
          //       final DateTime picked = await showDatePicker(
          //           context: context,
          //           initialDate: DateTime.now(),
          //           firstDate: DateTime.now(),
          //           lastDate: DateTime(2101));
          //
          //       setState(() {
          //         final DateFormat formatter = DateFormat("yyyy-MM-dd");
          //         final String formattedDate = formatter.format(picked);
          //
          //         _dateofConstructionNextStage.text = formattedDate;
          //       });
          //     },
          //   ),
          //   filled: false,
          //   focusColor: Colors.black,
          //   isDense: false,
          //   labelStyle: TextStyle(
          //       fontFamily: "Muli",
          //       color: ColorConstants.inputBoxHintColorDark,
          //       fontWeight: FontWeight.normal,
          //       fontSize: 16.0),
          //   fillColor: ColorConstants.backgroundColor,
          // ),
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

  _getCurrentLocation() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {


      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {

        print("result.... = $position");

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
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _siteAddress.text =
            place.name + "," + place.thoroughfare + "," + place.subLocality;
        print("_getAddressFromLatLng   ${_siteAddress.text}");
        _district.text = place.subAdministrativeArea;
        _state.text = place.administrativeArea;
        _pincode.text = place.postalCode;
        _taluk.text = place.locality;
        //txt.text = place.postalCode;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";

        print(
            "${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, ${place.administrativeArea},"
                " ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, ${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
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
    print('$visitDataDealer $visitDataSubDealer');
    print("fromDropDown: $fromDropDown");
    if (fromDropDown == true) {
      print("0000000000000000000000000o");
      if (_siteBuiltupArea.text == "" ||
          _siteBuiltupArea.text == null ||
          _siteBuiltupArea.text == "null") {
        Get.dialog(CustomDialogs()
            .errorDialog("Please fill mandatory fields in \"Site Data\" Tab"));
      } else {
        updateSiteLogic();
        setState(() {
          fromDropDown = false;
        });
      }
    } else if (_siteBuiltupArea.text == "" ||
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
      updateSiteLogic();
    }
  }

  updateSiteLogic() async {
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
      // print('${widget.siteId}=============');

      List<SiteCommentsEntity> newSiteCommentsEntity = new List();
      newSiteCommentsEntity.add(new SiteCommentsEntity(
          siteId: widget.siteId,
          // id: widget.siteId,
          siteCommentText: _comments.text,
          creatorName: name,
          createdBy: empId));
      // print("-------1234");
      // print(newSiteCommentsEntity[0].siteId);
      if (_selectedConstructionTypeVisit != null) {
        siteVisitHistoryEntity.add(new SiteVisitHistoryEntity(
            totalBalancePotential: _siteTotalBalancePt.text,
            constructionStageId: _selectedConstructionTypeVisit.id ?? 1,
            floorId: _selectedSiteVisitFloor.id,
            stagePotential: _stagePotentialVisit.text,
            brandId: _siteProductFromLocalDB.id,
            brandPrice: _brandPriceVisit.text,
            constructionDate: _dateofConstruction.text,
            siteId: widget.siteId,
            // id: widget.siteId,
            supplyDate: _dateOfBagSupplied.text,
            supplyQty: _siteCurrentTotalBags.text,
            stageStatus: _stageStatus.text,
            createdBy: empId,
            soldToParty: visitDataDealer,
            shipToParty: visitDataSubDealer,
            receiptNumber: "",
            isAuthorised: "N"));
      }

      if (_selectedConstructionTypeVisitNextStage != null) {
        siteNextStageEntity.add(new SiteNextStageEntity(
          siteId: widget.siteId,
          constructionStageId: _selectedConstructionTypeVisitNextStage.id ?? 1,
          stagePotential: _stagePotentialVisitNextStage.text,
          brandId: _siteProductFromLocalDBNextStage.id,
          brandPrice: _brandPriceVisitNextStage.text,
          stageStatus: _stageStatusNextStage.text,
          constructionStartDt: _dateofConstructionNextStage.text,
          nextStageSupplyDate: _dateOfBagSuppliedNextStage.text,
          nextStageSupplyQty: _siteCurrentTotalBags.text,
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

      // print("Sumit Length :: " + newSitePhotoEntity.length.toString());

      //print(sitephotosEntity.)

      if (_listInfluencerDetail.length != 0) {
        if (_listInfluencerDetail[
                        _listInfluencerDetail.length - 1]
                    .inflName ==
                null ||
            _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName ==
                null ||
            _listInfluencerDetail[_listInfluencerDetail.length - 1]
                .inflName
                .text
                .isNullOrBlank) {
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
      print(newInfluencerEntity);

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
        "siteConstructionId": _selectedConstructionType.id,
        "siteCompetitionId": _siteCompetitionStatusEntity != null
            ? _siteCompetitionStatusEntity.id
            : null,
        "siteOppertunityId": _siteOpportunitStatusEnity != null
            ? _siteOpportunitStatusEnity.id
            : null,
        "siteProbabilityWinningId": _siteProbabilityWinningEntity != null
            ? _siteProbabilityWinningEntity.id
            : null,
      };
      // print(updateDataRequest);
      print('updateDataRequest---- $updateDataRequest');

      _siteController.updateLeadData(
          updateDataRequest, _imageList, context, widget.siteId);

      // Get.back();
    });
  }


/*update site data from database*/
  _updateSiteDataFromDb() async {
    int _constructionId=_selectedConstructionType.id;//m
    String _siteBuiltUpAreaValue=_siteBuiltupArea.text; //m
    int _selectedSiteFloorId=_selectedSiteFloor!=null?_selectedSiteFloor.id: 0;
    String  _isSwitchedSiteProductDemoValue = isSwitchedsiteProductDemo? "F": "N";
    String  _isSwitchedSiteProductOralBriefingValue = isSwitchedsiteProductOralBriefing? "F": "N";
    String _siteTotalBagsValue=_siteTotalBags.text;
    String _siteTotalPtValue=_siteTotalPt.text;
    String _ownerNameValue=_ownerName.text;
    String _contactNumberValue=_contactNumber.text;//m
    String _plotNumberValue=_plotNumber.text;
    String _siteAddressValue=_siteAddress.text;
    String _pincodeValue=_pincode.text; //m
    String _stateValue=_state.text; //m
    String _districtValue=_district.text; //m
    String _talukValue=_taluk.text; //m
    String _reraValue=_rera.text;
    String _dealerNameValue=_dealerName.text;
    String _soValue=_so.text;
    String _inactiveReasonTextValue=_inactiveReasonText.text;
    bool status=true;
    /*Check Site data */
    if(_constructionId==null)
      status=false;
    if(_siteBuiltUpAreaValue=="" || _siteBuiltUpAreaValue==null || _siteBuiltUpAreaValue =="_siteBuiltUpAreaValue")
      status=false;

    if (!Util.isMobileValid(_contactNumberValue))
      status = false;

  if (!Util.isPinValid(_pincodeValue))
      status = false;

    if(_stateValue=="" || _stateValue==null || _stateValue=="null")
    status=false;
     if(_districtValue=="" || _districtValue == null || _districtValue == "null")
    status=false;
   if(_talukValue=="" || _talukValue ==null || _talukValue== "null")
    status=false;

   if(!status){
     Get.dialog(CustomDialogs()
         .errorDialog("Please fill mandatory fields in \"Site Data\" TAb"));
     return;
   }
/*Check visit form data */
    String _siteTotalBalanceBagsValue= _siteTotalBalanceBags.text;
    int _selectedConstructionTypeVisitId=_selectedConstructionTypeVisit !=null?  _selectedConstructionTypeVisit.id : null; //m
    int _selectedSiteVisitFloorId=_selectedSiteVisitFloor!=null? _selectedSiteVisitFloor.id :null;  //m
    String _stagePotentialVisitValue= _stagePotentialVisit.text;  //m
    int _siteBrandFromLocalDBId= _siteProductFromLocalDB !=null?_siteProductFromLocalDB.id :null;  //m
    String shipToPartyValue = subDealerList.length>0?subDealerList[0].shipToParty :"";
    String _brandPriceVisitValue=_brandPriceVisit.text;
    String _dateOfBagSuppliedValue=_dateOfBagSupplied.text;//m
    String _siteCurrentTotalBagsValue=_siteCurrentTotalBags.text;
    String _stageStatusValue=_stageStatus.text; //m
    String _dateOfConstructionValue=_dateofConstruction.text;
    int _siteOpportunitStatusEnityId=_siteOpportunitStatusEnity!=null?_siteOpportunitStatusEnity.id : null; //m
    int _siteCompetitionStatusEntityId=_siteCompetitionStatusEntity!=null ?_siteCompetitionStatusEntity.id : null;//m
    int _siteProbabilityWinningEntityId=_siteProbabilityWinningEntity!=null ? _siteProbabilityWinningEntity.id : null;//m
    String _nextVisitDateValue=_nextVisitDate.text;
    String _commentsValue=_comments.text;

    if(_selectedConstructionTypeVisitId ==null || _selectedSiteVisitFloorId==null  || _stagePotentialVisitValue==null||
        _stagePotentialVisitValue=="null"|| _stagePotentialVisitValue=="" || _siteBrandFromLocalDBId == null
        || _siteOpportunitStatusEnityId==null || _siteCompetitionStatusEntityId ==null  || _siteProbabilityWinningEntityId==null ||
        _stageStatusValue==null || _stageStatusValue=="null" || _stageStatusValue ==""||
        _dateOfBagSuppliedValue==null || _dateOfBagSuppliedValue=="null" || _dateOfBagSuppliedValue ==""
    )
      status=false;

    if(!status){
      Get.dialog(CustomDialogs()
          .errorDialog("Please fill mandatory fields in \"Visit Data\" Tab"));
      return;
    }
    int _constructionIdForNextVisit;
    int _floorIdForNextVisit;
    String _stagePotentialValueForNextVisit;
    int _brandIdForNextVisit;
    String _brandPriceForNextVisit;
    String _dateSuppliedValueForNextVisit;
    String _suppliedQtyValueForNextVisit;
    String _stagStatusValueForNextVisit;
    String _dateOfConstructionForNextVisit;
    /*Check next visit data */
    if(addNextButtonDisable) {
       _constructionIdForNextVisit = _selectedConstructionTypeVisitNextStage != null
          ? _selectedConstructionTypeVisitNextStage.id
          : null; //m
        _floorIdForNextVisit = _selectedSiteVisitFloorNextStage != null
          ? _selectedSiteVisitFloorNextStage.id
          : null; //m
        _stagePotentialValueForNextVisit = _stagePotentialVisitNextStage.text; //m
        _brandIdForNextVisit = _siteProductFromLocalDBNextStage != null
          ? _siteProductFromLocalDBNextStage.id
          : null; //m
        _brandPriceForNextVisit = _brandPriceVisitNextStage.text; //m
        _dateSuppliedValueForNextVisit = _dateOfBagSuppliedNextStage.text; //m
        _suppliedQtyValueForNextVisit = _siteCurrentTotalBagsNextStage.text;
        _stagStatusValueForNextVisit = _siteStageNextStage != null
          ? _siteStageNextStage.siteStageDesc
          : null; //m
        _dateOfConstructionForNextVisit = _dateofConstructionNextStage
          .text;

      if (_constructionIdForNextVisit == null || _floorIdForNextVisit == null ||
          _stagePotentialValueForNextVisit == "" || _stagePotentialValueForNextVisit == null ||
          _stagePotentialValueForNextVisit == "null" || _brandIdForNextVisit == null ||
          _brandPriceForNextVisit == "" || _brandPriceForNextVisit == null || _brandPriceForNextVisit == "null" ||
          _dateSuppliedValueForNextVisit == null || _dateSuppliedValueForNextVisit == "" ||
          _dateSuppliedValueForNextVisit == "null" || _suppliedQtyValueForNextVisit == null ||
          _suppliedQtyValueForNextVisit == "" || _suppliedQtyValueForNextVisit == "null"
          || _stagStatusValueForNextVisit == null || _stagStatusValueForNextVisit == "" ||
          _stagStatusValueForNextVisit == "null")
        status = false;

      if (!status) {
        Get.dialog(CustomDialogs().errorDialog(
            StringConstants.HIDE_NEXT_STAGE_BUTTON));
        return;
      }
    }
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
   /*update site data only when the syncStatus is true */
    await _checkSyncStatus().then((value){
      print("_checkSyncStatus  $value");

      if(!value){
        Get.back();
        internetChecking().then((result){
          if(result){
            _siteController.syncDataToServer(_helper);
          }else{

            Get.dialog(CustomDialogs().errorDialog(StringConstants.SITE_DATA_ALREADY_UPDATE));
            return;
          }
        });


      } else{
        /*check user is authorised for update or insert data*/
        _checkUserIsAuthorisedForDataInsert().then((isAuthorised) {
          if (!isAuthorised) {
            Get.dialog(CustomDialogs()
                .errorDialog(StringConstants.NOT_AUTHORISED));
          } else {
            SiteNextStageEntity _nextDataModel;
            if(addNextButtonDisable){
                _nextDataModel=new SiteNextStageEntity(siteId:widget.siteId,constructionStageId:_constructionIdForNextVisit ,stagePotential: _stagePotentialValueForNextVisit ,
                  brandId:_brandIdForNextVisit ,brandPrice:_brandPriceForNextVisit ,stageStatus: _stagStatusValueForNextVisit, constructionStartDt:_dateOfConstructionForNextVisit ,
                  nextStageSupplyDate:_dateSuppliedValueForNextVisit ,nextStageSupplyQty: _suppliedQtyValueForNextVisit, syncStatus : false);
             // _helper.insertDataInTable(DbConstants.TABLE_SITE_NEXT_STAGE_ENTITY, _nextDataModel.toJson(), ConflictAlgorithm.replace);
            }

            /*new data insert in siteVisitHistoryEntity table*/
            SiteCommentsEntity _commentsEntity =new SiteCommentsEntity(siteId: widget.siteId, siteCommentText: _commentsValue);
           // _helper.insertDataInTable(DbConstants.TABLE_SITE_COMMENT_ENTITY, _commentsEntity.toJson(),  ConflictAlgorithm.replace);

            /*new data insert in siteVisitHistoryEntity table*/
            SiteVisitHistoryEntity _visitDataModel=new SiteVisitHistoryEntity( totalBalancePotential:_siteTotalBalanceBagsValue,constructionStageId:_selectedConstructionTypeVisitId,floorId: _selectedSiteVisitFloorId,
                stagePotential:_stagePotentialVisitValue,brandId:_siteBrandFromLocalDBId, brandPrice: _brandPriceVisitValue, constructionDate: _dateOfConstructionValue, siteId:widget.siteId,
                supplyDate: _dateOfBagSuppliedValue, supplyQty: _siteCurrentTotalBagsValue  , isAuthorised:"N" ,stageStatus: _stageStatusValue,  shipToParty: shipToPartyValue, syncStatus: false );
            //_helper.insertDataInTable(DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY, _visitDataModel.toJson(), ConflictAlgorithm.replace);


/*Update Site data */
            SitesModal _dataModel=new SitesModal(siteId:widget.siteId,siteBuiltArea:_siteBuiltUpAreaValue,siteProductDemo:_isSwitchedSiteProductDemoValue,
                siteProductOralBriefing:_isSwitchedSiteProductOralBriefingValue,sitePlotNumber:_plotNumberValue,siteTotalSitePotential:_siteTotalPtValue,siteOwnerName:_ownerNameValue,
                siteOwnerContactNumber:_contactNumberValue,siteAddress:_siteAddressValue,siteState:_stateValue,siteDistrict:_districtValue,siteTaluk:_talukValue,sitePincode:_pincodeValue,
                siteGeotagLatitude:_currentPosition.latitude.toString(),
                siteGeotagLongitude:_currentPosition.longitude.toString(),siteGeotagType:geoTagType,siteReraNumber:_reraValue,siteDealerId:_sitesModel.siteDealerId,siteDealerName:_dealerNameValue,siteSoId:_sitesModel.siteSoId,
                siteSoname:_soValue,siteStageId:labelId, inactiveReasonText:_inactiveReasonTextValue,siteNextVisitDate:_nextVisitDateValue,siteClosureReasonText:_sitesModel.siteClosureReasonText,
                siteProbabilityWinningId:_siteProbabilityWinningEntityId,siteCompetitionId:_siteCompetitionStatusEntityId,siteOppertunityId:_siteOpportunitStatusEnityId,
                assignedTo: _sitesModel.assignedTo,siteStatusId:_sitesModel.siteStatusId,siteCreationDate:_sitesModel.siteCreationDate,siteConstructionId:_constructionId,noOfFloors:_selectedSiteFloorId,
                siteScore: siteScore,syncStatus:false);
                 _siteController.storeDataInLocalDbAndServer(_helper,widget.siteId,_dataModel,_visitDataModel,_commentsEntity,nextDataModel: _nextDataModel );

            // _helper.updateTableRow(DbConstants.TABLE_SITE_LIST, _dataModel.toJson(), "${DbConstants.COL_SITE_ID} = ? ",[widget.siteId]).then((value){
            //   if(value!=0){
            //     Get.back();
            //     Get.dialog(CustomDialogs().errorDialog(StringConstants.SITE_DATA_UPDATE));
            //   }
            // });
          }
        });









      }
    });

  }

  /*insert new row from db for visit data*/
_insertVisitDataFromDb() async {
  /*Next stage fields values*/
  String _siteTotalBalanceBagsValue= _siteTotalBalanceBags.text;
  int _selectedConstructionTypeVisitId=_selectedConstructionTypeVisit !=null?  _selectedConstructionTypeVisit.id : null; //m
  int _selectedSiteVisitFloorId=_selectedSiteVisitFloor!=null? _selectedSiteVisitFloor.id :null;  //m
  String _stagePotentialVisitValue= _stagePotentialVisit.text;  //m
  int _siteBrandFromLocalDBId= _siteProductFromLocalDB !=null?_siteProductFromLocalDB.id :null;  //m
    String shipToPartyValue = subDealerList.length>0?subDealerList[0].shipToParty :"";
  String _brandPriceVisitValue=_brandPriceVisit.text;
  String _dateOfBagSuppliedValue=_dateOfBagSupplied.text;//m
  String _siteCurrentTotalBagsValue=_siteCurrentTotalBags.text;
  String _stageStatusValue=_stageStatus.text; //m
  String _dateOfConstructionValue=_dateofConstruction.text;
  int _siteOpportunitStatusEnityId=_siteOpportunitStatusEnity!=null?_siteOpportunitStatusEnity.id : null; //m
  int _siteCompetitionStatusEntityId=_siteCompetitionStatusEntity!=null ?_siteCompetitionStatusEntity.id : null;//m
  int _siteProbabilityWinningEntityId=_siteProbabilityWinningEntity!=null ? _siteProbabilityWinningEntity.id : null;//m
  String _nextVisitDateValue=_nextVisitDate.text;
  String _commentsValue=_comments.text;
  bool status=true;
  if(_selectedConstructionTypeVisitId ==null || _selectedSiteVisitFloorId==null  || _stagePotentialVisitValue==null||
      _stagePotentialVisitValue=="null"|| _stagePotentialVisitValue=="" || _siteBrandFromLocalDBId == null
      || _siteOpportunitStatusEnityId==null || _siteCompetitionStatusEntityId ==null  || _siteProbabilityWinningEntityId==null ||
      _stageStatusValue==null || _stageStatusValue=="null" || _stageStatusValue ==""||
      _dateOfBagSuppliedValue==null || _dateOfBagSuppliedValue=="null" || _dateOfBagSuppliedValue ==""
  )
    status=false;

  if(!status){
    Get.dialog(CustomDialogs()
        .errorDialog("Please fill mandatory fields in \"Visit Data\" Tab"));
    return;
  }
 await _checkSyncStatus().then((value){
    if(!value){
      Get.back();
      Get.dialog(CustomDialogs().errorDialog(StringConstants.SITE_DATA_ALREADY_UPDATE));
      return;
    }else{
      _checkUserIsAuthorisedForDataInsert().then((isAuthorised){
        if(!isAuthorised){
          Get.dialog(CustomDialogs()
              .errorDialog(StringConstants.NOT_AUTHORISED));
        }else{
          if(addNextButtonDisable){
            int _constructionId= _selectedConstructionTypeVisitNextStage !=null ?_selectedConstructionTypeVisitNextStage.id : null;//m
            int _floorId=_selectedSiteVisitFloorNextStage!=null ?_selectedSiteVisitFloorNextStage.id : null;//m
            String _stagePotentialValue= _stagePotentialVisitNextStage.text; //m
            int _brandId= _siteProductFromLocalDBNextStage!=null ?_siteProductFromLocalDBNextStage.id :null ; //m
            String _brandPrice= _brandPriceVisitNextStage.text; //m
            String _dateSuppliedValue= _dateOfBagSuppliedNextStage.text;//m
            String _suppliedQtyValue= _siteCurrentTotalBagsNextStage.text;
            String _stagStatusValue= _siteStageNextStage!=null ?_siteStageNextStage.siteStageDesc :null; //m
            String _dateOfConstructionNextStageValue= _dateofConstructionNextStage.text;
            bool status=true;

            if(_constructionId==null || _floorId==null ||
                _stagePotentialValue=="" || _stagePotentialValue==null || _stagePotentialValue=="null" || _brandId==null||
                _brandPrice== "" || _brandPrice==null || _brandPrice =="null" ||
                _dateSuppliedValue==null || _dateSuppliedValue=="" || _dateSuppliedValue=="null" || _suppliedQtyValue==null || _suppliedQtyValue=="" || _suppliedQtyValue=="null"
                || _stagStatusValue==null || _stagStatusValue=="" || _stagStatusValue=="null" )
              status=false;

            if(!status){
              Get.dialog(CustomDialogs().errorDialog(
                  StringConstants.HIDE_NEXT_STAGE_BUTTON));
              return;
            }
            SiteNextStageEntity _nextDataModel=new SiteNextStageEntity(siteId:widget.siteId,constructionStageId:_constructionId ,stagePotential: _stagePotentialValue ,
                brandId:_brandId ,brandPrice:_brandPrice ,stageStatus: _stagStatusValue, constructionStartDt:_dateOfConstructionNextStageValue ,
                nextStageSupplyDate:_dateSuppliedValue ,nextStageSupplyQty: _suppliedQtyValue, syncStatus : false);
            _helper.insertDataInTable(DbConstants.TABLE_SITE_NEXT_STAGE_ENTITY, _nextDataModel.toJson(), ConflictAlgorithm.replace);

          }

          /*new data insert in siteVisitHistoryEntity table*/
          SiteVisitHistoryEntity _visitDataModel=new SiteVisitHistoryEntity( totalBalancePotential:_siteTotalBalanceBagsValue,constructionStageId:_selectedConstructionTypeVisitId,floorId: _selectedSiteVisitFloorId,
              stagePotential:_stagePotentialVisitValue,brandId:_siteBrandFromLocalDBId, brandPrice: _brandPriceVisitValue, constructionDate: _dateOfConstructionValue, siteId:widget.siteId,
              supplyDate: _dateOfBagSuppliedValue, supplyQty: _siteCurrentTotalBagsValue  , isAuthorised:"N" ,stageStatus: _stageStatusValue,  shipToParty: shipToPartyValue, syncStatus: false );
          _helper.insertDataInTable(DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY, _visitDataModel.toJson(), ConflictAlgorithm.replace);

          /*update data in site table*/
          SitesModal _dataModel=new SitesModal(siteProbabilityWinningId:_siteProbabilityWinningEntityId,siteCompetitionId:_siteCompetitionStatusEntityId,
              siteOppertunityId:_siteOpportunitStatusEnityId,siteNextVisitDate: _nextVisitDateValue, syncStatus:false);
          _helper.updateTableRow(DbConstants.TABLE_SITE_LIST, _dataModel.toJsonMap(), "${DbConstants.COL_SITE_ID} = ? ",[widget.siteId]);

          /*new data insert in siteVisitHistoryEntity table*/
          SiteCommentsEntity _commentsEntity =new SiteCommentsEntity(siteId: widget.siteId, siteCommentText: _commentsValue);
          _helper.insertDataInTable(DbConstants.TABLE_SITE_COMMENT_ENTITY, _commentsEntity.toJson(),  ConflictAlgorithm.replace).then((value){
            if(value!=0){
              Get.dialog(CustomDialogs()
                  .errorDialog(StringConstants.VISIT_DATA_INSERTED));
            }

          });
        }

      });
    }
  });



}

/*check user is authorised for insert visit data */
Future<bool> _checkUserIsAuthorisedForDataInsert() async {
  print("_checkUserIsAuthorisedForDataInsert    call");

  bool isAuthorised=true;
  await _helper.fetchMapList(DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY, null, "${DbConstants.COL_SITE_ID} = ? ",[widget.siteId],null, null,
       "${DbConstants.COL_ROW_ID} ASC", 1,null).then((value){
     value.forEach((element){
       String isAuthorisedValue= element[DbConstants.COL_SITE_VISIT_HISTORY_isAuthorised];
     print("isAuthorisedValue    $isAuthorisedValue");
       isAuthorised=isAuthorisedValue=="N"? false: true;
     });
   });
  return isAuthorised;
 }


 /*Check sync status from site table*/
  Future<bool> _checkSyncStatus() async {
  bool isInsertData=true;
  await _helper.fetchMapList(DbConstants.TABLE_SITE_LIST, [DbConstants.COL_SYNC_STATUS],  "${DbConstants.COL_SITE_ID} = ? ", [widget.siteId], null, null, null, null, null).then((value){
      value.forEach((element) {
        int dataSyncStatus = element[DbConstants.COL_SYNC_STATUS];
        if(dataSyncStatus==0)
          isInsertData=false;
      });
    });
  return isInsertData;
  }

}

class ImageDetails {
  String from;
  File file;

  ImageDetails(this.from, this.file);
}





