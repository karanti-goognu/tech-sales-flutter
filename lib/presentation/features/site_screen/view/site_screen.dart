import 'dart:async';
import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/database/sitelist_db_helper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SiteRefreshDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_filter.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SiteScreen extends StatefulWidget {
  @override
  _SiteScreenState createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  // String formatter = new DateFormat("yyyy-mm-dd");
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  SiteController _siteController = Get.find();
  AppController _appController = Get.find();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;
  int selectedPosition = 0;
  int currentTab = 0;
  bool internetCheck = false;
  StreamSubscription<DataConnectionStatus> listener;


  // final db = SiteListDBHelper();
  List<SitesEntity> siteList = new List();

  ScrollController _scrollController;

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('hello');
      _siteController.offset += 10;
      print(_siteController.offset);
      // _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
    }
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }


  @override
  void initState() {
    super.initState();

    // _appController.getAccessKey(RequestIds.GET_SITES_LIST);
    // fetchSiteList();

    SitesDBProvider model = ScopedModel.of(this.context);
    model.fetchAllSites().then((value) => {

    });


    _scrollController = ScrollController();
    _scrollController..addListener(_scrollListener);
  }
/*Check net Connection*/
  checkConnection() async {
    internetChecking().then((result){
      _siteController.isUserOnlineStatus=result;
    });
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          _siteController.isUserOnlineStatus=true;
          break;
        case DataConnectionStatus.disconnected:
          _siteController.isUserOnlineStatus=false;
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    print(selectedDateString); // something like 20-04-2020

    return ScopedModelDescendant<SitesDBProvider>(builder: (context, child, model) {
      return Stack(children: <Widget>[
        WillPopScope(
            onWillPop: () async {
              Get.offNamed(Routes.HOME_SCREEN);
              return true;
              },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Scaffold(
                  extendBody: true,
                  backgroundColor: ColorConstants.backgroundColorGrey,
                  appBar: AppBar(
                    // titleSpacing: 50,
                    // leading: new Container(),
                    backgroundColor: ColorConstants.appBarColor,
                    toolbarHeight: 120,
                    centerTitle: false,
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "OPEN SITES",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: "Muli"),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            FlatButton(
                              onPressed: () {
                                _settingModalBottomSheet(context);
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
                                                "${_siteController.selectedFilterCount}",
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
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () => Get.toNamed(Routes.SEARCH_SITES_SCREEN),
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
                                Obx(() => (_siteController.assignToDate ==
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
                                          "${_siteController.assignFromDate} to ${_siteController.assignToDate}")
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
                                Obx(() => (_siteController.selectedSiteStatus ==
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
                                          "${_siteController.selectedSiteStatus}")
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
                                Obx(() => (_siteController.selectedSiteStage ==
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
                                      Text("${_siteController.selectedSiteStage}")
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
                                Obx(() => (_siteController.selectedSitePincode ==
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
                                          "${_siteController.selectedSitePincode}")
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
                                Obx(() => (_siteController.selectedSiteInfluencerCat ==
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
                                          "${_siteController.selectedSiteInfluencerCat}")
                                    ],
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    print("selected");
                                  },
                                )),
                              ],
                            ))
                      ],
                    ),
                    automaticallyImplyLeading: false,
                  ),
                  floatingActionButton:
                  SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
                  // floatingActionButton: Container(
                  //   height: 68.0,
                  //   width: 68.0,
                  //   child: FittedBox(
                  //     child: FloatingActionButton(
                  //       backgroundColor: Colors.amber,_siteController
                  //       child: Icon(
                  //         Icons.add,
                  //         color: Colors.black,
                  //       ),
                  //       onPressed: () {
                  //         gv.fromLead = false;
                  //         Get.toNamed(Routes.ADD_LEADS_SCREEN);
                  //       },
                  //     ),
                  //   ),
                  // ),
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
                              Text(
                                  "Total Count : ${(model.siteListing == null) ? 0 : model.siteListing.length}",
                                  style: TextStyle(
                                    fontFamily: "Muli",
                                    fontSize: SizeConfig.safeBlockHorizontal*3.5,
                                    // color: HexColor("#FFFFFF99"),
                                  ),
                              ),
                               Text(
                                "Total Potential : ${(_siteController.sitesListResponse.totalSitePotential == null) ? 0 : double.parse(_siteController.sitesListResponse.totalSitePotential).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontFamily: "Muli",
                                  fontSize: SizeConfig.safeBlockHorizontal*3.5,
                                  // color: HexColor("#FFFFFF99"),
                              )),
                            ],
                          ),
                        ),
                        // Expanded(child: leadsDetailWidget(model)),
                        Expanded(child:FutureBuilder<List<SitesModal>>(
                          future: model.fetchAllSites1(),
                          // future: model.fetchAllSites(),
                          builder: (BuildContext context, AsyncSnapshot<List<SitesModal>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount:snapshot.data.length,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, bottom: 10),
                                  // itemExtent: 125.0,
                                  itemBuilder: (context, index) {
                                    SitesModal siteList = snapshot.data[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new CupertinoPageRoute(
                                                builder: (BuildContext context) =>
                                                    ViewSiteScreen(
                                                        siteList.siteId)));
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
                                                            const EdgeInsets.all(2.0),
                                                            child: Text(
                                                              "Site ID (${siteList.siteId})",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily: "Muli",
                                                                  fontWeight:
                                                                  FontWeight.bold
                                                                //fontWeight: FontWeight.normal
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(2.0),
                                                            child: Text(
                                                              "District: ${siteList.siteDistrict} ",
                                                              style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontSize: 12,
                                                                  fontFamily: "Muli",
                                                                  fontWeight:
                                                                  FontWeight.bold
                                                                //fontWeight: FontWeight.normal
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
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
                                                                      .withOpacity(
                                                                      0.1),
                                                                  label: Text(
                                                                    (printSiteStage(
                                                                        siteList
                                                                            .siteStageId,model)),
                                                                    style: TextStyle(
                                                                        color: HexColor(
                                                                            "#39B54A"),
                                                                        fontSize: SizeConfig.safeBlockHorizontal*3,
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
                                                                padding: EdgeInsets.only(
                                                                    left: 10.0),
                                                                child: Text(
                                                                  " ${siteList.siteCreationDate}",
                                                                  overflow: TextOverflow.ellipsis,
                                                                  //  textAlign: TextAlign.start,
                                                                  style: TextStyle(
                                                                    fontSize:  SizeConfig.safeBlockHorizontal*2.5,
                                                                    fontFamily: "Muli",
                                                                    fontWeight:
                                                                    FontWeight.bold,

                                                                    //fontWeight: FontWeight.normal
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
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
                                                                      color:
                                                                      Colors.black38,
                                                                      fontSize: 15,
                                                                      fontFamily: "Muli",
                                                                      fontWeight:
                                                                      FontWeight.bold
                                                                    //fontWeight: FontWeight.normal
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${siteList.siteTotalSitePotential}MT",
                                                                  style: TextStyle(
                                                                    // color: Colors.black38,
                                                                      fontSize: 15,
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
                                                            (siteList
                                                                .siteOppertunityId ==
                                                                null)
                                                                ? ""
                                                                : printOpportuityStatus(
                                                                siteList
                                                                    .siteOppertunityId,model),
                                                            style: TextStyle(
                                                                color: Colors.blue,
                                                                fontSize: 10,
                                                                fontFamily: "Muli",
                                                                fontWeight:
                                                                FontWeight.bold
                                                              //fontWeight: FontWeight.normal
                                                            ),
                                                            textAlign: TextAlign.right,
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            "Site Score - ${siteList.siteScore}",
                                                            style: TextStyles
                                                                .robotoRegular14,
                                                            textAlign: TextAlign.right,
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Container(),
                                                              ),
                                                              Icon(
                                                                Icons.call,
                                                                color:
                                                                HexColor("#8DC63F"),
                                                              ),
                                                              GestureDetector(
                                                                child: Text(
                                                                  "${siteList.siteOwnerContactNumber}",
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 15,
                                                                      fontFamily: "Muli",
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontStyle:
                                                                      FontStyle.italic
                                                                    //fontWeight: FontWeight.normal
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  String num =
                                                                      siteList
                                                                          .siteOwnerContactNumber;
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
                                                padding:
                                                const EdgeInsets.fromLTRB(8, 4, 8, 0),
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
                                                    Text(
                                                      (siteList
                                                          .siteProbabilityWinningId ==
                                                          null)
                                                          ? ""
                                                          : printProbabilityOfWinning(
                                                          siteList
                                                              .siteProbabilityWinningId,model),
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
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ), ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Obx(()=>

                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeightSafeTop),
                          child: new Container(
                            alignment: Alignment.center,
                            height: SizeConfig.screenHeight*.01,
                            color: _siteController.isUserOnlineStatus?  Colors.green: Colors.red,

                          ),
                        )
                        )
                    ),
                  ],
                ),
              ],
            ))
      ]);
    });
  }

  Widget leadsDetailWidget(SitesDBProvider model) {
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
                        itemCount: siteList.length,
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
                                          ViewSiteScreen(
                                              siteList[index].siteId)));
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
                                /*decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                    color: (_siteController
                                                .sitesListResponse
                                                .sitesEntity[index]
                                                .siteStageId ==
                                            1)
                                        ? HexColor("#F9A61A")
                                        : HexColor("#007CBF"),
                                    width: 6,
                                  )),
                                ),*/
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
                                                /* Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "Follow-up Date XXXX",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.normal
                                                      //fontWeight: FontWeight.normal
                                                      ),
                                                ),
                                              ),*/
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    "Site ID (${siteList[index].siteId})",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.bold
                                                        //fontWeight: FontWeight.normal
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    "District: ${siteList[index].siteDistrict} ",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 12,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.bold
                                                        //fontWeight: FontWeight.normal
                                                        ),
                                                  ),
                                                ),
                                                Row(
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
                                                                .withOpacity(
                                                                    0.1),
                                                        label: Text(
                                                            (printSiteStage(
                                                                siteList[index]
                                                                    .siteStageId,model)),
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "#39B54A"),
                                                                fontSize: 12,
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
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Text(
                                                        " ${siteList[index].siteCreationDate}",
                                                        //  textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.bold,

                                                          //fontWeight: FontWeight.normal
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
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
                                                            color:
                                                                Colors.black38,
                                                            fontSize: 15,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                      Text(
                                                          "${siteList[index].sitePotentialMt}MT",
                                                          style: TextStyle(
                                                              // color: Colors.black38,
                                                              fontSize: 15,
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
                                                  (siteList[index]
                                                              .siteOppertunityId ==
                                                          null)
                                                      ? ""
                                                      : printOpportuityStatus(
                                                          siteList[index]
                                                              .siteOppertunityId,model),
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 10,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //fontWeight: FontWeight.normal
                                                      ),
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "Site Score - ${siteList[index].siteScore}",
                                                  style: TextStyles
                                                      .robotoRegular14,
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Icon(
                                                      Icons.call,
                                                      color:
                                                          HexColor("#8DC63F"),
                                                    ),
                                                    GestureDetector(
                                                      child: Text(
                                                        "${siteList[index].contactNumber}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FontStyle.italic
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                      onTap: () {
                                                        String num =
                                                            siteList[index]
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
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 4, 8, 0),
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
                                            (siteList[index]
                                                        .siteProbabilityWinningId ==
                                                    null)
                                                ? ""
                                                : printProbabilityOfWinning(
                                                    siteList[index]
                                                        .siteProbabilityWinningId,model),
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SiteFilterWidget();
        }).whenComplete(() {
          siteList = _siteController.cartListing;
    });
  }


  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

  String printOpportuityStatus(int value,SitesDBProvider provider) {
    List<SiteOpportunityStatusEntity> data = new List();
    provider.fetchSiteOpportunityById(value).then((value) => {
      data = value
    });
    if (data.length >= 1) {
      print("size greater than 0 \n ${data[0].opportunityStatus}");
      return "${data[0].opportunityStatus}";
    } else {
      print("size is 0");
      return "";
    }
  }

  String printProbabilityOfWinning(int value,SitesDBProvider provider) {
    List<SiteProbabilityWinningEntity> data = new List();
    provider.fetchSiteProbabilityWinningEntity(value).then((value) => {
      data = value
    });
    if (data.length >= 1) {
      print(
          "size greater than 0 \n ${jsonEncode(data[0].siteProbabilityStatus)}");
      return "${data[0].siteProbabilityStatus}";
    } else {
      print("size is 0");
      return "";
    }
  }
  List<SiteStageEntity> data = new List();
  String printSiteStage(int value,SitesDBProvider provider) {
     provider.querySiteStateValue(value).then((value)  {

        data = value;

    });
       if (data.length >0) {

      return "${data[0].siteStageDesc}";
    } else {
      print("size is 0");
      return "";
    }
  }
}
