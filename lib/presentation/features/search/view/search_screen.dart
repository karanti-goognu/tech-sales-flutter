
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = new TextEditingController();
  LeadsFilterController _leadsFilterController = Get.find();
  SplashController _splashController = Get.find();



  @override
  void initState() {
    super.initState();
    // getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: BackFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
        body: new SafeArea(
      child: Column(
        children: <Widget>[
          new Container(
            color: Colors.transparent,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                elevation: 8,
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: (tempStr.length < 3)?textKB():numKB(),
                  // new TextField(
                  //   controller: controller,
                  //   decoration: new InputDecoration(
                  //       hintText: 'Search', border: InputBorder.none),
                  //   onChanged: onSearchTextChanged,
                  // ),
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
          ),
          new Expanded(child: leadsDetailWidget()),
        ],
      ),
    ));
  }
 String tempStr = "";
  Widget textKB(){
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
          hintText: 'Search', border: InputBorder.none),
      onChanged: (value){
          if(value.length >= 3 && _isNumeric(value)){
            setState(() {
              controller.text = value;
              tempStr = value;
            });
          }else{
            onSearchTextChanged(value);
          }
      },
    );
  }

  Widget numKB(){
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration: new InputDecoration(
          hintText: 'Search', border: InputBorder.none),
      onChanged: onSearchTextChanged,
    );
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;

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
                      child: Text("Search results is empty!!"),
                    ),
                  )
                : (_leadsFilterController
                            .leadsListResponse.leadsEntity.length ==
                        0)
                    ? Container(
                        child: Center(
                          child: Text("You don't have any leads..!!"),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _leadsFilterController
                            .leadsListResponse.leadsEntity.length,
                        padding: const EdgeInsets.only(
                            left: 6.0, right: 6, bottom: 8),
                        // itemExtent: 125.0,
                        itemBuilder: (context, index) {
                          String selectedDateString = "empty";
                          final DateFormat formatter =
                              DateFormat('dd-MMM-yyyy');
                          if (_leadsFilterController.leadsListResponse
                                  .leadsEntity[index].assignDate !=
                              null) {
                            selectedDateString = formatter.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    _leadsFilterController.leadsListResponse
                                        .leadsEntity[index].assignDate));
                          }
                          return GestureDetector(
                            /*onTap: (){
                              Navigator.push(context, new CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ViewLeadScreen(_leadsFilterController.leadsListResponse.leadsEntity[index].leadId)));
                              */ /*Navigator.push(context,new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          ViewLeadScreen(_leadsFilterController.leadsListResponse.leadsEntity[index].leadId)));
                           */ /* }*/

                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              borderOnForeground: true,
                              //shadowColor: colornew,
                              elevation: 6,
                              margin: EdgeInsets.all(10.0),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                    color: _leadsFilterController
                                                .leadsListResponse
                                                .leadsEntity[index]
                                                .leadStageId ==
                                            1
                                        ? HexColor("#F9A61A")
                                        : HexColor("#007CBF"),
                                    width: 6,
                                  )),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        left: 250,
                                        right: 0,
                                        child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/Container.png',
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ],
                                            ))),
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
                                                      "Lead-Id(${_leadsFilterController.leadsListResponse.leadsEntity[index].leadId})",
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
                                                                  "#6200EE"))),
                                                      backgroundColor:
                                                          HexColor("#6200EE")
                                                              .withOpacity(0.1),
                                                      label: Obx(
                                                        () => Text(
                                                          "${_splashController.splashDataModel.leadStatusEntity[(_leadsFilterController.leadsListResponse.leadsEntity[index].leadStatusId) - 1].leadStatusDesc}",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  "#6200EE"),
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
                                                      "$selectedDateString",
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
                                                            // fontSize: 15,
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
                                              Text(
                                                "Call Contractor",
                                                style: TextStyle(
                                                    // color: Colors.white,
                                                    fontSize: 11,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.bold
                                                    //fontWeight: FontWeight.normal
                                                    ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    size: 14,
                                                    color: HexColor("#8DC63F"),
                                                  ),
                                                  Obx(
                                                    () => Text(
                                                      "${_leadsFilterController.leadsListResponse.leadsEntity[index].contactNumber}",
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#1C99D4"),
                                                          fontSize: 14,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic
                                                          //fontWeight: FontWeight.normal
                                                          ),
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
                        }));
  }

  onSearchTextChanged(String text) async {
    LeadsFilterController _leadsFilterController = Get.find();
    if (controller.text.length >= 3) {
      print('Hello');
      _leadsFilterController.searchKey = text;
      _leadsFilterController.getAccessKey(RequestIds.SEARCH_LEADS);
    }
  }
}

