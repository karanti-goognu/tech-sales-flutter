import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/helper/draftLeadDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/DraftLeadModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:provider/provider.dart';

class DraftLeadListScreen extends StatefulWidget {
  @override
  _DraftLeadListScreenState createState() => _DraftLeadListScreenState();
}

class _DraftLeadListScreenState extends State<DraftLeadListScreen> {
  final db = DraftLeadDBHelper();
  List<SaveLeadRequestDraftModel> draftList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchDraftList();
    // var _cars = await db.fetchAll();
  }

  fetchDraftList() async {
    db.fetchAll().then((value) {
      for (int i = 0; i < value.length; i++) {
        setState(() {


          print(json.decode(value[i].leadModel));
          draftList.add(
              SaveLeadRequestDraftModel.fromJson(json.decode(value[i].leadModel)));
        });


      }

    });
    //await db.removeLeadInDraft(2);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
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
                      "Drafts",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: "Muli"),
                    ),

                  ],
                ),
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
                      Text(
                        "Total Count : " + draftList.length.toString(),
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: 15,
                          // color: HexColor("#FFFFFF99"),
                        ),
                      ),
                      Text(
                        "Total Potential : " + countTotalPotential(draftList),
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: 15,
                          // color: HexColor("#FFFFFF99"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: DraftLeadsDetailWidget()),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }

  Widget DraftLeadsDetailWidget() {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: draftList.length,
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
            // itemExtent: 125.0,
            itemBuilder: (context, index) {

              return GestureDetector(
                onTap: () {
                  gv.draftID = index + 1;
                  gv.fromLead = true;
                  print(draftList[index].toJson());
                  gv.saveLeadRequestModel = draftList[index];
                  Get.toNamed(Routes.ADD_LEADS_SCREEN);
                },
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    borderOnForeground: true,
                    //shadowColor: colornew,
                    elevation: 6,
                    margin: EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Draft " + (index + 1).toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "District : " +
                                        draftList[index].leadDistrictName ??
                                    "",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                draftList[index].assignDate ?? "",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Site Pt : ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    (draftList[index].leadSalesPotentialMt !=
                                            "")
                                        ? draftList[index].leadSalesPotentialMt
                                        : "0",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Icon(
                                Icons.edit_sharp,
                                color: Colors.amber,
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }

  String countTotalPotential(List<SaveLeadRequestDraftModel> draftList) {
    double sum = 0;

    for (int i = 0; i < draftList.length; i++) {
      if (draftList[i].leadSalesPotentialMt != null &&
          draftList[i].leadSalesPotentialMt != "") {
        sum = sum + double.parse(draftList[i].leadSalesPotentialMt);
      }
    }
    return sum.toString();
  }
}
