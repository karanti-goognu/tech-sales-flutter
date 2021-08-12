import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/widgets/leads_filter.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
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
  String influencerName;
  String influencerID;
  InfluencerNameList({this.influencerID, this.influencerName});

  @override
  _InfluencerNameListState createState() => _InfluencerNameListState();

}


PersistentBottomSheetController controller;

class _InfluencerNameListState extends State<InfluencerNameList> {
  SiteController _siteController = Get.find();
  SplashController _splashController = Get.find();

  
  
  ScrollController _scrollController;

  getData() async {
    Future.delayed(Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    await _siteController.getAccessKey().then((value) async {
      await _siteController.getSitesData(value.accessKey, widget.influencerID);
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
    _scrollController..addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('hello');
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
    _siteController?.dispose();
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
          resizeToAvoidBottomInset: false,
          //resizeToAvoidBottomInset: true,
          extendBody: true,
//          key: _leadScreenFormKey,
          backgroundColor: ColorConstants.backgroundColorGrey,
          appBar: AppBar(
            // titleSpacing: 50,
            // leading: new Container(),
            backgroundColor: ColorConstants.appBarColor,
            toolbarHeight: SizeConfig.screenHeight*.14,
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
                    // FlatButton(
                    //   onPressed: () {
                    //     // _settingModalBottomSheet(context);
                    //   },
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(18.0),
                    //       side: BorderSide(color: Colors.white)),
                    //   color: Colors.transparent,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(bottom: 5),
                    //     child: Row(
                    //       children: [
                    //         //  Icon(Icons.exposure_zero_outlined),
                    //         Container(
                    //             height: 18,
                    //             width: 18,
                    //             // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                    //             decoration: new BoxDecoration(
                    //               color: Colors.white,
                    //               border: Border.all(
                    //                   color: Colors.black, width: 0.0),
                    //               borderRadius:
                    //               new BorderRadius.all(Radius.circular(3)),
                    //             ),
                    //             child: Center(
                    //                 child: Obx(() => Text(
                    //                     "${_siteController.selectedFilterCount}",
                    //                     style: TextStyle(
                    //                         color: Colors.black,
                    //                         //fontFamily: 'Raleway',
                    //                         fontSize: 12,
                    //                         fontWeight: FontWeight.normal))))),
                    //         Padding(
                    //           padding: const EdgeInsets.only(left: 8.0),
                    //           child: Text(
                    //             'FILTER',
                    //             style: TextStyle(
                    //                 color: Colors.white, fontSize: 18),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                // SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         SizedBox(
                //           width: 8,
                //         ),
                //         Obx(() => (_siteController.assignToDate ==
                //             StringConstants.empty)
                //             ? Container()
                //             : FilterChip(
                //           label: Row(
                //             children: [
                //               Icon(
                //                 Icons.check,
                //                 color: Colors.black,
                //               ),
                //               SizedBox(
                //                 width: 4,
                //               ),
                //               Text(
                //                   "${_siteController.assignFromDate} to ${_siteController.assignToDate}")
                //             ],
                //           ),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide()),
                //           onSelected: (bool value) {
                //             print("selected");
                //           },
                //         )),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         Obx(() => (_siteController.selectedLeadStatus ==
                //             StringConstants.empty)
                //             ? Container()
                //             : FilterChip(
                //           label: Row(
                //             children: [
                //               Icon(
                //                 Icons.check,
                //                 color: Colors.black,
                //               ),
                //               SizedBox(
                //                 width: 4,
                //               ),
                //               Text(
                //                   "${_siteController.selectedLeadStatus}")
                //             ],
                //           ),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide()),
                //           onSelected: (bool value) {
                //             print("selected");
                //           },
                //         )),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         Obx(() => (_siteController.selectedLeadStage ==
                //             StringConstants.empty)
                //             ? Container()
                //             : FilterChip(
                //           label: Row(
                //             children: [
                //               Icon(
                //                 Icons.check,
                //                 color: Colors.black,
                //               ),
                //               SizedBox(
                //                 width: 4,
                //               ),
                //               Text(
                //                   "${_siteController.selectedLeadStage}")
                //             ],
                //           ),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide()),
                //           onSelected: (bool value) {
                //             print("selected");
                //           },
                //         )),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         Obx(() =>
                //         (_siteController.selectedLeadPotential ==
                //             StringConstants.empty)
                //             ? Container()
                //             : FilterChip(
                //           label: Row(
                //             children: [
                //               Icon(
                //                 Icons.check,
                //                 color: Colors.black,
                //               ),
                //               SizedBox(
                //                 width: 4,
                //               ),
                //               Text(
                //                   "${_siteController.selectedLeadPotential}")
                //             ],
                //           ),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide()),
                //           onSelected: (bool value) {
                //             print("selected");
                //           },
                //         )),
                //         SizedBox(
                //           width: 8,
                //         ),
                //       ],
                //     ))
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
                // Padding(
                //     padding:
                //     EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5),
                //     child:Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(right: 8),
                //             child: Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(top: 4.0),
                //                   child: Container(
                //                     width: 10,
                //                     height: 10,
                //                     decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: HexColor("#1C99D4")),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 3.0),
                //                   child: Text(
                //                     "Tele-Verified",
                //                     style: TextStyle(
                //                       fontFamily: "Muli",
                //                       fontSize: 14,
                //                       // color: HexColor("#FFFFFF99"),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(right: 8),
                //             child: Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(top: 4.0),
                //                   child: Container(
                //                     width: 10,
                //                     height: 10,
                //                     decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: HexColor("#39B54A")),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 3.0),
                //                   child: Text(
                //                     "Phy-Verified",
                //                     style: TextStyle(
                //                       fontFamily: "Muli",
                //                       fontSize: 14,
                //                       // color: HexColor("#FFFFFF99"),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),),
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
          () => (_siteController == null)
          ? Container(
        child: Center(
          child: Text("Site controller  is empty!!"),
        ),
      )
          : (_siteController.sitesListResponse == null)
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
              RaisedButton(
                onPressed: () {
                  _siteController.offset = 0;
                  // getData();
                  getData().whenComplete(() {
                    Get.back();
                  });
                  // _siteController.getSitesData(_siteController.accessKeyResponse.accessKey,widget.influencerID);
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
              left: 6.0, right: 6, bottom: 50,top:5),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(
                    "Site ID: ${_siteController.sitesListResponse.sitesEntity[index].siteId}");
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                borderOnForeground: true,
                elevation: 6,
                margin: EdgeInsets.all(4.0),
                color: Colors.white,
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //       left: BorderSide(
                  //         color: (_siteController
                  //             .sitesListResponse
                  //             .sitesEntity[index]
                  //             .siteStageId ==
                  //             1)
                  //             ? HexColor("#F9A61A")
                  //             : (_siteController
                  //             .sitesListResponse
                  //             .sitesEntity[index]
                  //             .siteStageId ==
                  //             2)
                  //             ? HexColor("#007CBF")
                  //             : HexColor("#39B54A"),
                  //         width: 6,
                  //       )),
                  // ),
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
                                //fontWeight: FontWeight.normal
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
                                      //fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  Obx(
                                        () => Text(
                                      "${_siteController.sitesListResponse.sitesEntity[index].sitePotentialMt}MT",
                                      style: TextStyle(
                                        // color: Colors.black38,
                                          fontSize: SizeConfig
                                              .safeBlockHorizontal *
                                              3.7,
                                          fontFamily:
                                          "Muli",
                                          fontWeight:
                                          FontWeight
                                              .bold
                                        //fontWeight: FontWeight.normal
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
                                    //fontWeight: FontWeight.normal
                                  ),
                                ),
                              )),
                          Padding(padding: const EdgeInsets.only(top: 2.0,right: 7),
                            child: Text( (_siteController.sitesListResponse.sitesEntity[index]
                                .siteOppertunityId ==
                                null)
                                ? ""
                                : printOpportuityStatus(
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
                                //fontWeight: FontWeight.normal
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
                                              //fontWeight: FontWeight.normal
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
                                  //  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: SizeConfig
                                        .safeBlockHorizontal *
                                        2.8,
                                    fontFamily: "Muli",
                                    fontWeight:
                                    FontWeight.bold,

                                    //fontWeight: FontWeight.normal
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
                                    // "${_siteController.sitesListResponse.sitesEntity[index].contactNumber}",
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
                                      //fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
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
                              //fontWeight: FontWeight.normal
                            ),),
                              // Icon(Icons.whatshot,color: Colors.orange,)
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return FilterWidget();
        });
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
    List<SiteProbabilityWinningEntity> data = List<SiteProbabilityWinningEntity>.from(_splashController
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

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }
}
