import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/services/my_connectivity.dart';

import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';

import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/enums/lead_stage.dart';
import 'package:flutter_tech_sales/utils/enums/lead_status.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  // String formatter = new DateFormat("yyyy-mm-dd");
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  LeadsFilterController _leadsFilterController = Get.find();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;

  int selectedPosition = 0;

  List<leadDetailsModel> list = [
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, false,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, false,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new leadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
  ];

  int currentTab = 0;

  @override
  void initState() {
    super.initState();

    //_leadsFilterController.getAccessKey(RequestIds.GET_LEADS_LIST);

    _leadsFilterController.getSecretKey(RequestIds.GET_SECRET_KEY);

    /*_connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });*/
  }

  @override
  void dispose() {
    //_connectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String connectionString;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        connectionString = "Offline";
        break;
      case ConnectivityResult.mobile:
        connectionString = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        connectionString = "WiFi: Online";
    }
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
                  "OPEN LEADS",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: "Muli"),
                ),
                FlatButton(
                  onPressed: () {
                    /* (connectionString == 'Offline')
                        ? _leadsFilterController.showNoInternetSnack()
                        : _settingModalBottomSheet(context);*/
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
                    Obx(() => (_leadsFilterController.selectedLeadStatus ==
                            StringConstants.empty)
                        ? Container()
                        : FilterChip(
                            label: Row(
                              children: [
                                Icon(
                                  Icons.cancel,
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
                                  Icons.cancel,
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
                  ],
                ))
          ],
        ),
        automaticallyImplyLeading: false,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20.0, top: 20),
        //     child: Column(
        //       children: [
        //         FlatButton(
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(18.0),
        //               side: BorderSide(color: Colors.white)),
        //           color: Colors.transparent,
        //           child: Padding(
        //             padding: const EdgeInsets.only(bottom: 5),
        //             child: Row(
        //               children: [
        //               //  Icon(Icons.exposure_zero_outlined),
        //                 Container(
        //                   height: 18,
        //                   width: 18,
        //                   // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
        //                   decoration: new BoxDecoration(
        //                     color: Colors.white,
        //                      border: Border.all(color: Colors.black, width: 0.0),
        //                      borderRadius: new BorderRadius.all(Radius.circular(3)),
        //                   ),
        //                   child: Center(child: Text("0",
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                          //fontFamily: 'Raleway',
        //                           fontSize: 12,
        //                           fontWeight: FontWeight.normal
        //                       )))
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(left:8.0),
        //                   child: Text(
        //                     'FILTER',
        //                     style: TextStyle(color: Colors.white ,
        //                     fontSize: 18),
        //
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //    ),
        //  ),
        //  ],
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
                        // Text(
                        //   'Dashboard',
                        //   style: TextStyle(
                        //     color: currentTab == 0 ? Colors.blue : Colors.grey,
                        //   ),
                        //),
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
                        // Text(
                        //   'Mail',
                        //   style: TextStyle(
                        //     color: currentTab == 2 ? Colors.blue : Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    minSize: 40,
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
                        // Text(
                        //   'Search',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body:
          /*(connectionString == 'Offline')
          ? Container(
              color: Colors.black12,
              child: Center(child: Text("No Internet Connection found.")),
            )
          :*/
          Container(
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
                  Text(
                    "Total Potential : ${_leadsFilterController.leadsListResponse.totalLeadPotential}",
                    style: TextStyle(
                      fontFamily: "Muli",
                      fontSize: 15,
                      // color: HexColor("#FFFFFF99"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
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
                                    color: HexColor("#ADADAD")),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                "Duplicate",
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
    return Obx(() => (_leadsFilterController == null)
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
                : (_leadsFilterController.leadsListResponse.leadsEntity.length == 0)
                    ? Container(
                        child: Center(
                          child: Text("You don't have any leads..!!"),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _leadsFilterController
                            .leadsListResponse.leadsEntity.length,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, bottom: 10),
                        // itemExtent: 125.0,
                        itemBuilder: (context, index) {
                          return Card(
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
                                  color: !list[index].verifiedStatus
                                      ? HexColor("#F9A61A")
                                      : HexColor("#007CBF"),
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
                                                        "${_leadsFilterController.leadsListResponse.leadsEntity[index].leadStageId}",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#39B54A"),
                                                            fontSize: 10,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
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
                                                    list[index].date,
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
                                                      "${_leadsFilterController.leadsListResponse.leadsEntity[index].leadSitePotentialMt}MT",
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
                                            // !list[index].verifiedStatus
                                            //     ? Chip(
                                            //         // shape: StadiumBorder(side: BorderSide(
                                            //         //     color: HexColor("#6200EE")
                                            //         // )),
                                            //         backgroundColor: HexColor("#F9A61A"),
                                            //         label: Text(
                                            //           "NON VERIFIED",
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontSize: 14,
                                            //               fontFamily: "Muli",
                                            //               fontWeight: FontWeight.bold
                                            //               //fontWeight: FontWeight.normal
                                            //               ),
                                            //         ),
                                            //       )
                                            //     : Chip(
                                            //         // shape: StadiumBorder(side: BorderSide(
                                            //         //     color: HexColor("#6200EE")
                                            //         // )),
                                            //         backgroundColor: HexColor("#00ADEE"),
                                            //         label: Text(
                                            //           "TELE VERIFIED",
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontSize: 14,
                                            //               fontFamily: "Muli",
                                            //               fontWeight: FontWeight.bold
                                            //               //fontWeight: FontWeight.normal
                                            //               ),
                                            //         ),
                                            //       ),
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
                                                  color: HexColor("#8DC63F"),
                                                ),
                                                Obx(
                                                  () => GestureDetector(
                                                    child: Text(
                                                      "${_leadsFilterController.leadsListResponse.leadsEntity[index].contactNumber}",
                                                 //  " Call Contractor",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black,
                                                          fontSize: 15,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic
                                                          //fontWeight: FontWeight.normal
                                                          ),
                                                    ),
                                                    onTap: (){
                                                      String num = _leadsFilterController.leadsListResponse.leadsEntity[index].contactNumber;
                                                      launch('tel:${num}');
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
                          );
                        }));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: ColorConstants.lightGeyColor,
        context: context,
        builder: (BuildContext bc) {
          return Stack(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Filters",
                            style: TextStyles.mulliBold18,
                          ),
                        ),
                        Spacer(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 24,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: SizeConfig.screenWidth,
                    color: ColorConstants.lineColorFilter,
                  ),
                  IntrinsicHeight(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _leadsFilterController.selectedPosition = 0;
                                },
                                child: returnSelectedWidget("Assign Date", 0)),
                            GestureDetector(
                                onTap: () {
                                  _leadsFilterController.selectedPosition = 1;
                                },
                                child: returnSelectedWidget("Lead Stage", 1)),
                            GestureDetector(
                                onTap: () {
                                  _leadsFilterController.selectedPosition = 2;
                                },
                                child: returnSelectedWidget("Lead Status", 2)),
                            GestureDetector(
                              onTap: () {
                                _leadsFilterController.selectedPosition = 3;
                              },
                              child: returnSelectedWidget("Lead Potential", 3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: (SizeConfig.blockSizeVertical) + 400,
                        width: 1,
                        color: ColorConstants.lineColorFilter,
                      ),
                      new Expanded(
                          flex: 2,
                          child: returnSelectedWidgetBody(
                              _leadsFilterController.selectedPosition)),
                    ],
                  )),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 102,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 1.0,
                        width: SizeConfig.screenWidth,
                        color: ColorConstants.lineColorFilter,
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(30, 27, 16, 8),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //Navigator.pop(context);
                                  _leadsFilterController.selectedLeadStage =
                                      StringConstants.empty;
                                  _leadsFilterController.selectedLeadStatus =
                                      StringConstants.empty;
                                  _leadsFilterController.selectedFilterCount =
                                      0;
                                },
                                child: Text(
                                  "Clear All",
                                  style: TextStyles.mulliBoldYellow18,
                                ),
                              ),
                              Spacer(),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _leadsFilterController
                                      .getSecretKey(RequestIds.GET_LEADS_LIST);
                                },
                                color: ColorConstants.buttonNormalColor,
                                child: Text(
                                  "APPLY",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget returnSelectedWidget(String text, int position) {
    return Obx(() => Container(
          height: 50,
          color: (_leadsFilterController.selectedPosition == position)
              ? Colors.white
              : Colors.transparent,
          child: Center(
            child: Text(
              text,
              style: (_leadsFilterController.selectedPosition == position)
                  ? TextStyles.mulliBold14
                  : TextStyle(color: Colors.black),
            ),
          ),
        ));
  }

  Widget returnSelectedWidgetBody(int position) {
    return Obx(
      () => Container(
        color: Colors.white,
        child: (_leadsFilterController.selectedPosition == 0)
            ? returnAssignDateBody()
            : (_leadsFilterController.selectedPosition == 1)
                ? returnLeadStageBody()
                : (_leadsFilterController.selectedPosition == 2)
                    ? returnLeadStatusBody()
                    : Text('The Longest text button 3'),
      ),
    );
  }

  Widget returnAssignDateBody() {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 28, 18, 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(19, 0, 19, 6),
              child: Text(
                "From Date",
                style: TextStyles.robotoRegular14,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                width: double.infinity,
                height: 51,
                decoration: myBoxDecoration(),
                //       <--- BoxDecoration here
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          "${_leadsFilterController.assignFromDate}",
                          style: TextStyles.robotoBold16,
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            _selectDate(context, "from");
                          },
                          child: Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: ColorConstants.clearAllTextColor,
                          ),
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(19, 31, 19, 6),
              child: Text(
                "To Date",
                style: TextStyles.robotoRegular14,
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(19, 14, 19, 14),
                width: double.infinity,
                height: 51,
                decoration: myBoxDecoration(),
                //       <--- BoxDecoration here
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          "${_leadsFilterController.assignToDate}",
                          style: TextStyles.robotoBold16,
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            _selectDate(context, "to");
                          },
                          child: Icon(
                            Icons.date_range_rounded,
                            size: 22,
                            color: ColorConstants.clearAllTextColor,
                          )),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget returnLeadStageBody() {
    return Container(
        padding: EdgeInsets.fromLTRB(8, 28, 8, 28),
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text("${StringConstants.nonVerified}"),
                leading: Obx(
                  () => Radio(
                    value: StringConstants.nonVerified,
                    groupValue:
                        _leadsFilterController.selectedLeadStage as String,
                    onChanged: (String value) {
                      if (_leadsFilterController.selectedLeadStage ==
                          StringConstants.empty) {
                        _leadsFilterController.selectedFilterCount =
                            _leadsFilterController.selectedFilterCount + 1;
                      }
                      _leadsFilterController.selectedLeadStage = value;
                    },
                  ),
                )),
            ListTile(
                title: const Text('Tele-Verified'),
                leading: Obx(
                  () => Radio(
                    value: StringConstants.teleVerified,
                    groupValue:
                        _leadsFilterController.selectedLeadStage as String,
                    onChanged: (String value) {
                      if (_leadsFilterController.selectedLeadStage ==
                          StringConstants.empty) {
                        _leadsFilterController.selectedFilterCount =
                            _leadsFilterController.selectedFilterCount + 1;
                      }
                      _leadsFilterController.selectedLeadStage = value;
                    },
                  ),
                )),
            ListTile(
                title: const Text('Physical-Verified'),
                leading: Obx(
                  () => Radio(
                    value: StringConstants.physicalVerified,
                    groupValue:
                        _leadsFilterController.selectedLeadStage as String,
                    onChanged: (String value) {
                      if (_leadsFilterController.selectedLeadStage ==
                          StringConstants.empty) {
                        _leadsFilterController.selectedFilterCount =
                            _leadsFilterController.selectedFilterCount + 1;
                      }
                      _leadsFilterController.selectedLeadStage = value;
                    },
                  ),
                )),
          ],
        ));
  }

  Widget returnLeadStatusBody() {
    return Container(
        padding: EdgeInsets.fromLTRB(8, 28, 8, 28),
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text(StringConstants.active),
                leading: Obx(
                  () => Radio(
                    value: StringConstants.active,
                    groupValue:
                        _leadsFilterController.selectedLeadStatus as String,
                    onChanged: (String value) {
                      if (_leadsFilterController.selectedLeadStatus ==
                          StringConstants.empty) {
                        _leadsFilterController.selectedFilterCount =
                            _leadsFilterController.selectedFilterCount + 1;
                      }
                      _leadsFilterController.selectedLeadStatus = value;
                    },
                  ),
                )),
            ListTile(
              title: Text(StringConstants.rejected),
              leading: Radio(
                value: StringConstants.rejected,
                groupValue: _leadsFilterController.selectedLeadStatus as String,
                onChanged: (String value) {
                  if (_leadsFilterController.selectedLeadStatus ==
                      StringConstants.empty) {
                    _leadsFilterController.selectedFilterCount =
                        _leadsFilterController.selectedFilterCount + 1;
                  }
                  _leadsFilterController.selectedLeadStatus = value;
                },
              ),
            ),
            ListTile(
              title: Text(StringConstants.convertedToSite),
              leading: Radio(
                value: StringConstants.convertedToSite,
                groupValue: _leadsFilterController.selectedLeadStatus as String,
                onChanged: (String value) {
                  if (_leadsFilterController.selectedLeadStatus ==
                      StringConstants.empty) {
                    _leadsFilterController.selectedFilterCount =
                        _leadsFilterController.selectedFilterCount + 1;
                  }
                  _leadsFilterController.selectedLeadStatus = value;
                },
              ),
            ),
            ListTile(
              title: Text(StringConstants.duplicate),
              leading: Radio(
                value: StringConstants.duplicate,
                groupValue: _leadsFilterController.selectedLeadStatus as String,
                onChanged: (String value) {
                  if (_leadsFilterController.selectedLeadStatus ==
                      StringConstants.empty) {
                    _leadsFilterController.selectedFilterCount =
                        _leadsFilterController.selectedFilterCount + 1;
                  }
                  _leadsFilterController.selectedLeadStatus = value;
                },
              ),
            ),
          ],
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("dd-MM-yyyy");
        final String formattedDate = formatter.format(picked);
        if (type == "to") {
          _leadsFilterController.assignToDate = formattedDate;
        } else {
          _leadsFilterController.assignFromDate = formattedDate;
        }
        selectedDateString = formattedDate;
      });
  }
}

class leadDetailsModel {
  String leadID;
  String district;
  int sitePotential;
  bool activeStatus;
  bool verifiedStatus;
  String date;
  int ownerNumber;

  leadDetailsModel(this.leadID, this.district, this.sitePotential,
      this.activeStatus, this.verifiedStatus, this.date, this.ownerNumber);
}
