import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/KittyBagsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/updated_values.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SiteProgressWidget extends StatefulWidget {
  ViewSiteDataResponse viewSiteDataResponse;
  TabController tabController;
  int tabIndex;

  SiteProgressWidget(
      {this.viewSiteDataResponse, this.tabController, this.tabIndex});

  _SiteDataViewWidgetState createState() => _SiteDataViewWidgetState();
}

class _SiteDataViewWidgetState extends State<SiteProgressWidget>
    with SingleTickerProviderStateMixin {
  SiteController _siteController = Get.find();
  final _updateFormKey = GlobalKey<FormState>();
  final db = BrandNameDBHelper();
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
  String visitDataDealer;
  String visitDataSubDealer = "";
  ConstructionStageEntity _selectedConstructionTypeVisit;
  ConstructionStageEntity _selectedConstructionTypeVisitNextStage;
  SiteFloorsEntity _selectedSiteVisitFloor;
  SiteFloorsEntity _selectedSiteVisitFloorNextStage;
  int initialInfluencerLength = 0;
  BrandModelforDB _siteBrandFromLocalDB;
  BrandModelforDB _siteBrandFromLocalDBNextStage;
  BrandModelforDB _siteProductFromLocalDBNextStage;
  List<DropdownMenuItem<String>> productSoldVisitSite = new List.empty(growable: true);
  var _stagePotentialVisit = new TextEditingController();
  var _stagePotentialVisitNextStage = new TextEditingController();
  var _selectedBrand = new TextEditingController();
  var _brandPriceVisitNextStage = new TextEditingController();
  var _dateofConstruction = new TextEditingController();
  var _dateofConstructionNextStage = new TextEditingController();
  var _dateOfBagSuppliedNextStage = new TextEditingController();
  var _siteCurrentTotalBagsNextStage = new TextEditingController();
  var _comments = new TextEditingController();
  var closureReasonText = new TextEditingController();

  var _stageStatus = new TextEditingController();
  var _stageStatusNextStage = new TextEditingController();
  var _dealerName = new TextEditingController();
  int visitSubTypeId;
  String geoTagType;

  String siteCreationDate, visitRemarks;
  final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
  SitesModal sitesModal;
  MwpVisitModel mwpVisitModel;
  List<SiteFloorsEntity> siteFloorsEntity = new List.empty(growable: true);
  List<SiteFloorsEntity> siteFloorsEntityNew = new List.empty(growable: true);
  List<SiteFloorsEntity> siteFloorsEntityNewNextStage = new List.empty(growable: true);
  List<SitephotosEntity> sitephotosEntity = new List.empty(growable: true);
  List<SiteStageHistory> siteStageHistorys = new List.empty(growable: true);
  List<SiteSupplyHistorys> siteSupplyHistorys = new List.empty(growable: true);
  List<ConstructionStageEntity> constructionStageEntity = new List.empty(growable: true);
  List<ConstructionStageEntity> constructionStageEntityNew = new List.empty(growable: true);
  List<ConstructionStageEntity> constructionStageEntityNewNextStage =
      new List.empty(growable: true);
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity = new List.empty(growable: true);
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity = new List.empty(growable: true);
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity = new List.empty(growable: true);
  List<SiteBrandEntity> siteBrandEntity = new List.empty(growable: true);
  List<BrandModelforDB> siteBrandEntityfromLoaclDB = new List.empty(growable: true);
  List<BrandModelforDB> siteProductEntityfromLoaclDB = new List.empty(growable: true);
  List<BrandModelforDB> siteProductEntityfromLoaclDBNextStage = new List.empty(growable: true);
  List<SiteInfluencerEntity> siteInfluencerEntity = new List.empty(growable: true);
  List<InfluencerTypeEntity> influencerTypeEntity = new List.empty(growable: true);
  List<InfluencerCategoryEntity> influencerCategoryEntity = new List.empty(growable: true);
  List<SiteStageEntity> siteStageEntity = new List.empty(growable: true);
  List<InfluencerEntity> influencerEntity = new List.empty(growable: true);
  List<SiteNextStageEntity> siteNextStageEntity = new List.empty(growable: true);
  List<SiteCommentsEntity> siteCommentsEntity = new List.empty(growable: true);
  List<CounterListModel> counterListModel = new List.empty(growable: true);
  List<DealerForDb> dealerEntityForDb = new List.empty(growable: true);
  DealerForDb _dealerEntityForDb;
  List<CounterListModel> subDealerList = new List.empty(growable: true);
  List<CounterListModel> dealerList = new List.empty(growable: true);

  String _selectedRadioValue = 'Y';
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();

  CounterListModel selectedSubDealer = CounterListModel();

  List<ProductListModel> productDynamicList = new List.empty(growable: true);

  String availableKittyPoint = "0";
  String claimableKittyBagsAvailable = "0";
  String reservedKittyBagsAvailable = "0";

  KittyBagsListModel _kittyBagsListModel;

  getKittyBags(String partyCode) {
    internetChecking().then((result) => {
          if (result == true)
            {
              _siteController.getSiteKittyBags(partyCode).then((data) {
                setState(() {
                  if (data != null) {
                    _kittyBagsListModel = data;
                    claimableKittyBagsAvailable =
                        '${_kittyBagsListModel.response.totalKittyBagsForKittyPointsList}';
                    reservedKittyBagsAvailable =
                        '${_kittyBagsListModel.response.totalKittyBagsForReservePoolList}';
                  }
                });
              })
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,

                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
            }
        });
  }

  /// get _getProductList
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
                   onChanged: (value) async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              siteProductEntityfromLoaclDB = new List.empty(growable:true);
                              productDynamicList[index].brandModelForDB = null;
                              _dealerEntityForDb = null;
                              _selectedRadioValue = null;
                              List<BrandModelforDB>
                                  _siteProductEntityfromLoaclDB = await db
                                      .fetchAllDistinctProduct(value.brandName);
                              setState(() {
                                _siteBrandFromLocalDB = value;
                                siteProductEntityfromLoaclDB =
                                    _siteProductEntityfromLoaclDB;
                                UpdatedValues.setSiteSelectedDB(
                                    _siteBrandFromLocalDB);
                                UpdatedValues.setProductEntityFromLocalDb(
                                    siteProductEntityfromLoaclDB);
                                if (_siteBrandFromLocalDB.brandName
                                        .toLowerCase() ==
                                    "dalmia") {
                                  _stageStatus.text = "WON";
                                  _selectedRadioValue = 'Y';
                                } else {
                                  _stageStatus.text = "LOST";
                                  visitDataDealer = "";
                                  _selectedRadioValue = null;

                                }
                                UpdatedValues.setSiteProgressStageStatus(
                                    _stageStatus.text);
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
                                        label != null
                                            ? label.brandName ?? ""
                                            : "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                      ),
                                      value: label,
                                    ))
                                .toList(),
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
                TextStyles.mandatoryText,
                SizedBox(height: 12),

/*
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
                                        UpdatedValues.setDealerEntityForDb(
                                            _dealerEntityForDb);
                                        UpdatedValues.setSelectedSubDealer(
                                            selectedSubDealer);
                                        UpdatedValues.setSubDealerList(
                                            subDealerList);
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
                                        availableKittyPoint = subDealerList[0]
                                            .availableKittyPoint;
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
                                selectedSubDealer = value;
                                visitDataSubDealer =
                                    value.shipToParty.toString();
                                availableKittyPoint =
                                    selectedSubDealer.availableKittyPoint;
                                UpdatedValues.setSelectedSubDealer(
                                    selectedSubDealer);
                              });
                            },
                            style: FormFieldStyle.formFieldTextStyle,
                            decoration: FormFieldStyle.buildInputDecoration(
                                labelText: "Sub-Dealer"),
                          )
                        : Container(),


                dealerList.isEmpty
                    ? Container()
                    :
                */

                ///Changes for Instead of two drop downs for dealer and subdealer only one dropdown as counter
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
                                      setState(() {
                                        _dealerEntityForDb = value;
                                        visitDataDealer = value.id;
                                        _dealerName.text = value.dealerName;
                                        UpdatedValues.setDealerEntityForDb(
                                            _dealerEntityForDb);
                                        getKittyBags(value.id);
                                      });
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "Counter"),
                                    validator: (value) => value == null
                                        ? 'Please select Counter'
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
                                      setState(() {
                                        _dealerEntityForDb = value;
                                        visitDataDealer = value.id;
                                        _dealerName.text = value.dealerName;
                                        for (int i = 0;
                                            i < counterListModel.length;
                                            i++) {
                                          if (counterListModel[i].shipToParty ==
                                              value.id) {
                                            availableKittyPoint =
                                                counterListModel[i]
                                                    .availableKittyPoint;
                                          }
                                        }

                                      });
                                    },
                                    style: FormFieldStyle.formFieldTextStyle,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                            labelText: "Counter"),
                                    validator: (value) => value == null
                                        ? 'Please select counter'
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
                                    labelText: "Counter"),
                              ),
                      )
                    : Container(),

                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia")
                    ? TextStyles.mandatoryText
                    : Container(),

                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia")
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            child: Text(
                              "Award Loyalty Point",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: "Muli"),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 'Y',
                                      groupValue: productDynamicList[index].awardLoyaltyPoint,
                                      //_selectedRadioValue,
                                      onChanged: (value) {
                                        setState(() {
                                            _selectedRadioValue = value;
                                            productDynamicList[index].awardLoyaltyPoint = value;
                                        });
                                      },
                                    ),
                                    Text("Yes",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Muli"),)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 'N',
                                      groupValue: productDynamicList[index].awardLoyaltyPoint,
                                      //_selectedRadioValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedRadioValue = value;
                                          productDynamicList[index].awardLoyaltyPoint = value;
                                        });
                                      },
                                    ),
                                    Text("No",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Muli"),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ))
                    : Container(),

                (_siteBrandFromLocalDB != null &&
                        _siteBrandFromLocalDB.brandName.toLowerCase() ==
                            "dalmia" &&
                        visitDataDealer != null)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 5, right: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reserved Kitty Bags Available",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: HexColor("#168A08"),
                                      fontFamily: "Muli"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                        CustomDialogs()
                                            .showDialogForKittiPoints(
                                                _kittyBagsListModel, context),
                                        barrierDismissible: false);
                                  },
                                  child: Text(
                                    reservedKittyBagsAvailable,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontFamily: "Muli"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Claimable Kitty Bags Available",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: HexColor("#168A08"),
                                      fontFamily: "Muli"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                        CustomDialogs()
                                            .showDialogForKittiPoints(
                                                _kittyBagsListModel, context),
                                        barrierDismissible: false);
                                  },
                                  child: Text(
                                    claimableKittyBagsAvailable,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontFamily: "Muli"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                      onChanged: (value) {
                        setState(() {
                          productDynamicList[index].brandModelForDB = value;
                        });
                      },
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Product Sold")),
                ),
                TextStyles.mandatoryText,
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
                TextStyles.mandatoryText,
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                  child: Text(
                    "No. of Bags Supplied",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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

                                final DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now().subtract(Duration(
                                      days: widget
                                          .viewSiteDataResponse.supplyDate)),
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
                          controller: productDynamicList[index].supplyQty,
                          onChanged: (v) {
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
                TextStyles.mandatoryText,
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#1C99D4"),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
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

                      if (_siteBrandFromLocalDB != null &&
                          _siteBrandFromLocalDB.brandName.toLowerCase() ==
                              "dalmia") {
                        if (_dealerEntityForDb == null) {
                          Get.dialog(CustomDialogs()
                              .showMessage("Please Select Dealer name !"));
                          return;
                        }
                      }

                      if (_siteBrandFromLocalDB != null &&
                          _siteBrandFromLocalDB.brandName.toLowerCase() !=
                              "dalmia") {
                           productDynamicList[index].awardLoyaltyPoint = null;
                      }

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
                            dealerName: _dealerName,
                        awardLoyaltyPoint: productDynamicList[index].awardLoyaltyPoint);
                        sumNoOfBagsSupplied();
                        updateSiteSupplyHistory();
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
                    fontFamily: "Muli"),
              ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (productDynamicList != null &&
                    productDynamicList.length == 1) {
                  productDynamicList.removeAt(index);
                  _siteBrandFromLocalDB = null;
                  _dealerEntityForDb = null;
                  subDealerList = new List.empty(growable: true);
                  siteProductEntityfromLoaclDB = new List.empty(growable: true);
                } else {
                  productDynamicList.removeAt(index);
                  updateSiteSupplyHistory();
                }
                setState(() {});
              },
              child: Icon(Icons.delete, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  setSiteProgressData() async {
    await db.clearTable();
    for (int i = 0;
        i < widget.viewSiteDataResponse.siteBrandEntity.length;
        i++) {
      await db.addBrandName(new BrandModelforDB(
          widget.viewSiteDataResponse.siteBrandEntity[i].id,
          widget.viewSiteDataResponse.siteBrandEntity[i].brandName,
          widget.viewSiteDataResponse.siteBrandEntity[i].productName));
    }


///Added shipToParty to dealers
    for (int i = 0;
        i < widget.viewSiteDataResponse.counterListModel.length;
        i++) {
      await db.addDealer(DealerForDb(
          widget.viewSiteDataResponse.counterListModel[i].shipToParty,
          widget.viewSiteDataResponse.counterListModel[i].shipToPartyName));
    }

    List<BrandModelforDB> siteBrandEntityfromLoaclDB1 =
        await db.fetchAllDistinctBrand();
    List<DealerForDb> dealerEntityForDb1 = await db.fetchAllDistinctDealers();

    if (this.mounted) {
      setState(() {
        viewSiteDataResponse = widget.viewSiteDataResponse;
        siteBrandEntityfromLoaclDB = siteBrandEntityfromLoaclDB1;
        dealerEntityForDb = dealerEntityForDb1;
        siteBrandEntity = viewSiteDataResponse != null
            ? viewSiteDataResponse.siteBrandEntity
            : new List.empty(growable: true);
        counterListModel = viewSiteDataResponse.counterListModel;
        constructionStageEntityNewNextStage =
            viewSiteDataResponse.constructionStageEntity;
        constructionStageEntityNew =
            viewSiteDataResponse.constructionStageEntity;
        addNextButtonDisable = false;
        siteFloorsEntity = viewSiteDataResponse.siteFloorsEntity;
        siteFloorsEntityNew = viewSiteDataResponse.siteFloorsEntity;
        siteFloorsEntityNewNextStage = viewSiteDataResponse.siteFloorsEntity;
        siteCommentsEntity = viewSiteDataResponse.siteCommentsEntity;
        sitephotosEntity = viewSiteDataResponse.sitephotosEntity;
        if (viewSiteDataResponse.siteStageHistorys != null) {
          siteStageHistorys = viewSiteDataResponse.siteStageHistorys;
        } else {
          siteStageHistorys = [];
        }

        if (UpdatedValues.getSiteProgressConstructionId() != null) {
          _selectedConstructionTypeVisit = null;
          _selectedConstructionTypeVisit =
              UpdatedValues.getSiteProgressConstructionId();
        }

        if (UpdatedValues.getConstructionTypeVisitNextStage() != null) {
          _selectedConstructionTypeVisitNextStage = null;
          _selectedConstructionTypeVisitNextStage =
              UpdatedValues.getConstructionTypeVisitNextStage();
        }

        if (UpdatedValues.getSiteProgressNoOfFloors() != null) {
          _selectedSiteVisitFloor = null;
          _selectedSiteVisitFloor = siteFloorsEntity.firstWhere((item) =>
              item.id == UpdatedValues.getSiteProgressNoOfFloors().id);
        }

        if (UpdatedValues.getSiteProgressStagePotential() != null) {
          _stagePotentialVisit.text =
              UpdatedValues.getSiteProgressStagePotential();
        }

        if (UpdatedValues.getSiteProgressStageStatus() != null) {
          _stageStatus.text = UpdatedValues.getSiteProgressStageStatus();
        }

        if (UpdatedValues.getSiteProgressDateOfConstruction() != null) {
          _dateofConstruction.text =
              UpdatedValues.getSiteProgressDateOfConstruction();
        }

        if (UpdatedValues.getAddNextButtonDisable() != null) {
          addNextButtonDisable = UpdatedValues.getAddNextButtonDisable();
        }

        if (UpdatedValues.getDealerEntityForDb() != null &&
            _siteBrandFromLocalDB != null) {
          _dealerEntityForDb = null;
          _dealerEntityForDb = UpdatedValues.getDealerEntityForDb();
          _dealerName.text = _dealerEntityForDb.dealerName;
          visitDataDealer = _dealerEntityForDb.id;
        }

        if (UpdatedValues.getProductEntityFromLocalDb() != null &&
            _siteBrandFromLocalDB != null) {
          siteProductEntityfromLoaclDB = new List.empty(growable: true);
          siteProductEntityfromLoaclDB =
              UpdatedValues.getProductEntityFromLocalDb();
        }

        if (UpdatedValues.getSubDealerList() != null &&
            _siteBrandFromLocalDB != null) {
          subDealerList = UpdatedValues.getSubDealerList();
        }

        if (UpdatedValues.getSiteProgressStageStatus() != null) {
          _stageStatus.text = UpdatedValues.getSiteProgressStageStatus();
        }

        if (UpdatedValues.getSiteProgressDateOfConstruction() != null) {
          _dateofConstruction.text =
              UpdatedValues.getSiteProgressDateOfConstruction();
        }

        if (UpdatedValues.getProductDynamicList() != null) {
          productDynamicList = UpdatedValues.getProductDynamicList();
          updateSiteSupplyHistory();
        }

        if (UpdatedValues.getSiteBrandFromLocalDBNextStage() != null) {
          _siteBrandFromLocalDBNextStage = null;
          _siteBrandFromLocalDBNextStage =
              UpdatedValues.getSiteBrandFromLocalDBNextStage();
        }
      });
    }
  }

  void setBrandData(var siteBrandEntityfromLoaclDB1, var dealerList) {
    setState(() {
      siteBrandEntityfromLoaclDB = siteBrandEntityfromLoaclDB1;
      dealerEntityForDb = dealerList;
    });
  }

  @override
  void initState() {
    setSiteProgressData();
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
    return visitDataView();
  }

  Widget visitDataView() {
    return ListView(children: [
      Container(
          child: Form(
            key: _updateFormKey,
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
                          fontSize: 18,
                          fontFamily: "Muli"),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.tabIndex = 3;
                          widget.tabController.animateTo(3);
                        });
                      },
                      child: Text(
                        "View previous detail",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: HexColor("#F9A61A"),
                            fontFamily: "Muli"),
                      ),
                    ),
                  ],
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

                onChanged: (value) {
                  setState(() {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectedConstructionTypeVisit = value;
                    siteFloorsEntityNew = new List.empty(growable: true);
                    _selectedSiteVisitFloor = null;
                    if (_selectedConstructionTypeVisit.id == 1 ||
                        _selectedConstructionTypeVisit.id == 2 ||
                        _selectedConstructionTypeVisit.id == 3) {
                      siteFloorsEntityNew.add(new SiteFloorsEntity(
                          id: siteFloorsEntity[0].id,
                          siteFloorTxt: siteFloorsEntity[0].siteFloorTxt));
                    } else {
                      for (int i = 0; i < siteFloorsEntity.length; i++) {
                        siteFloorsEntityNew.add(new SiteFloorsEntity(
                            id: siteFloorsEntity[i].id,
                            siteFloorTxt: siteFloorsEntity[i].siteFloorTxt));
                      }
                    }
                    _stagePotentialVisit.clear();
                    UpdatedValues.setSiteProgressConstructionId(
                        _selectedConstructionTypeVisit);
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
                onChanged: (value) {
                  setState(() {
                    _selectedSiteVisitFloor = value;
                    UpdatedValues.setSiteProgressNoOfFloors(
                        _selectedSiteVisitFloor);
                    if (viewSiteDataResponse.siteStagePotentialEntity != null &&
                        viewSiteDataResponse.siteStagePotentialEntity.length >
                            0) {
                      double siteTotalSitePotential = viewSiteDataResponse
                                  .sitesModal.siteTotalSitePotential !=
                              null
                          ? double.parse(viewSiteDataResponse
                              .sitesModal.siteTotalSitePotential)
                          : 0;
                      _stagePotentialVisit.clear();
                      if ((siteTotalSitePotential != null ||
                              !siteTotalSitePotential.isBlank) &&
                          (_selectedConstructionTypeVisit != null &&
                              (_selectedConstructionTypeVisit.id != null ||
                                  !_selectedConstructionTypeVisit
                                      .id.isBlank)) &&
                          (_selectedSiteVisitFloor != null &&
                              (_selectedSiteVisitFloor.id != null ||
                                  !_selectedSiteVisitFloor.id.isBlank))) {
                        _stagePotentialVisit.text = calculateStagePotential(
                                siteTotalSitePotential,
                                viewSiteDataResponse.siteStagePotentialEntity,
                                _selectedConstructionTypeVisit.id,
                                _selectedSiteVisitFloor.id)
                            .toString();
                      }
                    }
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
                onChanged: (String data) {
                  UpdatedValues.setSiteProgressStagePotential(data);
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
                  labelText: "Stage Potential (Bags)",
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
                    child: TextButton(
                    style: TextButton.styleFrom(

    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(color: Colors.black26)),
                      backgroundColor: Colors.transparent,),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 5, bottom: 10, top: 10),
                        child: Text(
                          "ADD MORE PRODUCT",
                          style: TextStyle(
                              color: HexColor("#1C99D4"),
                              fontWeight: FontWeight.bold,
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
                        if (index == 0) {
                          setState(() {
                            _selectedRadioValue = "Y";
                            BrandModelforDB brand;
                            ProductListModel product11 = new ProductListModel(
                                brandId: -1,
                                brandPrice: new TextEditingController(),
                                supplyDate: new TextEditingController(),
                                supplyQty: new TextEditingController(),
                                isExpanded: new ExpandableController(
                                    initialExpanded: true),
                                brandModelForDB: brand,
                                dealerName: new TextEditingController(),
                              awardLoyaltyPoint: "Y",
                            );
                            productDynamicList.insert(index, product11);
                          });
                        } else {
                          if (productDynamicList[index - 1].brandId != -1) {
                            setState(() {
                              _selectedRadioValue = "Y";
                              BrandModelforDB brand;
                              ProductListModel product11 = new ProductListModel(
                                  brandId: -1,
                                  brandPrice: new TextEditingController(),
                                  supplyDate: new TextEditingController(),
                                  supplyQty: new TextEditingController(),
                                  isExpanded: new ExpandableController(
                                      initialExpanded: true),
                                  brandModelForDB: brand,
                                  dealerName: new TextEditingController(),
                              awardLoyaltyPoint: "Y");
                              productDynamicList.insert(index, product11);
                            });
                          } else {
                            Get.dialog(CustomDialogs().errorDialog(
                                "Please enter product $index details !"));
                          }
                        }
                      },
                    )),
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
                onChanged: (String text) {
                  UpdatedValues.setSiteProgressStageStatus(text);
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
                readOnly: true,
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.text,
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Date of construction",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range_rounded,
                      size: 22,
                      color: ColorConstants.clearAllTextColor,
                    ),
                    onPressed: () async {
                      final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime.now().add(Duration(
                            days:
                                widget.viewSiteDataResponse.constructionDays)),
                      );

                      setState(() {
                        final DateFormat formatter = DateFormat("yyyy-MM-dd");
                        if (picked != null) {
                          final String formattedDate = formatter.format(picked);
                          _dateofConstruction.text = formattedDate;
                          UpdatedValues.setSiteProgressDateOfConstruction(
                              _dateofConstruction.text);
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
                      ? TextButton(
    style: TextButton.styleFrom(

    shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          backgroundColor: Colors.transparent,),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 10, top: 10),
                            child: Text(
                              "ADD NEXT STAGE",
                              style: TextStyle(
                                  color: HexColor("#1C99D4"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              addNextButtonDisable = !addNextButtonDisable;
                              UpdatedValues.setAddNextButtonDisable(
                                  addNextButtonDisable);
                            });
                          },
                        )
                      : TextButton(
    style: TextButton.styleFrom(
    shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          backgroundColor: Colors.transparent,),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 10, top: 10),
                            child: Text(
                              "HIDE NEXT STAGE",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              addNextButtonDisable = !addNextButtonDisable;
                              UpdatedValues.setAddNextButtonDisable(
                                  addNextButtonDisable);
                            });
                          },
                        ),
                ),
              ),

              ///Add Next Stage Container

              addNextButtonDisable ? addNextStageContainer() : Container(),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                maxLines: 4,
                maxLength: 500,
                controller: _comments,
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  UpdatedValues.setSiteCommentsEntity(_comments.text);
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
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
                                      .creatorName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
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
                                  formatter.format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          siteCommentsEntity[
                                                  siteCommentsEntity.length - 1]
                                              .createdOn)),
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
                child: TextButton(
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
                                fontSize: 17),
                          )
                        : Text(
                            "VIEW LESS COMMENT (" +
                                siteCommentsEntity.length.toString() +
                                ")",
                            style: TextStyle(
                                color: HexColor("##F9A61A"),
                                fontWeight: FontWeight.bold,
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
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#1C99D4"),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 5, bottom: 10, top: 10),
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
                      UpdatedValues updateRequest = new UpdatedValues();
                      updateRequest.updateRequest(context);
                    }

                  }
                ),
              ),
              SizedBox(height: 40),
            ]),
      )))
    ]);
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

          onChanged: (value) {
            setState(() {
              _selectedConstructionTypeVisitNextStage = value;
              siteFloorsEntityNewNextStage = new List.empty(growable: true);
              _selectedSiteVisitFloorNextStage = null;
              if (_selectedConstructionTypeVisitNextStage.id == 1 ||
                  _selectedConstructionTypeVisitNextStage.id == 2 ||
                  _selectedConstructionTypeVisitNextStage.id == 3) {
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
              UpdatedValues.setConstructionTypeVisitNextStage(
                  _selectedConstructionTypeVisitNextStage);
            });
          },
          decoration: FormFieldStyle.buildInputDecoration(
              labelText: "Stage of Construction"),
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
          onChanged: (value) {
            setState(() {
              _selectedSiteVisitFloorNextStage = value;
              UpdatedValues.setSiteFloorsEntityNextStage(
                  _selectedSiteVisitFloorNextStage);
            });
          },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstants.backgroundColorBlue,
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
              return 'Please enter Site Stage Potential ';
            }

            return null;
          },
          onChanged: (String data) {
            UpdatedValues.setStagePotentialVisitNextStage(data);
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
            siteProductEntityfromLoaclDBNextStage = new List.empty(growable: true);
            _siteProductFromLocalDBNextStage = null;
            List<BrandModelforDB> _siteProductEntityfromLoaclDB =
                await db.fetchAllDistinctProduct(value.brandName);
            setState(() {
              _siteBrandFromLocalDBNextStage = value;
              siteProductEntityfromLoaclDBNextStage =
                  _siteProductEntityfromLoaclDB;

              UpdatedValues.setSiteBrandFromLocalDBNextStage(
                  _siteBrandFromLocalDBNextStage);
              UpdatedValues.setSiteProductEntityFromLocalDBNextStage(
                  siteProductEntityfromLoaclDBNextStage);
              if (_siteBrandFromLocalDBNextStage.brandName.toLowerCase() ==
                  "dalmia") {
                _stageStatusNextStage.text = "WON";
              } else {
                _stageStatusNextStage.text = "LOST";
              }
              UpdatedValues.setStageStatusNextStage(_stageStatusNextStage.text);
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
          onChanged: (String data) {
            UpdatedValues.setBrandPriceVisitNextStage(data);
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

          onChanged: (value) {
            setState(() {
              _siteProductFromLocalDBNextStage = value;
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
                  readOnly: true,
                  onChanged: (data) {

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
                        final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now(),
                        );

                        setState(() {
                          final DateFormat formatter = DateFormat("yyyy-MM-dd");
                          if (picked != null) {
                            final String formattedDate =
                                formatter.format(picked);
                            _dateOfBagSuppliedNextStage.text = formattedDate;
                            UpdatedValues.setDateOfBagSuppliedNextStage(
                                _dateOfBagSuppliedNextStage.text);
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
                  onChanged: (String v) {
                    UpdatedValues.setSiteCurrentTotalBagsNextStage(v);
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
          decoration:
              FormFieldStyle.buildInputDecoration(labelText: "Stage Status"),
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
          readOnly: true,
          onChanged: (data) {
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
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101));

                setState(() {
                  final DateFormat formatter = DateFormat("yyyy-MM-dd");
                  if (picked != null) {
                    final String formattedDate = formatter.format(picked);
                    _dateofConstructionNextStage.text = formattedDate;
                    UpdatedValues.setDateOfConstructionNextStage(
                        _dateofConstructionNextStage.text);
                  }
                });
              },
            ),
          ),
        ),
      ],
    ));
  }

  String calculateStagePotential(
      double siteTotalSitePotential,
      List<SiteStagePotentialEntity> siteStagePotentialEntity,
      int selectedConstructionStageId,
      int selectedFloorId) {
    String stagePt = "";
    if ((siteTotalSitePotential != null || !siteTotalSitePotential.isBlank) &&
        (selectedConstructionStageId != null ||
            !selectedConstructionStageId.isBlank) &&
        (selectedFloorId != null || !selectedFloorId.isBlank)) {
      SiteStagePotentialEntity siteStagePotentialEntity1 =
          siteStagePotentialEntity.firstWhere(
              (item) =>
                  (item.constructionStageId == selectedConstructionStageId &&
                      item.nosFloors == selectedFloorId),
              orElse: () => null);

      if (siteStagePotentialEntity1 != null) {
        double potentialPercentage =
            siteStagePotentialEntity1.potentialPercentage;
        stagePt = ((((siteTotalSitePotential * 20) * potentialPercentage) / 100)
                .round())
            .toString();
        UpdatedValues.setSiteProgressStagePotential(stagePt);
        UpdatedValues.setSiteProgressStagePotentialAuto(stagePt);
      }
    }
    return stagePt;
  }

  updateSiteSupplyHistory() {
    List<SiteSupplyHistorys> siteSupplyHistory = new List.empty(growable: true);
    if (productDynamicList != null && productDynamicList.length > 0) {
      for (int i = 0; i < productDynamicList.length; i++) {
        if (productDynamicList[i].brandId != -1) {
          siteSupplyHistory.add(new SiteSupplyHistorys(
              brandId: productDynamicList[i].brandId,
              brandPrice: productDynamicList[i].brandPrice.text,
              siteId: UpdatedValues.getSiteId(),
              supplyDate: productDynamicList[i].supplyDate.text,
              supplyQty: productDynamicList[i].supplyQty.text,
              createdBy: UpdatedValues.getEmpCode(),
              // soldToParty: visitDataDealer,
              // shipToParty: visitDataSubDealer,
              soldToParty: "",
              shipToParty: visitDataDealer,
              receiptNumber: "",
              isAuthorised: "N",
              authorisedBy: "",
              authorisedOn: "",
              awardLoyaltyPoint: productDynamicList[i].awardLoyaltyPoint));
        }
      }
    }
    UpdatedValues.setProductDynamicList(productDynamicList);
    UpdatedValues.updateSiteSupplyHistory(siteSupplyHistory);
  }
}
