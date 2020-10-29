

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:intl/intl.dart';

class LeadScreen extends StatefulWidget {
  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
 // String formatter = new DateFormat("yyyy-mm-dd");
  List<leadDetailsModel> list = [
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,false,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,false,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
    new leadDetailsModel("XXXX","NIT Fridabad",200,true,true,DateFormat("yyyy-MM-dd").format(DateTime.now()),999999999),
  ];


  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorConstants.backgroundColorBlue,
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
                              border: Border.all(color: Colors.black, width: 0.0),
                              borderRadius: new BorderRadius.all(Radius.circular(3)),
                            ),
                            child: Center(child: Text("0",
                                style: TextStyle(
                                    color: Colors.black,
                                    //fontFamily: 'Raleway',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal
                                )))
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(
                            'FILTER',
                            style: TextStyle(color: Colors.white ,
                                fontSize: 18),

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
            onPressed: () {},
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
                    onPressed: () {

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.mail,
                          color:  Colors.white60,
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

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color:Colors.white60,
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
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Count : " + list.length.toString(),
                  style: TextStyle(
                    fontFamily: "Muli",
                    fontSize: 15,
                      color: HexColor("#FFFFFF99"),


                  ),),
                  Text("Total Potential : " + "2000 MT",
                    style: TextStyle(
                      fontFamily: "Muli",
                      fontSize: 15,
                      color:  HexColor("#FFFFFF99"),


                    ),),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(list[index].date,
                     //  textAlign: TextAlign.start,
                       style: TextStyle(
                           fontSize: 11,
                           fontFamily: "Muli",
                           fontWeight: FontWeight.bold,

                         //fontWeight: FontWeight.normal
                       ),),
                      Text("Lead-Id(" + list[index].leadID + ")",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.normal
                        ),
                      ),
                      Text("District: " + list[index].district ,
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.normal
                        ),
                      ),
                      Text("Site-Potential: " + list[index].sitePotential.toString() + "MT",
                        style: TextStyle(
                          color: Colors.black38,
                            fontSize: 14,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.normal
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Chip(
                            shape: StadiumBorder(side: BorderSide(
                              color: HexColor("#6200EE")
                            )),
                          backgroundColor: HexColor("#6200EE").withOpacity(0.1),
                          label: Text("Active",
                            style: TextStyle(
                                color: HexColor("#6200EE"),
                                fontSize: 14,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.bold
                              //fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      !list[index].verifiedStatus ? Chip(
                        // shape: StadiumBorder(side: BorderSide(
                        //     color: HexColor("#6200EE")
                        // )),
                        backgroundColor: HexColor("#F9A61A"),
                        label: Text("NON VERIFIED",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.bold
                            //fontWeight: FontWeight.normal
                          ),
                        ),
                      ) : Chip(
                        // shape: StadiumBorder(side: BorderSide(
                        //     color: HexColor("#6200EE")
                        // )),
                        backgroundColor: HexColor("#00ADEE"),
                        label: Text("TELE VERIFIED",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.bold
                            //fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Call Contractor",
                        style: TextStyle(
                           // color: Colors.white,
                            fontSize: 11,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.normal
                        ),),
                      Row(
                        children: [
                          Icon(Icons.call,
                          color: HexColor("#8DC63F"),),
                          Text(list[index].ownerNumber.toString(),
                            style: TextStyle(
                                color: HexColor("#1C99D4"),
                                fontSize: 18,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                              //fontWeight: FontWeight.normal
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
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

  leadDetailsModel(this.leadID,this.district,this.sitePotential,this.activeStatus,this.verifiedStatus,this.date,this.ownerNumber);
}