import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/widgets/leads_filter.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class InfluencerNameList extends StatefulWidget {
  @override
  _InfluencerNameListState createState() => _InfluencerNameListState();
}


PersistentBottomSheetController controller;

class _InfluencerNameListState extends State<InfluencerNameList> {
  LeadsFilterController _leadsFilterController = Get.find();
  SplashController _splashController = Get.find();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  int selectedPosition = 0;

  int currentTab = 0;

  var bottomSheetController;
  ScrollController _scrollController;

  @override
  void initState() {
    print("Leads initstate called");

    super.initState();
    internetChecking().then((result) {
      if (result)
        _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
      _leadsFilterController.offset = 0;
    });

    _scrollController = ScrollController();
    _scrollController..addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('hello');
      _leadsFilterController.offset += 10;
      print(_leadsFilterController.offset);
      _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _leadsFilterController?.dispose();
    _leadsFilterController.offset = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    // print(selectedDateString); // something like 20-04-2020
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
                      "INFL. NAME",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: "Muli"),
                    ),
                    FlatButton(
                      onPressed: () {
                        // _settingModalBottomSheet(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            //  Icon(Icons.exposure_zero_outlined),
                            Container(
                                height: 18,
                                width: 18,
                                // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 0.0),
                                  borderRadius:
                                  new BorderRadius.all(Radius.circular(3)),
                                ),
                                child: Center(
                                    child: Obx(() => Text(
                                        "${_leadsFilterController.selectedFilterCount}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            //fontFamily: 'Raleway',
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal))))),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'FILTER',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_leadsFilterController.assignToDate ==
                            StringConstants.empty)
                            ? Container()
                            : FilterChip(
                          label: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  "${_leadsFilterController.assignFromDate} to ${_leadsFilterController.assignToDate}")
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(side: BorderSide()),
                          onSelected: (bool value) {
                            print("selected");
                          },
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_leadsFilterController.selectedLeadStatus ==
                            StringConstants.empty)
                            ? Container()
                            : FilterChip(
                          label: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  "${_leadsFilterController.selectedLeadStatus}")
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(side: BorderSide()),
                          onSelected: (bool value) {
                            print("selected");
                          },
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_leadsFilterController.selectedLeadStage ==
                            StringConstants.empty)
                            ? Container()
                            : FilterChip(
                          label: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  "${_leadsFilterController.selectedLeadStage}")
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(side: BorderSide()),
                          onSelected: (bool value) {
                            print("selected");
                          },
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() =>
                        (_leadsFilterController.selectedLeadPotential ==
                            StringConstants.empty)
                            ? Container()
                            : FilterChip(
                          label: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  "${_leadsFilterController.selectedLeadPotential}")
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(side: BorderSide()),
                          onSelected: (bool value) {
                            print("selected");
                          },
                        )),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ))
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
                            () => Text(
                          "Total Count : ${(_leadsFilterController.leadsListResponse.totalLeadCount == null) ? 0 : _leadsFilterController.leadsListResponse.totalLeadCount}",
                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ),
                      ),
                      Obx(() => Text(
                        "Total Potential : ${(_leadsFilterController.leadsListResponse.totalLeadPotential == null) ? 0 : _leadsFilterController.leadsListResponse.totalLeadPotential}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                          // color: HexColor("#FFFFFF99"),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                    padding:
                    EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: HexColor("#1C99D4")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Tele-Verified",
                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize: 14,
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
                                        color: HexColor("#39B54A")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Phy-Verified",
                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize: 14,
                                      // color: HexColor("#FFFFFF99"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),),
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
          () => (_leadsFilterController == null)
          ? Container(
        child: Center(
          child: Text("Leads controller  is empty!!"),
        ),
      )
          : (_leadsFilterController.leadsListResponse == null)
          ? Container(
        child: Center(
          child: Text("Leads list response  is empty!!"),
        ),
      )
          : (_leadsFilterController.leadsListResponse.leadsEntity == null)
          ? Container(
        child: Center(
          child: Text("Leads list is empty!!"),
        ),
      )
          : (_leadsFilterController
          .leadsListResponse.leadsEntity.length ==
          0)
          ? Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You don't have any leads..!!"),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _leadsFilterController.offset = 0;
                  _leadsFilterController.getAccessKey(
                      RequestIds.GET_LEADS_LIST);
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
          itemCount: _leadsFilterController
              .leadsListResponse.leadsEntity.length,
          padding: const EdgeInsets.only(
              left: 6.0, right: 6, bottom: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(
                    "Site ID: ${_leadsFilterController.leadsListResponse.leadsEntity[index].leadId}");
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                borderOnForeground: true,
                elevation: 6,
                margin: EdgeInsets.all(4.0),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                          color: (_leadsFilterController
                              .leadsListResponse
                              .leadsEntity[index]
                              .leadStageId ==
                              1)
                              ? HexColor("#F9A61A")
                              : (_leadsFilterController
                              .leadsListResponse
                              .leadsEntity[index]
                              .leadStageId ==
                              2)
                              ? HexColor("#007CBF")
                              : HexColor("#39B54A"),
                          width: 6,
                        )),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: const EdgeInsets.only(top: 2.0,left: 7),
                            child:  Text(
                              "Follow-up Date XXXX",
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
                                      "${_leadsFilterController.leadsListResponse.leadsEntity[index].leadSitePotentialMt}MT",
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
                                  "Site ID (${_leadsFilterController.leadsListResponse.leadsEntity[index].leadId})",
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
                            child: Text(
                              "Retention Site",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
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
                                  2.0,left: 7),
                              child: Obx(
                                    () => Text(
                                  "District: ${_leadsFilterController.leadsListResponse.leadsEntity[index].leadDistrictName}",
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
                              "${toBeginningOfSentenceCase(_leadsFilterController.leadsListResponse.leadsEntity[index].contactName)}",
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
                          Padding(padding: const EdgeInsets.only(top: 2.0,left: 7),
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
                                              () =>Text(
                                            (_splashController.splashDataModel.leadStatusEntity[(_leadsFilterController.leadsListResponse.leadsEntity[index]
                                                .leadStatusId) -
                                                1]
                                                .leadStatusDesc),
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
                                  " ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(
                                    _leadsFilterController
                                        .leadsListResponse
                                        .leadsEntity[
                                    index]
                                        .createdOn,
                                  ))}",
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
                                    // "${_leadsFilterController.leadsListResponse.leadsEntity[index].contactNumber}",
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
                                  _leadsFilterController
                                      .leadsListResponse
                                      .leadsEntity[
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
                            Text("Exclusive Dalmia ".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 14,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(children: [
                              Text("High".toUpperCase(), style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.bold
                              //fontWeight: FontWeight.normal
                            ),),
                              Icon(Icons.whatshot,color: Colors.orange,)
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

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }
}
