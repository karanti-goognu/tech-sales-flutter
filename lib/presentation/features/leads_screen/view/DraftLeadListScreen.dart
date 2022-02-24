import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/helper/draftLeadDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/DraftLeadModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;

class DraftLeadListScreen extends StatefulWidget {
  @override
  _DraftLeadListScreenState createState() => _DraftLeadListScreenState();
}

class _DraftLeadListScreenState extends State<DraftLeadListScreen> {
  final db = DraftLeadDBHelper();
  List<SaveLeadRequestDraftModel> draftList = new List.empty(growable: true);
  List<int?> draftIdList = new List.empty(growable: true);

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
          print(json.decode(value[i].leadModel!));
          draftIdList.add(value[i].id);
          draftList.add(SaveLeadRequestDraftModel.fromJson(
              json.decode(value[i].leadModel!)));
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
          floatingActionButton: SpeedDialFAB(customStyle: customStyle,speedDial: speedDial,),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigator(),
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
                  gv.draftID = draftIdList[index];
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
                                        draftList[index].leadDistrictName! ??
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
                                        ? draftList[index].leadSalesPotentialMt!
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
        sum = sum + double.parse(draftList[i].leadSalesPotentialMt!);
      }
    }
    return sum.toString();
  }
}
