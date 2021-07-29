import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/pending_supply_detail.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_filter.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingSupplyListScreen extends StatefulWidget {
  @override
  _PendingSupplyListScreenState createState() =>
      _PendingSupplyListScreenState();
}

class _PendingSupplyListScreenState extends State<PendingSupplyListScreen> {
  SiteController _siteController = Get.find();
  AppController _appController = Get.find();
  SplashController _splashController = Get.find();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;
  int selectedPosition = 0;
  int currentTab = 0;

  ScrollController _scrollController;

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('hello');
      _siteController.offset += 10;
      print(_siteController.offset);
      //_siteController.getAccessKey(RequestIds.GET_SITES_LIST);

      _appController.getAccessKey(RequestIds.GET_SITES_LIST);
      // _siteController.getSitesData(this._appController.accessKeyResponse.accessKey);
      // _siteController.getAccessKey(RequestIds.GET_LEADS_LIST);
    }
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }

  storeOfflineSiteData() async {
    final db = SiteListDBHelper();
    await db.clearTable();
    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
    if (_siteController.sitesListResponse.sitesEntity != null) {
      for (int i = 0;
          i < _siteController.sitesListResponse.sitesEntity.length;
          i++) {
        SitesEntity siteEntity = new SitesEntity(
            siteId: _siteController.sitesListResponse.sitesEntity[i].siteId,
            leadId: _siteController.sitesListResponse.sitesEntity[i].leadId,
            siteDistrict:
                _siteController.sitesListResponse.sitesEntity[i].siteDistrict,
            siteStageId:
                _siteController.sitesListResponse.sitesEntity[i].siteStageId,
            siteCreationDate: _siteController
                .sitesListResponse.sitesEntity[i].siteCreationDate,
            sitePotentialMt: _siteController
                .sitesListResponse.sitesEntity[i].sitePotentialMt,
            siteOppertunityId: _siteController
                .sitesListResponse.sitesEntity[i].siteOppertunityId,
            siteScore:
                _siteController.sitesListResponse.sitesEntity[i].siteScore,
            contactNumber:
                _siteController.sitesListResponse.sitesEntity[i].contactNumber,
            siteProbabilityWinningId: _siteController
                .sitesListResponse.sitesEntity[i].siteProbabilityWinningId);
        // SiteListModelForDB siteListModelForDb = new SiteListModelForDB(null, json.encode(siteEntity));
        // await db.addSiteEntityInDraftList(siteListModelForDb);
        await db.insertSiteEntityInTable(siteEntity);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _siteController.sitesListResponse.sitesEntity = null;
    clearFilterSelection();
    internetChecking().then((result) => {
          if (result == true)
            {
              _appController.getAccessKey(RequestIds.GET_SITES_LIST),
              //_siteController.getAccessKey(RequestIds.GET_SITES_LIST),

              _siteController.offset = 0,
              // storeOfflineSiteData()
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
              // fetchSiteList()
            }
        });
    _scrollController = ScrollController();
    _scrollController..addListener(_scrollListener);
  }

  clearFilterSelection() {
    _siteController.selectedFilterCount = 0;
    _siteController.selectedSiteStage = StringConstants.empty;
    _siteController.selectedSiteStageValue = StringConstants.empty;
    _siteController.selectedSiteStatus = StringConstants.empty;
    _siteController.selectedSiteStatusValue = StringConstants.empty;
    _siteController.selectedSiteInfluencerCat = StringConstants.empty;
    _siteController.selectedSiteInfluencerCatValue = StringConstants.empty;
    _siteController.assignToDate = StringConstants.empty;
    _siteController.assignFromDate = StringConstants.empty;
    _siteController.selectedSitePincode = StringConstants.empty;
  }

  @override
  void dispose() {
    super.dispose();
    //_appController?.dispose();
    _siteController?.dispose();
    _siteController.offset = 0;
  }

  void disposeController(BuildContext context) {
//or what you wnat to dispose/clear
    _siteController?.dispose();
    _siteController.offset = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    print(selectedDateString); // something like 20-04-2020
    return WillPopScope(
        onWillPop: () async {
          // disposeController(context);
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColorGrey,
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, bottom: 5, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 5),
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor("#39B54A")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Approved Bags",
                                    style: TextStyle(
                                        fontFamily: "Muli",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                        // color: HexColor("#FFFFFF99"),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor("#F9A61A")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Pending Bags",
                                    style: TextStyle(
                                        fontFamily: "Muli",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                        // color: HexColor("#FFFFFF99"),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10)),
                          Obx(
                            () => Text(
                              // "Total Count : ${(_siteController.sitesListResponse.sitesEntity == null) ? 0 : _siteController.sitesListResponse.sitesEntity.length}",
                              "Count- ${(_siteController.sitesListResponse.totalSiteCount == null) ? 0 : _siteController.sitesListResponse.totalSiteCount}",

                              style: TextStyle(
                                fontFamily: "Muli",
                                fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                                // color: HexColor("#FFFFFF99"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      scrollDirection: Axis.horizontal,
                    )),
                Expanded(child: leadsDetailWidget()),
              ],
            ),
          ),
        ));
  }

  Widget leadsDetailWidget() {
    return Obx(() => (_siteController == null)
        ? Container(
            child: Center(
              child: Text("Sites controller  is empty!!"),
            ),
          )
        : (_siteController.sitesListResponse == null)
            ? Container(
                child: Center(
                  child: Text("Sites list response  is empty!!"),
                ),
              )
            : (_siteController.sitesListResponse.sitesEntity == null)
                ? Container(
                    child: Center(
                      child: Text("Sites list is empty!!"),
                    ),
                  )
                : (_siteController.sitesListResponse.sitesEntity.length == 0)
                    ? Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("You don't have any Sites..!!"),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  _appController
                                      .getAccessKey(RequestIds.GET_LEADS_LIST);
                                },
                                color: ColorConstants.buttonNormalColor,
                                child: Text(
                                  "TRY AGAIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _siteController
                            .sitesListResponse.sitesEntity.length,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, bottom: 10),
                        // itemExtent: 125.0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          PendingSupplyDetailScreen(
                                            siteId: _siteController
                                                .sitesListResponse
                                                .sitesEntity[index]
                                                .siteId,
                                            tabIndex: 0,
                                          )));
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              borderOnForeground: true,
                              //shadowColor: colornew,
                              elevation: 6,
                              margin: EdgeInsets.all(5.0),
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Date: 20-07-2021 ",
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 12,
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.bold
                                                  //fontWeight: FontWeight.normal
                                                  ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Site Potential: ",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          3.8,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //fontWeight: FontWeight.normal
                                                      ),
                                                ),
                                                Text(
                                                  "${_siteController.sitesListResponse.sitesEntity[index].sitePotentialMt}MT",
                                                  style: TextStyle(
                                                      // color: Colors.black38,
                                                      fontSize: 13,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //fontWeight: FontWeight.normal
                                                      ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Obx(
                                                      () => Text(
                                                        "Site ID (${_siteController.sitesListResponse.sitesEntity[index].siteId})",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Obx(
                                                      () => Text(
                                                        "District: ${_siteController.sitesListResponse.sitesEntity[index].siteDistrict} ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontSize: 12,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                    "${toBeginningOfSentenceCase(_siteController.sitesListResponse.sitesEntity[index].contactName)}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal
                                                        //fontWeight: FontWeight.normal
                                                        )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0.0, bottom: 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.0,
                                                        right: 0.0,
                                                        bottom: 8),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8),
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 4.0),
                                                                  child:
                                                                      Container(
                                                                    width: 10,
                                                                    height: 10,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: HexColor(
                                                                            "#39B54A")),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          3.0),
                                                                  child: Text(
                                                                    "140",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold
                                                                        // color: HexColor("#FFFFFF99"),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8),
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 4.0),
                                                                  child:
                                                                      Container(
                                                                    width: 10,
                                                                    height: 10,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: HexColor(
                                                                            "#F9A61A")),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          3.0),
                                                                  child: Text(
                                                                    "60",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold
                                                                        // color: HexColor("#FFFFFF99"),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                    )),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Icon(
                                                      Icons.call,
                                                      size: 20,
                                                      color:
                                                          HexColor("#8DC63F"),
                                                    ),
                                                    GestureDetector(
                                                      child: Text(
                                                        "Call Dealer",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FontStyle.normal
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        String num =
                                                            _siteController
                                                                .sitesListResponse
                                                                .sitesEntity[
                                                                    index]
                                                                .contactNumber;
                                                        launch('tel:$num');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SiteFilterWidget();
        });
    //     .whenComplete(() {
    //
    // });
  }

  Widget SiteFilter() {}

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

  String printOpportuityStatus(int value) {
    List<SiteOpportuityStatus> data = List<SiteOpportuityStatus>.from(
        _splashController.splashDataModel.siteOpportunityStatusRepository
            .where((i) => i.id == value));
    if (data.length >= 1) {
      print("size greater than 0 \n ${jsonEncode(data[0].opportunityStatus)}");
      return "${data[0].opportunityStatus}";
    } else {
      print("size is 0");
      return "";
    }
  }

  String printProbabilityOfWinning(int value) {
    List<SiteProbabilityWinningEntity> data =
        List<SiteProbabilityWinningEntity>.from(_splashController
            .splashDataModel.siteProbabilityWinningEntity
            .where((i) => i.id == value));
    if (data.length >= 1) {
      print(
          "size greater than 0 \n ${jsonEncode(data[0].siteProbabilityStatus)}");
      return "${data[0].siteProbabilityStatus}";
    } else {
      print("size is 0");
      return "";
    }
  }

  String printSiteStage(int value) {
    List<SiteStageEntity> data = List<SiteStageEntity>.from(_splashController
        .splashDataModel.siteStageEntity
        .where((i) => i.id == value));
    if (data.length >= 1) {
      print("size greater than 0 \n ${jsonEncode(data[0].siteStageDesc)}");
      return "${data[0].siteStageDesc}";
    } else {
      print("size is 0");
      return "";
    }
  }
}
