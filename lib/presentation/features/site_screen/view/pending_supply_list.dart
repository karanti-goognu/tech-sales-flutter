

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/Pending.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/pending_supply_detail.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
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
  SplashController _splashController = Get.find();

  ScrollController? _scrollController;

  _scrollListener() {
    if (_scrollController!.position.pixels ==
        _scrollController!.position.maxScrollExtent) {
      _siteController.offset += 10;
      _siteController.pendingSupplyList();
    }
  }

  PendingSupplyDataResponse? pendingSupplyDataResponse;

  getPendingSupplyData() async {
    var data = await _siteController.pendingSupplyList();
    setState(() {
      pendingSupplyDataResponse = data;
    });
  }

  @override
  void initState() {
    super.initState();
    clearFilterSelection();
    internetChecking().then((result) => {
          if (result == true)
            {
              getPendingSupplyData(),
              _siteController.offset = 0,
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

    // _scrollController = ScrollController();
    // _scrollController..addListener(_scrollListener);
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
    // _siteController?.dispose();
    // _siteController.offset = 0;
  }

  void disposeController(BuildContext context) {
    _siteController.dispose();
    _siteController.offset = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
          // disposeController(context);
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColorGrey,
          body: pendingSupplyDataResponse != null
              ? Container(
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
                          padding:
                              EdgeInsets.only(left: 0.0, right: 0.0, bottom: 5),
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: HexColor("#39B54A")),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
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
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: HexColor("#F9A61A")),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
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
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10)),
                                Obx(
                                  () => Text(
                                    // "Total Count : ${(_siteController.sitesListResponse.sitesEntity == null) ? 0 : _siteController.sitesListResponse.sitesEntity.length}",
                                    "Count- ${(_siteController.pendingSupplyListResponse.pendingSupplyListCount == null || _siteController.pendingSupplyListResponse.pendingSupplyListCount == 0) ? 0 : _siteController.pendingSupplyListResponse.pendingSupplyListCount}",

                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.0,
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
                )
              : Container(
                  child: Center(
                    child: Text("Sites list is empty!!"),
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
        : (_siteController.pendingSupplyListResponse == null)
            ? Container(
                child: Center(
                  child: Text("Supply list response  is empty!!"),
                ),
              )
            : (_siteController.pendingSupplyListResponse.pendingSuppliesModel ==
                    null)
                ? Container(
                    child: Center(
                      child: Text("Pending Supply list is empty!!"),
                    ),
                  )
                : (_siteController.pendingSupplyListResponse
                            .pendingSuppliesModel.length ==
                        0)
                    ? Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("You don't have any Supply..!!"),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorConstants.buttonNormalColor,
                                ),
                                onPressed: () {
                                  getPendingSupplyData();
                                },
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
                        itemCount: _siteController.pendingSupplyListResponse
                            .pendingSuppliesModel.length,
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
                                                  .pendingSupplyListResponse
                                                  .pendingSuppliesModel[index]
                                                  .siteId,
                                              supplyHistoryId: _siteController
                                                  .pendingSupplyListResponse
                                                  .pendingSuppliesModel[index]
                                                  .siteSupplyHistoryId)));
                            },
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              borderOnForeground: true,
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
                                                "Date: ${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].requestDate}",
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontSize: 12,
                                                    fontFamily: "Muli",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(children: [
                                                Text(
                                                  "${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].productName}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ])
                                            ])),
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
                                                        "Site ID (${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].siteId})",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Obx(
                                                      () => Text(
                                                        "${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].siteOwnerName ?? ""}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Obx(
                                                      () => Text(
                                                        "District: ${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].siteDistrict} ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontSize: 12,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                    "${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].inflName != null ? toBeginningOfSentenceCase(_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].inflName) : ""}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal
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
                                                                    "${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].approvedQty != null ? _siteController.pendingSupplyListResponse.pendingSuppliesModel[index].approvedQty : ""}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold
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
                                                                    "${_siteController.pendingSupplyListResponse.pendingSuppliesModel[index].pendingQty != null ? _siteController.pendingSupplyListResponse.pendingSuppliesModel[index].pendingQty : ""}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold
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
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        String? num = _siteController
                                                            .pendingSupplyListResponse
                                                            .pendingSuppliesModel[
                                                                index]
                                                            .dealerContact;
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

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

  String printOpportunityStatus(int value) {
    List<SiteOpportuityStatus> data = List<SiteOpportuityStatus>.from(
        _splashController.splashDataModel.siteOpportunityStatusRepository
            .where((i) => i.id == value));
    if (data.length >= 1) {
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
