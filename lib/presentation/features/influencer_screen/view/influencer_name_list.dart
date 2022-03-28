

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen_new.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
class InfluencerNameList extends StatefulWidget {
  String? influencerName;
  String? influencerID;
  InfluencerNameList({this.influencerID, this.influencerName});

  @override
  _InfluencerNameListState createState() => _InfluencerNameListState();

}


PersistentBottomSheetController? controller;

class _InfluencerNameListState extends State<InfluencerNameList> {
  SiteController _siteController = Get.find();
  SplashController _splashController = Get.find();

  
  
  ScrollController? _scrollController;

  getData() async {
    Future.delayed(Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    await _siteController.getAccessKey().then((value) async {
      await _siteController.getSitesData(context, value.accessKey, widget.influencerID);
    });
  }

  @override
  void initState() {
    super.initState();
    _siteController.sitesListResponse.sitesEntity = null;
    internetChecking().then((result) async {
      if (result)
      getData().whenComplete(() {
        Get.back();

      });
      _siteController.offset = 0;
    });

    _scrollController = ScrollController();
    _scrollController?..addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController!.position.pixels ==
        _scrollController!.position.maxScrollExtent) {
      _siteController.offset += 10;
      // _siteController.getAccessKey().then((value) async {
      //   _siteController.getSitesData(value.accessKey,widget.influencerID);
      // });
      // getData();
      getData().whenComplete(() {
        Get.back();
      });
      // _siteController.getSitesData(_siteController.accessKeyResponse.accessKey,widget.influencerID);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _siteController.dispose();
    _siteController.offset = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColorGrey,
          appBar: AppBar(
            backgroundColor: ColorConstants.appBarColor,
            toolbarHeight: SizeConfig.screenHeight!*.14,
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.influencerName}".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: "Muli"),
                    ),
                  ],
                ),

              ],
            ),
            automaticallyImplyLeading: false,
          ),
          floatingActionButton:
          SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigator(),
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10.0, bottom: 5, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                            () => (_siteController.sitesListResponse.sitesEntity != null)?Text(
                          "Total Count : ${(_siteController.sitesListResponse.totalSiteCount == null) ? 0 : _siteController.sitesListResponse.totalSiteCount}",
                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ):SizedBox(),
                      ),
                      Obx(() => (_siteController.sitesListResponse.sitesEntity != null)?Text(
                        "Total Potential : ${(_siteController.sitesListResponse.totalSitePotential == null) ? 0 : _siteController.sitesListResponse.totalSitePotential}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                          // color: HexColor("#FFFFFF99"),
                        ),
                      ):SizedBox()),
                    ],
                  ),
                ),
                Expanded(child: leadsDetailWidget()),
                Container(
                  height: 70,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ));
  }

  Widget leadsDetailWidget() {
    return Obx(
          () => (_siteController.sitesListResponse == null)
          ? Container(
        child: Center(
          child: Text("Site list response  is empty!!"),
        ),
      )
          : (_siteController.sitesListResponse.sitesEntity == null)
          ? Container(
        child: Center(
          child: Text("Loading Site list ..."),
        ),
      )
          : (_siteController
          .sitesListResponse.sitesEntity.length ==
          0)
          ? Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You don't have any site..!!"),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorConstants.buttonNormalColor,
                ),
                onPressed: () {
                  _siteController.offset = 0;
                  getData().whenComplete(() {
                    Get.back();
                  });
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
          itemCount: _siteController
              .sitesListResponse.sitesEntity.length,
          padding: const EdgeInsets.only(
              left: 6.0, right: 6, bottom: 50,top:5),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

                Navigator.push(
                    context, new CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        ViewSiteScreenNew(siteId: _siteController.sitesListResponse.sitesEntity[index].siteId,tabIndex: 0,))
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                borderOnForeground: true,
                elevation: 6,
                margin: EdgeInsets.all(4.0),
                color: Colors.white,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: const EdgeInsets.only(top: 2.0,left: 7),
                            child:  Text(
                              "",
                              style: TextStyle(
                                  color:
                                  Colors.black38,
                                  fontSize: 14,
                                  fontFamily: "Muli",
                                  fontWeight:
                                  FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 5.0,right: 7),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "Site-Pt: ",
                                    style: TextStyle(
                                        color: Colors
                                            .black38,
                                        fontSize: 14,
                                        fontFamily:
                                        "Muli",
                                        fontWeight:
                                        FontWeight
                                            .bold
                                    ),
                                  ),
                                  Obx(
                                        () => Text(
                                      "${_siteController.sitesListResponse.sitesEntity[index].sitePotentialMt}MT",
                                      style: TextStyle(
                                          fontSize: SizeConfig
                                              .safeBlockHorizontal *
                                              3.7,
                                          fontFamily:
                                          "Muli",
                                          fontWeight:
                                          FontWeight
                                              .bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding:
                              const EdgeInsets.only(top:
                                  2.0,left: 7),
                              child: Obx(
                                    () => Text(
                                  "Site ID (${_siteController.sitesListResponse.sitesEntity[index].siteId})",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Muli",
                                      fontWeight:
                                      FontWeight.bold
                                  ),
                                ),
                              )),
                          Padding(padding: const EdgeInsets.only(top: 2.0,right: 7),
                            child: Text( (_siteController.sitesListResponse.sitesEntity[index]
                                .siteOppertunityId ==
                                null)
                                ? ""
                                : printOpportunityStatus(
                                _siteController.sitesListResponse.sitesEntity[index]
                                    .siteOppertunityId),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 9,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal
                                //fontWeight: FontWeight.normal
                              )
                          ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding:
                              const EdgeInsets.only(top:
                                  5.0,left: 7),
                              child: Obx(
                                    () => Text(
                                  "District: ${_siteController.sitesListResponse.sitesEntity[index].siteDistrict}",
                                  style: TextStyle(
                                      color:
                                      Colors.black38,
                                      fontSize: 14,
                                      fontFamily: "Muli",
                                      fontWeight:
                                      FontWeight.bold
                                    //fontWeight: FontWeight.normal
                                  ),
                                ),
                              )),
                          Padding(padding: const EdgeInsets.only(top: 2.0,right: 7),
                            child:
                          Text(
                              "${toBeginningOfSentenceCase(_siteController.sitesListResponse.sitesEntity[index].contactName)}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal
                              )
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: const EdgeInsets.only(top: 10.0,left: 7),
                            child:
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 1.0),
                                child: Container(
                                  height: 25,
                                  child: Chip(
                                      labelPadding: EdgeInsets.only(left: 5,right: 5,top: -4),
                                      shape: StadiumBorder(
                                      side: BorderSide(
                                          color: HexColor(
                                              "#39B54A"))),
                                      backgroundColor:
                                      HexColor("#39B54A")
                                          .withOpacity(
                                          0.1),
                                      label: Obx(
                                              () =>Text(printSiteStage(
                                                  _siteController.sitesListResponse.sitesEntity[index]
                                                      .siteStageId),
                                            style: TextStyle(
                                                color: HexColor(
                                                    "#39B54A"),
                                                fontSize: SizeConfig
                                                    .safeBlockHorizontal *
                                                    2.2,
                                                fontFamily:
                                                "Muli",
                                                fontWeight:
                                                FontWeight
                                                    .bold
                                            ),
                                          ))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig
                                        .safeBlockHorizontal *
                                        1.3),
                                child: Text(
                                  " ${_siteController.sitesListResponse.sitesEntity[index].siteCreationDate}",
                                  style: TextStyle(
                                    fontSize: SizeConfig
                                        .safeBlockHorizontal *
                                        2.8,
                                    fontFamily: "Muli",
                                    fontWeight:
                                    FontWeight.bold,

                                  ),
                                ),
                              ),
                            ],
                          )),
                          Padding(padding: const EdgeInsets.only(top: 2.0,right: 7),
                            child:
                          GestureDetector(
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: HexColor(
                                        "#8DC63F"),
                                  ),
                                  Text(
                                    " Call Contact",
                                    style: TextStyle(
                                        color: Colors
                                            .black,
                                        fontSize:16,
                                        fontFamily:
                                        "Muli",
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                        fontStyle:
                                        FontStyle
                                            .normal
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              String? num =
                                  _siteController
                                      .sitesListResponse
                                      .sitesEntity[
                                  index]
                                      .contactNumber;
                              launch('tel:$num');
                            },
                          ))
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(8, 10, 0, 0),
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
                            Text(" ".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 14,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(children: [
                              Text( (_siteController.sitesListResponse.sitesEntity[index]
                                  .siteProbabilityWinningId ==
                                  null)
                                  ? ""
                                  : printProbabilityOfWinning(
                                  _siteController.sitesListResponse.sitesEntity[index]
                                      .siteProbabilityWinningId), style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.bold
                            ),),
                            ],)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }


  String printSiteStage(int? value) {
    List<SiteStageEntity> data = List<SiteStageEntity>.from(_splashController
        .splashDataModel.siteStageEntity
        .where((i) => i.id == value));
    if (data.length >= 1) {
      return "${data[0].siteStageDesc}";
    } else {
      return "";
    }
  }

  String printOpportunityStatus(int? value) {
    List<SiteOpportuityStatus> data = List<SiteOpportuityStatus>.from(
        _splashController.splashDataModel.siteOpportunityStatusRepository
            .where((i) => i.id == value));
    if (data.length >= 1) {
      return "${data[0].opportunityStatus}";
    } else {
      return "";
    }
  }

  String printProbabilityOfWinning(int? value) {
    List<SiteProbabilityWinningEntity> data = List<SiteProbabilityWinningEntity>.from(_splashController
        .splashDataModel.siteProbabilityWinningEntity
        .where((i) => i.id == value));
    if (data.length >= 1) {
      return "${data[0].siteProbabilityStatus}";
    } else {
      return "";
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }
}
