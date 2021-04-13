import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';

class ApprovedEvents extends StatefulWidget {
  @override
  _ApprovedEventsState createState() => _ApprovedEventsState();
}

class _ApprovedEventsState extends State<ApprovedEvents> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ExpansionTile(
          //   title: Row(
          //     children: [
          //       Image.asset('assets/images/sr.png'),
          //      Text('Current Events'),
          //     ],
          //   ),
          //   children: [
          //     getList()
          //   ],
          // ),
          // ExpansionTile(
          //   title: Row(
          //     children: [
          //       Image.asset('assets/images/sr.png'),
          //       Text('Upcoming Events'),
          //     ],
          //   ),
          //   children: [
          //     getList(),
          //   ],
          // ),
          ExpansionTile(
            title: Row(
              children: [
                Container(
                  height: 20,
                    width: 20,
                    child: Image.asset('assets/images/sr.png')),
                Text('Past Events'),
              ],
            ),
            children: [

              Container(color: Colors.pinkAccent,height: 50,),
              Container(color: Colors.amber,height: 50,),


            ],
          ),

        ],
      )
     // getList(),
    );
  }

  Widget getList() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: 5,
        padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            borderOnForeground: true,
            elevation: 6,
            margin: EdgeInsets.all(4.0),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color:
                      //(
                      // _leadsFilterController
                      // .leadsListResponse
                      // .leadsEntity[index]
                      // .leadStageId ==
                      // 1)
                      // ? HexColor("#F9A61A")
                      // : (_leadsFilterController
                      // .leadsListResponse
                      // .leadsEntity[index]
                      // .leadStageId ==
                      // 2)
                      // ? HexColor("#007CBF")
                      // :
                      HexColor("#39B54A"),
                      width: 6,
                    )),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "24-Mar-21",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Muli",
                              //fontWeight:
                              // FontWeight.bold
                              fontWeight: FontWeight.normal),
                          // ),
                        ),
                        Chip(
                          shape: StadiumBorder(
                              side: BorderSide(color: HexColor("#39B54A"))),
                          backgroundColor: HexColor("#39B54A").withOpacity(0.1),
                          label: Text('Status: Planned'),
                          // Obx(
                          //       () => Text(
                          //     (_splashController
                          //         .splashDataModel
                          //         .leadStatusEntity[(_leadsFilterController
                          //         .leadsListResponse
                          //         .leadsEntity[
                          //     index]
                          //         .leadStatusId) -
                          //         1]
                          //         .leadStatusDesc),
                          //     style: TextStyle(
                          //         color: HexColor(
                          //             "#39B54A"),
                          //         fontSize: SizeConfig.safeBlockHorizontal*1.9,
                          //         fontFamily:
                          //         "Muli",
                          //         fontWeight:
                          //         FontWeight
                          //             .bold
                          //       //fontWeight: FontWeight.normal
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Obx(
                          // () =>

                          Text(
                            "Mason Meet",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.bold),
                          ),
                          // ),
                          //Obx(
                          // () =>
                          Text(
                            "Planned : 25",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                            // ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Obx(
                          // () =>

                          Text(
                            "Venue:",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                          ),
                          // ),
                          //Obx(
                          // () =>
                          Text(
                            "Dealer(s) : 25",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                            // ),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Obx(
                          // () =>

                          Text(
                            "EVENT ID:",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                          ),
                          // ),
                          //Obx(
                          // () =>
                          Text(
                            "LEADS EXPECTED : 25",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                            // ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

