import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();

    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
  }

  @override
  void dispose() {
    //_connectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    print(selectedDateString); // something like 20-04-2020
    return Scaffold(
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
                              border:
                                  Border.all(color: Colors.black, width: 0.0),
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                    Obx(() =>
                        (_siteController.assignToDate == StringConstants.empty)
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
                                Text("${_siteController.selectedSiteStatus}")
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
                          Text("${_siteController.selectedSitePincode}")
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
                          Text("${_siteController.selectedSiteInfluencerCat}")
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
      floatingActionButton: Container(
        height: 68.0,
        width: 68.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              gv.fromLead = false;
              Get.toNamed(Routes.ADD_LEADS_SCREEN);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: ColorConstants.appBarColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Get.toNamed(Routes.HOME_SCREEN);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.white60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.drafts,
                          color: Colors.white60,
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    minSize: 40,
                    onPressed: () {
                      Get.toNamed(Routes.SEARCH_SITES_SCREEN);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
                      "Total Count : ${(_siteController.sitesListResponse.sitesEntity == null) ? 0 : _siteController.sitesListResponse.sitesEntity.length}",
                      style: TextStyle(
                        fontFamily: "Muli",
                        fontSize: 15,
                        // color: HexColor("#FFFFFF99"),
                      ),
                    ),
                  ),
                  Obx(() => Text(
                        "Total Potential : ${(_siteController.sitesListResponse.totalSitePotential == null) ? 0 : _siteController.sitesListResponse.totalSitePotential}",
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: 15,
                          // color: HexColor("#FFFFFF99"),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                  scrollDirection: Axis.horizontal,
                )),
            Expanded(child: leadsDetailWidget()),
            // SizedBox(
            //   height: 30,
            // ),
          ],
        ),
      ),
    );
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
                                          ViewSiteScreen(_siteController.sitesListResponse.sitesEntity[index].siteId
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
                                decoration: BoxDecoration(
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
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
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
                                                  "Follow-up Date XXXX",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.normal
                                                      //fontWeight: FontWeight.normal
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
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
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Obx(
                                                    () => Text(
                                                      "District: ${_siteController.sitesListResponse.sitesEntity[index].siteDistrict}",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.bold
                                                          //fontWeight: FontWeight.normal
                                                          ),
                                                    ),
                                                  )),
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
                                                              .withOpacity(0.1),
                                                      label: Obx(
                                                        () => Text(
                                                          ((_siteController
                                                                      .sitesListResponse
                                                                      .sitesEntity[
                                                                          index]
                                                                      .siteStageId) ==
                                                                  1)
                                                              ? "Active"
                                                              : "Rejected",
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
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Text(
                                                      " ${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(
                                                        _siteController
                                                            .sitesListResponse
                                                            .sitesEntity[index]
                                                            .createdOn,
                                                      ))}",
                                                      //  textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 13,
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
                                        Padding(
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
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Site-Pt: ",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 15,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.bold
                                                          //fontWeight: FontWeight.normal
                                                          ),
                                                    ),
                                                    Obx(
                                                      () => Text(
                                                        "${_siteController.sitesListResponse.sitesEntity[index].sitePotentialMt}MT",
                                                        style: TextStyle(
                                                            // color: Colors.black38,
                                                            fontSize: 15,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Retention Site ",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.bold
                                                    //fontWeight: FontWeight.normal
                                                    ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: HexColor("#8DC63F"),
                                                  ),
                                                  Obx(
                                                    () => GestureDetector(
                                                      child: Text(
                                                        "${_siteController.sitesListResponse.sitesEntity[index].contactNumber}",
                                                        /*" Call Contractor",*/
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
                                                            _siteController
                                                                .sitesListResponse
                                                                .sitesEntity[
                                                                    index]
                                                                .contactNumber;
                                                        launch('tel:$num');
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                                            "Exclusive Dalmia ",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12,
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.bold
                                                //fontWeight: FontWeight.normal
                                                ),
                                          ),
                                          Text(
                                            "Hot ",
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
        });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }
}
