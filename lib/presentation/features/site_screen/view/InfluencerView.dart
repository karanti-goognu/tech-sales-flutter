import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfluencerView extends StatefulWidget {
  @override
  _InfluencerViewState createState() => _InfluencerViewState();
}

class _InfluencerViewState extends State<InfluencerView> {
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
  int initialInfluencerLength = 0;
  List<DropdownMenuItem<String>> productSoldVisitSite = new List();
  TextEditingController _comments = new TextEditingController();
  TextEditingController closureReasonText = new TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

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
  List<InfluencerDetail> _listInfluencerDetail = new List();
  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<SiteCommentsEntity> siteCommentsEntity = new List();

  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();

  @override
  Widget build(BuildContext context) {
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
                },
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        )),
      ),
    );
  }
}
