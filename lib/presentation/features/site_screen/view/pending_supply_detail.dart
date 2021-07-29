import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PendingSupplyDetailScreen extends StatefulWidget {
  int siteId;
  final tabIndex;

  PendingSupplyDetailScreen({this.siteId, this.tabIndex});

  @override
  _PendingSupplyDetailScreenState createState() =>
      _PendingSupplyDetailScreenState();
}

class _PendingSupplyDetailScreenState extends State<PendingSupplyDetailScreen>
    with SingleTickerProviderStateMixin {
  final db = BrandNameDBHelper();
  bool fromDropDown = false;
  FocusNode myFocusNode;
  bool isSwitchedsiteProductDemo = false;
  bool isSwitchedsiteProductOralBriefing = false;
  bool addNextButtonDisable = false;
  bool viewMoreActive = false;
  bool isAllowSelectDealer = false;
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
  String visitDataSubDealer = "";

  ConstructionStageEntity _selectedConstructionType;
  ConstructionStageEntity _selectedConstructionTypeVisit;
  ConstructionStageEntity _selectedConstructionTypeVisitNextStage;
  SiteFloorsEntity _selectedSiteFloor;
  SiteFloorsEntity _selectedSiteVisitFloor;
  SiteFloorsEntity _selectedSiteVisitFloorNextStage;
  SiteStageEntity _siteStage;
  SiteProbabilityWinningEntity _siteProbabilityWinningEntity;
  SiteOpportunityStatusEntity _siteOpportunitStatusEnity;
  SiteCompetitionStatusEntity _siteCompetitionStatusEntity;
  int initialInfluencerLength = 0;
  BrandModelforDB _siteBrandFromLocalDB;
  BrandModelforDB _siteBrandFromLocalDBNextStage;
  BrandModelforDB _siteProductFromLocalDBNextStage;
  SiteOpportunityStatusEntity _siteOpportunitStatusEnityVisit;

  List<DropdownMenuItem<String>> productSoldVisitSite = new List();

  // SiteStageEntity _siteStageNextStage;
  var _siteBuiltupArea = new TextEditingController();
  var _siteProductDemo = new TextEditingController();
  var _siteProductOralBriefing = new TextEditingController();
  var _stagePotentialVisit = new TextEditingController();
  var _stagePotentialVisitNextStage = new TextEditingController();
  var _selectedBrand = new TextEditingController();
  var _brandPriceVisit1 = new TextEditingController();
  var _brandPriceVisitNextStage = new TextEditingController();
  var _productSoldVisit = new TextEditingController();
  var _productSoldVisitNextStage = new TextEditingController();
  var _numberBagSuppliedVisit = new TextEditingController();
  var _dateofConstruction = new TextEditingController();
  var _dateofConstructionNextStage = new TextEditingController();
  var _nextVisitDate = new TextEditingController();
  var _dateOfBagSupplied = new TextEditingController();
  var _dateOfBagSupplied1 = new TextEditingController();
  var _dateOfBagSuppliedNextStage = new TextEditingController();
  var _siteCurrentTotalBags = new TextEditingController();
  var _siteCurrentTotalBags1 = new TextEditingController();
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
  var _subDealerName = new TextEditingController();
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
  int _initialIndex = 0, visitSubTypeId;
  String geoTagType;

  String siteCreationDate, visitRemarks;
  final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
  SitesModal sitesModal;
  List<SiteFloorsEntity> siteFloorsEntity = new List();
  List<SiteFloorsEntity> siteFloorsEntityNew = new List();
  List<SiteFloorsEntity> siteFloorsEntityNewNextStage = new List();
  List<SitephotosEntity> sitephotosEntity = new List();

  // List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List()
  List<SiteStageHistory> siteStageHistorys = new List();
  List<SiteSupplyHistorys> siteSupplyHistorys = new List();

  //List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
  List<ConstructionStageEntity> constructionStageEntity = new List();
  List<ConstructionStageEntity> constructionStageEntityNew = new List();
  List<ConstructionStageEntity> constructionStageEntityNewNextStage =
      new List();
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

  // List<Influencer>
  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<SiteCommentsEntity> siteCommentsEntity = new List();
  List<CounterListModel> counterListModel = new List();
  List<DealerForDb> dealerEntityForDb = new List();
  DealerForDb _dealerEntityForDb;
  List<CounterListModel> subDealerList = new List();

  ///site visit
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  TabController _tabController;

  CounterListModel selectedSubDealer = CounterListModel();
  List<ProductListModel> productDynamicList = new List();

  @override
  Widget build(BuildContext context) {
    //gv.selectedClass = widget.classroomId;
    SizeConfig().init(context);
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Scaffold(
//            resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        titleSpacing: 0,
        title: Padding(
          padding:
          const EdgeInsets.only(top: 20.0, bottom: 10, left: 15),
          child: Text(
            "Influencer Name",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: HexColor("#006838"),
                fontFamily: "Muli"),
          ),
        ),
      ),
      body: visitDataView(),

      //child:Text("classroomName")
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
            Text(
              "Site ID: " + widget.siteId.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
                fontFamily: "Muli",
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
                setState(() {
                  _selectedSiteVisitFloor = value;
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
                labelText: "Stage of Construction",
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  try {
                    final text = newValue.text;
                    if (text.isNotEmpty) double.parse(text);
                    return newValue;
                  } catch (e) {}
                  return oldValue;
                }),
              ],
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
            ..._getProductList(),
            sumNoOfBagsSupplied() > 0
                ? Container(
                    child: Text(
                      "MULTIPLE - ${sumNoOfBagsSupplied()} >",
                      style: TextStyle(
                          color: Colors.amber[700],
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 2,
                          fontSize: 15),
                    ),
                  )
                : Container(),
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.black26)),
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 5, bottom: 10, top: 10),
                      child: Text(
                        "ADD MORE PRODUCT",
                        style: TextStyle(
                            color: HexColor("#1C99D4"),
                            fontWeight: FontWeight.bold,
                            // letterSpacing: 2,
                            fontSize: 17),
                      ),
                    ),
                    onPressed: () async {
                      int index;
                      if (productDynamicList.length == 0) {
                        index = 0;
                      } else {
                        index = productDynamicList.length;
                      }
                      print("index1" + index.toString());
                      if (index == 0) {
                        setState(() {
                          BrandModelforDB brand;
                          ProductListModel product11 = new ProductListModel(
                              brandId: -1,
                              brandPrice: new TextEditingController(),
                              supplyDate: new TextEditingController(),
                              supplyQty: new TextEditingController(),
                              isExpanded: new ExpandableController(
                                  initialExpanded: true),
                              brandModelForDB: brand,
                              dealerName: new TextEditingController());
                          productDynamicList.insert(index, product11);
                        });
                      } else {
                        if (productDynamicList[index - 1].brandId != -1) {
                          setState(() {
                            BrandModelforDB brand;
                            ProductListModel product11 = new ProductListModel(
                                brandId: -1,
                                brandPrice: new TextEditingController(),
                                supplyDate: new TextEditingController(),
                                supplyQty: new TextEditingController(),
                                isExpanded: new ExpandableController(
                                    initialExpanded: true),
                                brandModelForDB: brand,
                                dealerName: new TextEditingController());
                            productDynamicList.insert(index, product11);
                          });
                        } else {
                          Get.dialog(CustomDialogs().errorDialog(
                              "Please enter product ${index} details !"));
                        }
                      }
                    },
                  )),
            ),

            SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color:Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
                      child: Text(
                        "REJECT",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    onPressed: () async {},
                  ),
                  RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: HexColor("#1C99D4"),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
                      child: Text(
                        "ACCEPT",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    onPressed: () async {},
                  )
                ],
              ),
            SizedBox(height: 40),
          ]),
    ))));
  }

  List<Widget> _getProductList() {
    List<Widget> productAddedList = [];
    for (int i = 0; i < productDynamicList.length; i++) {
      productAddedList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          children: [
            addProductDetails(i),
          ],
        ),
      ));
    }
    return productAddedList;
  }

  Widget addProductDetails(int index) {
    return ExpandablePanel(
      controller: productDynamicList[index].isExpanded,
      header: Text(
        "Product " + (index + 1).toString(),
        softWrap: true,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            // color: HexColor("#000000DE"),
            fontFamily: "Muli"),
      ),
      expanded: Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                (index == 0)
                    ? (productDynamicList[index].brandId == -1)
                        ? DropdownButtonFormField<BrandModelforDB>(
                            value: _siteBrandFromLocalDB,
                            items: siteBrandEntityfromLoaclDB
                                .map((label) => DropdownMenuItem(
                                      child: Text(
                                        label.brandName,
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
                            onChanged: (value) async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              siteProductEntityfromLoaclDB = new List();
                              // _siteProductFromLocalDB = null;
                              List<BrandModelforDB>
                                  _siteProductEntityfromLoaclDB = await db
                                      .fetchAllDistinctProduct(value.brandName);
                              setState(() {
                                _siteBrandFromLocalDB = value;

                                siteProductEntityfromLoaclDB =
                                    _siteProductEntityfromLoaclDB;
                                // _productSoldVisit.text = _siteBrand.productName;
                                if (_siteBrandFromLocalDB.brandName
                                        .toLowerCase() ==
                                    "dalmia") {
                                  _stageStatus.text = "WON";
                                } else {
                                  _stageStatus.text = "LOST";
                                  visitDataDealer = "";
                                }
                                _selectedBrand.text = value.brandName;
                              });
                            },
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Brand In Use",
                            ),
                          )
                        : DropdownButtonFormField<BrandModelforDB>(
                            value: _siteBrandFromLocalDB,
                            items: [_siteBrandFromLocalDB]
                                .map((label) => DropdownMenuItem(
                                      child: Text(
                                        label.brandName,
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
                            onChanged: (value) async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Brand In Use",
                            ),
                          )
                    : TextFormField(
                        controller: _selectedBrand,
                        readOnly: true,
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                        keyboardType: TextInputType.number,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Brand In Use"),
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
                SizedBox(height: 12),
                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia")
                    ? GestureDetector(
                        onTap: () {},
                        child: (index == 0)
                            ? (productDynamicList[index]
                                    .dealerName
                                    .text
                                    .isEmpty)
                                ? DropdownButtonFormField<DealerForDb>(
                                    value: _dealerEntityForDb,
                                    items: dealerEntityForDb
                                        .map((label) => DropdownMenuItem(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100,
                                                child: Text(
                                                    '${label.dealerName} (${label.id})',
                                                    style: TextStyle(
                                                        fontSize: 14)),
                                              ),
                                              value: label,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      selectedSubDealer = null;
                                      setState(() {
                                        _dealerEntityForDb = value;
                                        subDealerList = new List();
                                        visitDataDealer = value.id;
                                        subDealerList = counterListModel
                                            .where((e) =>
                                                e.soldToParty ==
                                                visitDataDealer)
                                            .toList();
                                        selectedSubDealer = subDealerList[0];
                                        visitDataSubDealer =
                                            subDealerList[0].shipToParty;
                                        _dealerName.text = value.dealerName;
                                      });
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "Dealer"),
                                    validator: (value) => value == null
                                        ? 'Please select Dealer'
                                        : null,
                                  )
                                : DropdownButtonFormField<DealerForDb>(
                                    value: _dealerEntityForDb,
                                    items: [_dealerEntityForDb]
                                        .map((label) => DropdownMenuItem(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100,
                                                child: Text(
                                                    '${label.dealerName} (${label.id})',
                                                    style: TextStyle(
                                                        fontSize: 14)),
                                              ),
                                              value: label,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      selectedSubDealer = null;
                                      setState(() {
                                        _dealerEntityForDb = value;
                                        subDealerList = new List();
                                        visitDataDealer = value.id;
                                        subDealerList = counterListModel
                                            .where((e) =>
                                                e.soldToParty ==
                                                visitDataDealer)
                                            .toList();
                                        selectedSubDealer = subDealerList[0];
                                        visitDataSubDealer =
                                            subDealerList[0].shipToParty;
                                        _dealerName.text = value.dealerName;
                                      });
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "Dealer"),
                                    validator: (value) => value == null
                                        ? 'Please select Dealer'
                                        : null,
                                  )
                            : TextFormField(
                                controller: _dealerName,
                                readOnly: true,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ColorConstants.inputBoxHintColor,
                                    fontFamily: "Muli"),
                                keyboardType: TextInputType.number,
                                decoration: FormFieldStyle.buildInputDecoration(
                                    labelText: "Dealer"),
                              ),
                      )
                    : Container(),
                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia")
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Mandatory",
                          style: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    : Container(),
                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia")
                    ? SizedBox(height: 15)
                    : SizedBox(),
                subDealerList.isEmpty
                    ? Container()
                    : (_siteBrandFromLocalDB != null &&
                            _siteBrandFromLocalDB.brandName.toLowerCase() ==
                                "dalmia")
                        ? DropdownButtonFormField(
                            items: subDealerList.isNotEmpty
                                ? subDealerList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            child: Text(
                                              '${e.shipToPartyName} (${e.shipToParty})',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ))
                                    .toList()
                                : [
                                    DropdownMenuItem(
                                        child: Text("No Sub Dealer"),
                                        value: "0")
                                  ],
                            value: selectedSubDealer,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please select Sub-Dealer'
                                : null,
                            onChanged: (value) {
                              setState(() {
                                visitDataSubDealer =
                                    value.shipToParty.toString();
                              });
                            },
                            style: FormFieldStyle.formFieldTextStyle,
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Sub-Dealer"),
                          )
                        : Container(),
                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia")
                    ? SizedBox(height: 8)
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.only(right: 0, top: 0),
                  child: DropdownButtonFormField<BrandModelforDB>(
                      value: productDynamicList[index].brandModelForDB,
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
                        setState(() {
                          productDynamicList[index].brandModelForDB = value;
                        });
                      },
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Product Sold")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    "Mandatory",
                    style: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                TextFormField(
                  controller: productDynamicList[index].brandPrice,
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Brand Price"),
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
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
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
                          controller: productDynamicList[index].supplyDate,
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
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
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
                                  if (picked != null) {
                                    final String formattedDate =
                                        formatter.format(picked);
                                    productDynamicList[index].supplyDate.text =
                                        formattedDate;
                                    // _dateOfBagSupplied1.text = formattedDate;
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
                    // Text(_siteCurrentTotalBags.text),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: productDynamicList[index].supplyQty,
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                Center(
                  child: RaisedButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: HexColor("#1C99D4"),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 1, top: 1),
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0,
                            fontSize: 15),
                      ),
                    ),
                    onPressed: () async {
                      // print("cssdsa  "+productDynamicList[index].brandModelForDB.brandName);
                      if (productDynamicList[index].brandModelForDB == null) {
                        Get.dialog(CustomDialogs()
                            .showMessage("Please select product sold !"));
                        return;
                      }

                      if (productDynamicList[index].brandPrice.text.isEmpty) {
                        Get.dialog(CustomDialogs()
                            .showMessage("Please enter brand price !"));
                        return;
                      }

                      if (productDynamicList[index].supplyDate.text.isEmpty) {
                        Get.dialog(CustomDialogs()
                            .showMessage("Please Select Date !"));
                        return;
                      }

                      if (productDynamicList[index].supplyQty.text.isEmpty) {
                        Get.dialog(CustomDialogs()
                            .showMessage("Please Enter Supply Quantity !"));
                        return;
                      }

                      setState(() {
                        productDynamicList[index] = new ProductListModel(
                            brandId:
                                productDynamicList[index].brandModelForDB.id,
                            brandPrice: productDynamicList[index].brandPrice,
                            supplyDate: productDynamicList[index].supplyDate,
                            supplyQty: productDynamicList[index].supplyQty,
                            isExpanded: new ExpandableController(
                                initialExpanded: false),
                            brandModelForDB:
                                productDynamicList[index].brandModelForDB,
                            dealerName: _dealerName);
                        sumNoOfBagsSupplied();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      collapsed: Row(
        children: [
          Expanded(
              flex: 7,
              child: Text(
                productDynamicList[index].supplyDate.text.isEmpty ||
                        productDynamicList[index].supplyQty.text.isEmpty ||
                        productDynamicList[index].brandPrice.text.isEmpty ||
                        productDynamicList[index].brandId == -1
                    ? "Fill product Details"
                    : productDynamicList[index].brandModelForDB.productName +
                        ",  Qty:" +
                        productDynamicList[index].supplyQty.text +
                        ", Price:" +
                        productDynamicList[index].brandPrice.text,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    // color: HexColor("#000000DE"),
                    fontFamily: "Muli"),
              )),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                // int index1 = siteStageHistorys[index].siteSupplyHistorys.indexWhere((element) => element.brandId==productDynamicList[index].brandId && element.brandPrice==productDynamicList[index].brandPrice.text
                //     && element.supplyDate==productDynamicList[index].supplyDate.text && element.supplyQty==productDynamicList[index].supplyQty.text);

                if (productDynamicList != null &&
                    productDynamicList.length == 1) {
                  productDynamicList.removeAt(index);
                  _siteBrandFromLocalDB = null;
                  _dealerEntityForDb = null;
                  subDealerList = new List();
                  siteProductEntityfromLoaclDB = new List();
                } else {
                  productDynamicList.removeAt(index);
                }

                // if(index1!=-1){
                //   siteStageHistorys.removeAt(index1);
                // }

                setState(() {});
              },
              child: Icon(Icons.delete, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  int sumNoOfBagsSupplied() {
    int totalSumBagsSupplied = 0;
    if (productDynamicList.length > 0) {
      for (int i = 0; i < productDynamicList.length; i++) {
        if (productDynamicList[i].supplyQty != null &&
            (productDynamicList[i].supplyQty.text.isNotEmpty)) {
          totalSumBagsSupplied = totalSumBagsSupplied +
                  int.tryParse(productDynamicList[i].supplyQty.text) ??
              0;
        }
      }
    }
    return totalSumBagsSupplied;
  }
}
