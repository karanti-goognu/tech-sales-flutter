import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/widgets/leads_filter.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
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
import 'ViewLeadScreen.dart';

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

PersistentBottomSheetController? controller;

class _LeadScreenState extends State<LeadScreen> {
  LeadsFilterController _leadsFilterController = Get.find();
  SplashController _splashController = Get.find();
  DateTime selectedDate = DateTime.now();
  String? selectedDateString;
  int selectedPosition = 0;
  int currentTab = 0;
  var bottomSheetController;
  ScrollController? _scrollController;
  SiteDistrictListModel? _siteDistrictListModel;

  @override
  void initState() {
    super.initState();
    _leadsFilterController.leadsListResponse.leadsEntity = null;
    print(_leadsFilterController.offset);
    getDropdownDistData();
    internetChecking().then((result) {
      if (result) _leadsFilterController.offset = 0;
      _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST, context);
    });
    _scrollController = ScrollController();
    _scrollController?..addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController!.position.pixels ==
        _scrollController!.position.maxScrollExtent) {
      _leadsFilterController.offset += 10;
      print(_leadsFilterController.offset);
      _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST, context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _leadsFilterController.offset = 0;
    _leadsFilterController.dispose();
  }

  void disposeController(BuildContext context) {
    _leadsFilterController.offset = 0;
    _leadsFilterController.dispose();
  }

  getDropdownDistData() {
    internetChecking().then((result) => {
          if (result == true)
            {
              _leadsFilterController.getLeadDistList().then((data) {
                setState(() {
                  if (data != null) {
                    _siteDistrictListModel = data;
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    return WillPopScope(
        onWillPop: () async {
          disposeController(context);
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColorGrey,
          appBar: AppBar(
            backgroundColor: ColorConstants.appBarColor,
            toolbarHeight: SizeConfig.screenHeight! * .14,
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "OPEN LEADS",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: "Muli"),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                    height: 18,
                                    width: 18,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 0.0),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(3)),
                                    ),
                                    child: Center(
                                        child: Obx(
                                      () => Text(
                                          "${_leadsFilterController.selectedFilterCount}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal)),
                                    ))),
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
                        ),
                        Obx(
                          () => Visibility(
                            visible:
                                (_leadsFilterController.selectedFilterCount ==
                                        0)
                                    ? false
                                    : true,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _leadsFilterController.selectedLeadStage =
                                      StringConstants.empty;
                                  _leadsFilterController
                                          .selectedLeadStageValue =
                                      StringConstants.empty;
                                  _leadsFilterController.selectedLeadStatus =
                                      StringConstants.empty;
                                  _leadsFilterController
                                          .selectedLeadStatusValue =
                                      StringConstants.empty;
                                  _leadsFilterController.assignToDate =
                                      StringConstants.empty;
                                  _leadsFilterController.assignFromDate =
                                      StringConstants.empty;
                                  _leadsFilterController.selectedLeadPotential =
                                      StringConstants.empty;
                                  _leadsFilterController
                                          .selectedLeadPotentialValue =
                                      StringConstants.empty;
                                  _leadsFilterController
                                          .selectedDeliveryPointsValue =
                                      StringConstants.empty;
                                  _leadsFilterController.selectedLeadDistrict =
                                      StringConstants.empty;
                                  _leadsFilterController.selectedFilterCount =
                                      0;
                                  _leadsFilterController.offset = 0;
                                  _leadsFilterController
                                      .leadsListResponse.leadsEntity = null;
                                  _leadsFilterController.getAccessKey(
                                      RequestIds.GET_LEADS_LIST, context);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                    },
                                  )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_leadsFilterController
                                    .selectedDeliveryPointsValue ==
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
                                        "${_leadsFilterController.selectedDeliveryPointsValue}")
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(side: BorderSide()),
                                onSelected: (bool value) {
                                },
                              )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() =>
                            (_leadsFilterController.selectedLeadDistrict ==
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
                                            "${_leadsFilterController.selectedLeadDistrict}")
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
                      top: 10.0, left: 15.0, bottom: 5, right: 15.0),
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
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
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
                                        color: HexColor("#F9A61A")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Non-Verified",
                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize: 14,
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
                                    width: 15,
                                    height: 15,
                                    child: Image.asset(
                                        "assets/images/callcenter.png"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "Call Center Leads",
                                    style: TextStyle(
                                      fontFamily: "Muli",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      scrollDirection: Axis.horizontal,
                    )),
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
      () => (_leadsFilterController.leadsListResponse == null)
          ? Container(
              child: Center(
                child: Text("Leads list response  is empty!!"),
              ),
            )
          : (_leadsFilterController.leadsListResponse.leadsEntity == null)
              ? Container(
                  child:
                      Center(child: Text("Leads list is empty!!")),
                )
              : (_leadsFilterController.leadsListResponse.leadsEntity.length ==
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorConstants.buttonNormalColor,
                              ),
                              onPressed: () {
                                _leadsFilterController.offset = 0;
                                _leadsFilterController.getAccessKey(
                                    RequestIds.GET_LEADS_LIST, context);
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
                      itemCount: _leadsFilterController
                          .leadsListResponse.leadsEntity.length,
                      padding: const EdgeInsets.only(
                          left: 6.0, right: 6, bottom: 10),
                      // itemExtent: 125.0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print(
                                "Lead ID: ${_leadsFilterController.leadsListResponse.leadsEntity[index].leadId}");
                            Get.to(
                                () => ViewLeadScreen(_leadsFilterController
                                    .leadsListResponse
                                    .leadsEntity[index]
                                    .leadId),
                                binding: AddLeadsBinding());
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
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Obx(
                                                  () => Row(
                                                    children: [
                                                      Visibility(
                                                        visible: (_leadsFilterController
                                                                    .leadsListResponse
                                                                    .leadsEntity[
                                                                        index]
                                                                    .leadSourcePlatform ==
                                                                "CALL_CENTRE")
                                                            ? true
                                                            : false,
                                                        child: Container(
                                                          width: 15,
                                                          height: 15,
                                                          child: Image.asset(
                                                              "assets/images/callcenter.png"),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Lead ID (${_leadsFilterController.leadsListResponse.leadsEntity[index].leadId})",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Obx(
                                                  () => Text(
                                                    "District: ${_leadsFilterController.leadsListResponse.leadsEntity[index].leadDistrictName}",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 14,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.bold
                                                        ),
                                                  ),
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 1.0),
                                                  child: Chip(
                                                    shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: HexColor(
                                                                "#39B54A"))),
                                                    backgroundColor:
                                                        HexColor("#39B54A")
                                                            .withOpacity(0.1),
                                                    label: Obx(
                                                      () => Text(
                                                        (_splashController
                                                                    .splashDataModel
                                                                    .leadStatusEntity !=
                                                                null
                                                            ? _splashController
                                                                    .splashDataModel
                                                                    .leadStatusEntity[(_leadsFilterController
                                                                            .leadsListResponse
                                                                            .leadsEntity[index]
                                                                            .leadStatusId) -
                                                                        1]
                                                                    .leadStatusDesc ??
                                                                ""
                                                            : ""),
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#39B54A"),
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                1.9,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                    ),
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
                                                          .leadsEntity[index]
                                                          .createdOn,
                                                    ))}",
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
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, bottom: 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: FittedBox(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Site-Pt: ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontSize: 14,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                          "${_leadsFilterController.leadsListResponse.leadsEntity[index].leadSitePotentialMt}MT",
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
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                  "${toBeginningOfSentenceCase(_leadsFilterController.leadsListResponse.leadsEntity[index].contactName)}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal
                                                      )),

                                              GestureDetector(
                                                child: FittedBox(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        color:
                                                            HexColor("#8DC63F"),
                                                      ),
                                                      Text(
                                                        " Call Contact",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FontStyle.normal
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  String? num =
                                                      _leadsFilterController
                                                          .leadsListResponse
                                                          .leadsEntity[index]
                                                          .contactNumber;
                                                  launch('tel:$num');
                                                },
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
                      }),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return FilterWidget(siteDistrictListModel: _siteDistrictListModel);
        });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }
}
