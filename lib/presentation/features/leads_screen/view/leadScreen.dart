import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/widgets/leads_filter.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ViewLeadScreen.dart';

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

final GlobalKey<ScaffoldState> _formKey = new GlobalKey<ScaffoldState>();
PersistentBottomSheetController controller;

class _LeadScreenState extends State<LeadScreen> {
  // String formatter = new DateFormat("yyyy-mm-dd");
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  LeadsFilterController _leadsFilterController = Get.find();

  //LoginController _loginController = Get.find();
  SplashController _splashController = Get.find();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  int selectedPosition = 0;

  int currentTab = 0;

  var bottomSheetController;

  @override
  void initState() {
    super.initState();
    /* try {
      if (_loginController.validateOtpResponse.leadStatusEntity != null) {
        if (_loginController.validateOtpResponse.leadStatusEntity.length != 0) {
          _splashController.splashDataModel.leadStatusEntity =
              _loginController.validateOtpResponse.leadStatusEntity;
        }
      }
    } catch (_) {
      print('${_.toString()}');
    }*/

    _leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);
  }

  @override
  void dispose() {
    //_connectivity.disposeStream();
    super.dispose();
    _leadsFilterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    print(selectedDateString); // something like 20-04-2020
    return WillPopScope(
        onWillPop: () async {
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          //resizeToAvoidBottomInset: true,
          extendBody: true,
          key: _formKey,
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
                      "OPEN LEADS",
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
                  Get.toNamed(Routes.ADD_LEADS_SCREEN);
                  /*Navigator.push(
                  context,
                  new CupertinoPageRoute(
                      builder: (BuildContext context) => AddNewLeadForm()));*/
                },
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                          setState(() {
                            // currentScreen =
                            //     Dashboard(); // if user taps on this dashboard tab will be active
                            // currentTab = 0;
                            Get.toNamed(Routes.HOME_SCREEN);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.home,
                              color: Colors.white60,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white60,
                              ),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              new CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      DraftLeadListScreen()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.drafts,
                              color: Colors.white60,
                            ),
                            Text(
                              'Drafts',
                              style: TextStyle(
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          Get.toNamed(Routes.SEARCH_SCREEN);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.white60,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white60,
                              ), //
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
                          "Total Count : ${(_leadsFilterController.leadsListResponse.leadsEntity == null) ? 0 : _leadsFilterController.leadsListResponse.leadsEntity.length}",
                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: 15,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ),
                      ),
                      Obx(() => Text(
                            "Total Potential : ${(_leadsFilterController.leadsListResponse.totalLeadPotential == null) ? 0 : _leadsFilterController.leadsListResponse.totalLeadPotential}",
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
                          itemCount: _leadsFilterController
                              .leadsListResponse.leadsEntity.length,
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 10),
                          // itemExtent: 125.0,
                          itemBuilder: (context, index) {
                            print(
                                '${_splashController.splashDataModel.leadStatusEntity[(_leadsFilterController.leadsListResponse.leadsEntity[index].leadStatusId) - 1].leadStatusDesc}');
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  ViewLeadScreen(_leadsFilterController
                                      .leadsListResponse
                                      .leadsEntity[index]
                                      .leadId),
                                    binding: AddLeadsBinding()
                                );

                                // Navigator.push(
                                //   context,
                                //   new CupertinoPageRoute(
                                //     builder: (BuildContext context) =>
                                //         ViewLeadScreen(_leadsFilterController
                                //             .leadsListResponse
                                //             .leadsEntity[index]
                                //             .leadId),
                                //   ),
                                // );
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
                                      // Positioned(
                                      //     top: 0,
                                      //     left: 250,
                                      //     right: 0,
                                      //     child: Container(
                                      //         color: Colors.white,
                                      //         child: Column(
                                      //           children: <Widget>[
                                      //             Image.asset(
                                      //               'assets/images/Container.png',
                                      //               fit: BoxFit.fitHeight,
                                      //             ),
                                      //           ],
                                      //         ))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
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
                                                        "Lead ID (${_leadsFilterController.leadsListResponse.leadsEntity[index].leadId})",
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
                                                        const EdgeInsets.all(
                                                            2.0),
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
                                                        label: Obx(
                                                          () => Text(
                                                            (_splashController
                                                                .splashDataModel
                                                                .leadStatusEntity[(_leadsFilterController
                                                                        .leadsListResponse
                                                                        .leadsEntity[
                                                                            index]
                                                                        .leadStatusId) -
                                                                    1]
                                                                .leadStatusDesc),
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "#39B54A"),
                                                                fontSize: 8,
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
                                                          _leadsFilterController
                                                              .leadsListResponse
                                                              .leadsEntity[
                                                                  index]
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Row(
                                                    children: [
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
                                                      Obx(
                                                        () => Text(
                                                          "${_leadsFilterController.leadsListResponse.leadsEntity[index].leadSitePotentialMt}MT",
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
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                // Text(
                                                //   "Call Contractor",
                                                //   style: TextStyle(
                                                //       // color: Colors.white,
                                                //       fontSize: 11,
                                                //       fontFamily: "Muli",
                                                //       fontWeight: FontWeight.bold
                                                //       //fontWeight: FontWeight.normal
                                                //       ),
                                                // ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.call,
                                                      color:
                                                          HexColor("#8DC63F"),
                                                    ),
                                                    Obx(
                                                      () => GestureDetector(
                                                        child: Text(
                                                          "${_leadsFilterController.leadsListResponse.leadsEntity[index].contactNumber}",
                                                          //" Call Contractor",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "Muli",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic
                                                              //fontWeight: FontWeight.normal
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
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
    _formKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          /*return  showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {*/
          return FilterWidget();
        })
        .closed
        .then((value) => () {
              print('Closed');
            });
  }

  void _closeModalBottomSheet() {
    if (controller != null) {
      controller.close();
      controller = null;
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }
}
