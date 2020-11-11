import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/hp/StudioProjects/tech-sales-flutter/lib/presentation/features/leads_filter/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/enums/lead_stage.dart';
import 'package:flutter_tech_sales/utils/enums/lead_status.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

LeadStage _leadStage = LeadStage.NonVerified;
LeadStatus _leadStatus = LeadStatus.Active;

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  // String formatter = new DateFormat("yyyy-mm-dd");
  LeadsFilterController _leadsFilterController = Get.find();

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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorConstants.backgroundColorGrey,
      appBar: AppBar(
        // titleSpacing: 50,
        // leading: new Container(),
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 90,
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
                              border:
                                  Border.all(color: Colors.black, width: 0.0),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(3)),
                            ),
                            child: Center(
                                child: Text("0",
                                    style: TextStyle(
                                        color: Colors.black,
                                        //fontFamily: 'Raleway',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)))),
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

            // Row(
            //   children: [
            //     Chip(
            //       label: Text("cdjccc"),
            //     ),
            //   ],
            // )
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
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  new CupertinoPageRoute(
                      builder: (BuildContext context) => AddNewLeadForm()));
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
                      setState(() {
                        // currentScreen =
                        //     Dashboard(); // if user taps on this dashboard tab will be active
                        // currentTab = 0;
                      });
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
                    onPressed: () {},
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 15.0,bottom: 5  ,right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Count : " + list.length.toString(),
                    style: TextStyle(
                      fontFamily: "Muli",
                      fontSize: 15,
                     // color: HexColor("#FFFFFF99"),
                    ),
                  ),
                  Text(
                    "Total Potential : " + "2000 MT",
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
              padding:  EdgeInsets.only(left:15.0,right: 15.0,bottom: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:4.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#F9A61A")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:3.0),
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
                          padding: const EdgeInsets.only(top:4.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#1C99D4")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:3.0),
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
                          padding: const EdgeInsets.only(top:4.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#39B54A")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:3.0),
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
                          padding: const EdgeInsets.only(top:4.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#ADADAD")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:3.0),
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
            ),
            Expanded(child: leadsDetailWidget())
          ],
        ),
      ),
    );
  }

  Widget leadsDetailWidget() {
    return ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        // itemExtent: 125.0,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            borderOnForeground: true,
            //shadowColor: colornew,
            elevation: 6,
            margin: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: !list[index].verifiedStatus ? HexColor("#F9A61A") : HexColor("#007CBF"),width: 6,)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Lead-Id(" + list[index].leadID + ")",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.bold
                                    //fontWeight: FontWeight.normal
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "District: " + list[index].district,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.bold
                                    //fontWeight: FontWeight.normal
                                    ),
                              ),
                            ),

                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 1.0),
                                  child: Chip(
                                    shape: StadiumBorder(
                                        side:
                                            BorderSide(color: HexColor("#6200EE"))),
                                    backgroundColor:
                                        HexColor("#6200EE").withOpacity(0.1),
                                    label: Text(
                                      "Active",
                                      style: TextStyle(
                                          color: HexColor("#6200EE"),
                                          fontSize: 10,
                                          fontFamily: "Muli",
                                          fontWeight: FontWeight.bold
                                          //fontWeight: FontWeight.normal
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left :10.0),
                                  child: Text(
                                    list[index].date,
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.bold,

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
                        padding: const EdgeInsets.only(right: 15.0,bottom: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Site-Pt: " ,
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 15,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold
                                      //fontWeight: FontWeight.normal
                                    ),
                                  ),
                                  Text(
                                        list[index].sitePotential.toString() +
                                        "MT",
                                    style: TextStyle(
                                       // color: Colors.black38,
                                        fontSize: 15,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold
                                      //fontWeight: FontWeight.normal
                                    ),
                                  ),
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
                                  color: HexColor("#8DC63F"),
                                ),
                                Text(
                                  list[index].ownerNumber.toString(),
                                  style: TextStyle(
                                      color: HexColor("#1C99D4"),
                                      fontSize: 18,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic
                                      //fontWeight: FontWeight.normal
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
        });
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
                              Text(
                                "Clear All",
                                style: TextStyles.mulliBoldYellow18,
                              ),
                              Spacer(),
                              RaisedButton(
                                onPressed: () {},
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
                    Text(
                      "1-Oct-2020",
                      style: TextStyles.robotoBold16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.date_range_rounded,
                        size: 22,
                        color: ColorConstants.clearAllTextColor,
                      ),
                    )
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
                    Text(
                      "1-Oct-2020",
                      style: TextStyles.robotoBold16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.date_range_rounded,
                        size: 22,
                        color: ColorConstants.clearAllTextColor,
                      ),
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
                title: const Text('Non-Verified'),
                leading: Obx(
                  () => Radio(
                    value: LeadStage.NonVerified,
                    groupValue:
                        _leadsFilterController.selectedLeadStage as LeadStage,
                    onChanged: (LeadStage value) {
                      _leadsFilterController.selectedLeadStage = value;
                    },
                  ),
                )),
            ListTile(
                title: const Text('Tele-Verified'),
                leading: Obx(
                  () => Radio(
                    value: LeadStage.TeleVerified,
                    groupValue:
                        _leadsFilterController.selectedLeadStage as LeadStage,
                    onChanged: (LeadStage value) {
                      _leadsFilterController.selectedLeadStage = value;
                    },
                  ),
                )),
            ListTile(
                title: const Text('Physical-Verified'),
                leading: Obx(
                  () => Radio(
                    value: LeadStage.PhysicalVerified,
                    groupValue:
                        _leadsFilterController.selectedLeadStage as LeadStage,
                    onChanged: (LeadStage value) {
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
                title: const Text('Active'),
                leading: Obx(
                  () => Radio(
                    value: LeadStatus.Active,
                    groupValue:
                        _leadsFilterController.selectedLeadStatus as LeadStatus,
                    onChanged: (LeadStatus value) {
                      _leadsFilterController.selectedLeadStatus = value;
                    },
                  ),
                )),
            ListTile(
              title: const Text('Rejected'),
              leading: Radio(
                value: LeadStatus.Rejected,
                groupValue:
                    _leadsFilterController.selectedLeadStatus as LeadStatus,
                onChanged: (LeadStatus value) {
                  _leadsFilterController.selectedLeadStatus = value;
                },
              ),
            ),
            ListTile(
              title: const Text('Converted to site'),
              leading: Radio(
                value: LeadStatus.ConvertedToSite,
                groupValue:
                    _leadsFilterController.selectedLeadStatus as LeadStatus,
                onChanged: (LeadStatus value) {
                  _leadsFilterController.selectedLeadStatus = value;
                },
              ),
            ),
            ListTile(
              title: const Text('Duplicate'),
              leading: Radio(
                value: LeadStatus.Duplicate,
                groupValue:
                    _leadsFilterController.selectedLeadStatus as LeadStatus,
                onChanged: (LeadStatus value) {
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
