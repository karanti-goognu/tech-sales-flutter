import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tech_sales/widgets/background_container_image.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode? inputFieldNode;
  TextEditingController controller = new TextEditingController();
  LeadsFilterController _leadsFilterController = Get.find();
  SplashController _splashController = Get.find();


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
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
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
          ),
          new Expanded(child: leadsDetailWidget()),
        ],
      ),
    ));
  }

  Widget leadsDetailWidget() {
    return Obx(() =>  (_leadsFilterController.leadsListResponse == null)
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
                          child: Card(
                              clipBehavior: Clip.antiAlias,
                              borderOnForeground: true,
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
                                    BackgroundContainerImage(),
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
                                                      style: TextStyle(
                                                        fontSize: 13,
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
                                                          ),
                                                    ),
                                                    Obx(
                                                      () => Text(
                                                        "${_leadsFilterController.leadsListResponse.leadsEntity[index].leadSitePotentialMt}MT",
                                                        style: TextStyle(
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                "Call Contractor",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.bold
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
      _leadsFilterController.srSearch(text);
    }
  }

}


