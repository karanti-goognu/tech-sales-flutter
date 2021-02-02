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
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/UpdateDataRequest.dart' as updateResponse;



class VisitDataView extends StatefulWidget {
  final siteId;
  VisitDataView({this.siteId});
  @override
  _VisitDataViewState createState() => _VisitDataViewState();
}

class _VisitDataViewState extends State<VisitDataView> {
  final db = BrandNameDBHelper();
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
  BrandModelforDB _siteBrandFromLocalDB;

  BrandModelforDB _siteBrandFromLocalDBNextStage;

  BrandModelforDB _siteProductFromLocalDB;

  BrandModelforDB _siteProductFromLocalDBNextStage;

  List<DropdownMenuItem<String>> productSoldVisitSite = new List();

  var _siteBuiltupArea = new TextEditingController();
  var _siteProductDemo = new TextEditingController();
  var _siteProductOralBriefing = new TextEditingController();
  var _stagePotentialVisit = new TextEditingController();
  var _stagePotentialVisitNextStage = new TextEditingController();
  var _brandPriceVisit = new TextEditingController();
  var _brandPriceVisitNextStage = new TextEditingController();
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
  var _siteTotalPt = new TextEditingController();
  var _siteTotalBalanceBags = new TextEditingController();
  var _siteTotalBalancePt = new TextEditingController();
  var _ownerName = new TextEditingController();
  var _contactNumber = new TextEditingController();
  var _stageStatus = new TextEditingController();
  var _stageStatusNextStage = new TextEditingController();

  var _rera = new TextEditingController();
  var _plotNumber = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition = new Position();
  int _initialIndex = 0;
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
  SiteController _siteController = Get.find();
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
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
                                  decoration: FormFieldStyle.buildInputDecoration(labelText: "Bags",),
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
                                  decoration: FormFieldStyle.buildInputDecoration(labelText: "MT",),
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
                            setState(() {
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Type of Construction",),
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Floor",),
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Stage Potential",),
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
                            siteProductEntityfromLoaclDB = new List();
                            _siteProductFromLocalDB = null;
                            List<BrandModelforDB> _siteProductEntityfromLoaclDB =
                            await db.fetchAllDistinctProduct(value.brandName);
                            setState(() {
                              _siteBrandFromLocalDB = value;

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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Brand In Use",),
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
                              setState(() {
                                _siteProductFromLocalDB = value;
                                print(_siteProductFromLocalDB.id);
                              });
                            },
                            decoration: FormFieldStyle.buildInputDecoration(labelText: "Product Sold")
                          // InputDecoration(
                          //   focusedBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(
                          //         color: ColorConstants.backgroundColorBlue,
                          //         //color: HexColor("#0000001F"),
                          //         width: 1.0),
                          //   ),
                          //   enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.black26, width: 1.0),
                          //   ),
                          //   errorBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.red, width: 1.0),
                          //   ),
                          //   labelText: "Product Sold",
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
                          keyboardType: TextInputType.number,
                          decoration:  FormFieldStyle.buildInputDecoration(
                              labelText: "Brand Price"),
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
                        SizedBox(height: 16),
                        DropdownButtonFormField(
                          validator: (value) => value == null
                              ? 'Please select Dealer'
                              : null,
                          // icon: Icon(Icons.arrow_drop_down, size: 2,),
                          onChanged: (value) {
                            print(value);
                            // print();
                          },
                          items:
                          [
                            'IHB',
                            'Dealer',
                            'SUBDEALER',
                            'SALESOFFICER'
                          ]
                              .map((e) => DropdownMenuItem(
                            child: Text(
                              e.toUpperCase(),
                            ),
                            value: e,
                          ))
                              .toList(),
                          // viewSiteDataResponse.counterListModel.map((e) => e.soldToPartyName).toSet().toList().map((e) =>
                          //     DropdownMenuItem(
                          //       child: Text(e),
                          //       value: e,
                          //     )).toList(),
                          style: FormFieldStyle.formFieldTextStyle,
                          decoration:
                          FormFieldStyle.buildInputDecoration(
                              labelText: "Dealer"),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField(
                          validator: (value) => value == null
                              ? 'Please select Sub-Dealer'
                              : null,
                          onChanged: (value) {

                          },
                          items: [
                            'IHB',
                            'Dealer',
                            'SUBDEALER',
                            'SALESOFFICER'
                          ]
                              .map((e) => DropdownMenuItem(
                            child: Text(
                              e.toUpperCase(),
                            ),
                            value: e,
                          ))
                              .toList(),
                          style: FormFieldStyle.formFieldTextStyle,
                          decoration:
                          FormFieldStyle.buildInputDecoration(
                              labelText: "Sub-Dealer"),
                        ),
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
                                  decoration: FormFieldStyle.buildInputDecoration(labelText: "No. Of Bags",),
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
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Stage Status",),
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
                          onChanged: (value) {
                            setState(() {
                              labelProbabilityText = value.siteProbabilityStatus;
                              labelProbabilityId = value.id;
                              _siteProbabilityWinningEntity = value;
                            });
                          },
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Probability of winning",),
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
                            setState(() {
                              _siteCompetitionStatusEntity = value;
                            });
                          },
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Competition Status",),
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
                          onChanged: (value) {
                            setState(() {
                              _siteOpportunitStatusEnity = value;
                            });
                          },
                          decoration: FormFieldStyle.buildInputDecoration(labelText: "Opportunity Status",),
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
              decoration: FormFieldStyle.buildInputDecoration(labelText: "Type of Construction"),
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

              // hint: Text('Rating'),
              onChanged: (value) async {
                siteProductEntityfromLoaclDBNextStage = new List();
                _siteProductFromLocalDBNextStage = null;
                List<BrandModelforDB> _siteProductEntityfromLoaclDB =
                await db.fetchAllDistinctProduct(value.brandName);
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
              decoration: FormFieldStyle.buildInputDecoration(labelText: "Brand in use"),
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
              decoration: FormFieldStyle.buildInputDecoration(labelText: "Brand Price",),
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
              decoration: FormFieldStyle.buildInputDecoration(labelText: "Product Sold",),
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
                      decoration: FormFieldStyle.buildInputDecoration(labelText: "No. Of Bags"),
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
              decoration: FormFieldStyle.buildInputDecoration(labelText: "Stage Status"),
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
}
