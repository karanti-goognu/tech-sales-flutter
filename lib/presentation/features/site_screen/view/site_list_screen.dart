import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen_new.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/check_internet.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_simmer_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SiteListScreen extends StatefulWidget {
  @override
  _SiteListScreenState createState() => _SiteListScreenState();
}

class _SiteListScreenState extends State<SiteListScreen> {
  // String formatter = new DateFormat("yyyy-mm-dd");
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
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
      _siteController.offset += 10;
      //_siteController.getAccessKey(RequestIds.GET_SITES_LIST);

      _appController.getAccessKey(RequestIds.GET_SITES_LIST);
      // _siteController.getSitesData(this._appController.accessKeyResponse.accessKey);
      // _siteController.getAccessKey(RequestIds.GET_LEADS_LIST);
    }
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await CheckInternet.hasConnection();
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

  _getRequests() async {
    _siteController.sitesListResponse.sitesEntity = null;
    _siteController.offset = 0;
    // _appController.getAccessKey(RequestIds.GET_SITES_LIST);
    await _siteController.getAccessKey().then((value) async {
      await _siteController.getSitesData(value.accessKey, "");
    });
    // _siteController.offset = 0;
  }

  @override
  void initState() {
    super.initState();
    _siteController.sitesListResponse.sitesEntity = null;
    _siteController.offset = 0;
    // clearFilterSelection();
    internetChecking().then((result) => {
          if (result == true)
            {
              // _appController.getAccessKey(RequestIds.GET_SITES_LIST),
              _siteController.getAccessKey().then((value) async {
                _siteController.getSitesData(value.accessKey, "");
              }),
              //_siteController.getAccessKey(RequestIds.GET_SITES_LIST),

              // _siteController.offset = 0,
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
    //_siteController.selectedSiteDistrict = StringConstants.empty;
  }

  @override
  void dispose() {
    super.dispose();
    //_appController?.dispose();
    // _siteController?.dispose();
    // _siteController.offset = 0;
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
                      top: 10.0, left: 15.0, bottom: 5, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          // "Total Count : ${(_siteController.sitesListResponse.sitesEntity == null) ? 0 : _siteController.sitesListResponse.sitesEntity.length}",
                          "Total Count : ${(_siteController.sitesListResponse.totalSiteCount == null) ? 0 : _siteController.sitesListResponse.totalSiteCount}",

                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ),
                      ),
                      Obx(() => Text(
                            "Total Potential : ${(_siteController.sitesListResponse.totalSitePotential == null) ? 0 : double.parse(_siteController.sitesListResponse.totalSitePotential).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontFamily: "Muli",
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                              // color: HexColor("#FFFFFF99"),
                            ),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
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
            : (_siteController.sitesListResponse.respCode == "ST2036")
                ? Container(
                    child: Center(
                      child: Text("No Sites records available!!"),
                    ),
                  )
                : (_siteController.sitesListResponse.sitesEntity == null)
                    ? Container(
                        child: simmerWidget(),
                      )
                    : (_siteController.sitesListResponse.sitesEntity.length ==
                            0)
                        ? Container(
                            child: Center(
                              child: Text("No Sites records available!!"),
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
                                              ViewSiteScreenNew(
                                                siteId: _siteController
                                                    .sitesListResponse
                                                    .sitesEntity[index]
                                                    .siteId,
                                                tabIndex: 0,
                                              ))).then((_) => {_getRequests()});
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
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Obx(
                                                          () => Text(
                                                            "Site ID (${_siteController.sitesListResponse.sitesEntity[index].siteId})",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                        )),
                                                    // Padding(
                                                    //     padding:
                                                    //     const EdgeInsets
                                                    //         .all(2.0),
                                                    //     child: Obx(
                                                    //           () => Text(
                                                    //         "${_siteController.sitesListResponse.sitesEntity[index].contactName}" ?? "" ,
                                                    //         style: TextStyle(
                                                    //             fontSize: 18,
                                                    //             fontFamily:
                                                    //             "Muli",
                                                    //             fontWeight:
                                                    //             FontWeight
                                                    //                 .bold
                                                    //           //fontWeight: FontWeight.normal
                                                    //         ),
                                                    //       ),
                                                    //     )),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Obx(
                                                          () => Text(
                                                            "District: ${_siteController.sitesListResponse.sitesEntity[index].siteDistrict} ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                        )),
                                                    FittedBox(
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1.0),
                                                            child: Chip(
                                                              shape: StadiumBorder(
                                                                  side: BorderSide(
                                                                      color: HexColor(
                                                                          "#39B54A"))),
                                                              backgroundColor:
                                                                  HexColor(
                                                                          "#39B54A")
                                                                      .withOpacity(
                                                                          0.1),
                                                              label: Text(
                                                                (printSiteStage(_siteController.sitesListResponse.sitesEntity[index].siteStageId)),
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        "#39B54A"),
                                                                    fontSize:
                                                                        11,
                                                                    fontFamily:
                                                                        "Muli",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold
                                                                    //fontWeight: FontWeight.normal
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              " ${_siteController.sitesListResponse.sitesEntity[index].siteCreationDate}",
                                                              //  textAlign: TextAlign.start,
                                                              style: TextStyle(
                                                                fontSize: 9,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,

                                                                //fontWeight: FontWeight.normal
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0, bottom: 10),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(),
                                                          ),
                                                          Text(
                                                            "Site-Pt: ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontSize: SizeConfig
                                                                        .safeBlockHorizontal *
                                                                    .2,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                          Text(
                                                            "${_siteController.sitesListResponse.sitesEntity[index].sitePotentialMt}MT",
                                                            style: TextStyle(
                                                                // color: Colors.black38,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      (_siteController
                                                                  .sitesListResponse
                                                                  .sitesEntity[
                                                                      index]
                                                                  .siteOppertunityId ==
                                                              null)
                                                          ? ""
                                                          : printOpportuityStatus(
                                                              _siteController
                                                                  .sitesListResponse
                                                                  .sitesEntity[
                                                                      index]
                                                                  .siteOppertunityId),
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 10,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.bold
                                                          //fontWeight: FontWeight.normal
                                                          ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      "Site Score - ${_siteController.sitesListResponse.sitesEntity[index].siteScore}",
                                                      style: TextStyles
                                                          .robotoRegular14,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
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
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(),
                                                        ),
                                                        Icon(
                                                          Icons.call,
                                                          color: HexColor(
                                                              "#8DC63F"),
                                                        ),
                                                        GestureDetector(
                                                          child: Text(
                                                            "Call Contact",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                          onTap: () {
                                                            String num = _siteController
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
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 4, 8, 0),
                                          child: Container(
                                            color: Colors.grey,
                                            width: double.infinity,
                                            height: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              /*Text(
                                            "Exclusive Dalmia ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12,
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.bold
                                                //fontWeight: FontWeight.normal
                                                ),
                                          ),*/
                                              Text(
                                                (_siteController
                                                            .sitesListResponse
                                                            .sitesEntity[index]
                                                            .siteProbabilityWinningId ==
                                                        null)
                                                    ? ""
                                                    : printProbabilityOfWinning(
                                                        _siteController
                                                            .sitesListResponse
                                                            .sitesEntity[index]
                                                            .siteProbabilityWinningId),
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.bold
                                                    //fontWeight: FontWeight.normal
                                                    ),
                                              ),
                                            ],
                                          ),
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

  String printOpportuityStatus(int value) {
    List<SiteOpportuityStatus> data = List<SiteOpportuityStatus>.from(
        _splashController.splashDataModel.siteOpportunityStatusRepository
            .where((i) => i.id == value));
    if (data.length >= 1) {
      return "${data[0].opportunityStatus}";
    } else {
      return "";
    }
  }

  String printProbabilityOfWinning(int value) {
    List<SiteProbabilityWinningEntity> data =
        List<SiteProbabilityWinningEntity>.from(_splashController
            .splashDataModel.siteProbabilityWinningEntity
            .where((i) => i.id == value));
    if (data.length >= 1) {
      return "${data[0].siteProbabilityStatus}";
    } else {
      return "";
    }
  }

  String printSiteStage(int value) {
    if (_splashController.splashDataModel.siteStageEntity != null) {
      List<SiteStageEntity> data = List<SiteStageEntity>.from(_splashController
          .splashDataModel.siteStageEntity
          .where((i) => i.id == value));
      if (data.length >= 1) {
        return "${data[0].siteStageDesc}";
      } else {
        return "";
      }
    }
    return "";
  }

  Widget simmerWidget() {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CustomSimmerWidget.rectangular(
                                    height: 12,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  )),
                              SizedBox(
                                height: 2,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CustomSimmerWidget.rectangular(
                                    height: 12,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  )),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: CustomSimmerWidget.circular(
                                          height: 54, width: 54),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: CustomSimmerWidget.rectangular(
                                        height: 12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    CustomSimmerWidget.rectangular(
                                      height: 12,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    CustomSimmerWidget.rectangular(
                                      height: 12,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              CustomSimmerWidget.rectangular(
                                height: 12,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              CustomSimmerWidget.rectangular(
                                height: 12,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              CustomSimmerWidget.rectangular(
                                height: 12,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  CustomSimmerWidget.rectangular(
                                    height: 12,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSimmerWidget.rectangular(
                          height: 12,
                          width: MediaQuery.of(context).size.width * 0.3,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
