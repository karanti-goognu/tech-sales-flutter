import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen_new.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SiteSearchScreen extends StatefulWidget {
  @override
  _SiteSearchScreenState createState() => new _SiteSearchScreenState();
}

class _SiteSearchScreenState extends State<SiteSearchScreen> {
  TextEditingController controller = new TextEditingController();
  SiteController _siteController = Get.find();
  AppController _appController = Get.find();

  List<LeadDetailsModel> list = [
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, false,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, false,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
    new LeadDetailsModel("XXXX", "NIT Fridabad", 200, true, true,
        DateFormat("yyyy-MM-dd").format(DateTime.now()), 999999999),
  ];

  @override
  void initState() {
    super.initState();
    // getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
        bottomNavigationBar: BottomNavigator(),
        body: new SafeArea(
      child: Column(
        children: <Widget>[
          new Container(
            color: Colors.transparent,
            child: new Card(
              elevation: 8,
              margin: const EdgeInsets.all(8.0),
              child: new ListTile(
                leading: new Icon(Icons.search),
                dense: true,
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Search', border: InputBorder.none,
                      // prefixIcon: Icon(Icons.search)
                  ),
                  onChanged: onSearchTextChanged,
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.cancel),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
              ),
            ),
          ),
          new Expanded(child: leadsDetailWidget()),
        ],
      ),
    ));
  }

  Widget leadsDetailWidget() {
    return Obx(() => (_siteController == null)
        ? Container(
            child: Center(
              child: Text("Leads controller  is empty!!"),
            ),
          )
        : (_siteController.sitesListResponse == null)
            ? Container(
                child: Center(
                  child: Text("Leads list response  is empty!!"),
                ),
              )
            : (_siteController.sitesListResponse.sitesEntity == null)
                ? Container(
                    child: Center(
                      child: Text("Search results is empty!!"),
                    ),
                  )
                : (_siteController.sitesListResponse.sitesEntity.length == 0)
                    ? Container(
                        child: Center(
                          child: Text("You don't have any leads..!!"),
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
                                          ViewSiteScreenNew(siteId: _siteController
                                              .sitesListResponse
                                              .sitesEntity[index]
                                              .siteId,
                                          tabIndex: 0,)));
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
                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.all(2.0),
                                              //   child: Text(
                                              //     "Follow-up Date XXXX",
                                              //     style: TextStyle(
                                              //         fontSize: 12,
                                              //         fontFamily: "Muli",
                                              //         fontWeight:
                                              //             FontWeight.normal
                                              //         //fontWeight: FontWeight.normal
                                              //         ),
                                              //   ),
                                              // ),
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

  onSearchTextChanged(String text) async {
    if (controller.text.length >= 3) {
      _siteController.siteSearch(text);
    }
  }
}

class LeadDetailsModel {
  String leadID;
  String district;
  int sitePotential;
  bool activeStatus;
  bool verifiedStatus;
  String date;
  int ownerNumber;

  LeadDetailsModel(this.leadID, this.district, this.sitePotential,
      this.activeStatus, this.verifiedStatus, this.date, this.ownerNumber);
}
