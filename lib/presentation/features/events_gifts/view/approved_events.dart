import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/approved_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class ApprovedEvents extends StatefulWidget {
  @override
  _ApprovedEventsState createState() => _ApprovedEventsState();
}

class _ApprovedEventsState extends State<ApprovedEvents> {
  ApprovedEventsModel approvedEventsModel;
  EventListModels _eventListModels;
  ScrollController _scrollController;
  EventsFilterController eventsFilterController = Get.find();
  List<EventListModels> current = [];
  List<EventListModels> upcoming = [];
  List<EventListModels> past = [];


  @override
  void initState() {
    super.initState();
    getApprovedEventsData();
  }

  getApprovedEventsData() async {
    await eventsFilterController.getAccessKey().then((value) async {
      print(value.accessKey);
      await eventsFilterController.getAllEventData(value.accessKey).then((data) {
        setState(() {
          approvedEventsModel = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Container(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/images/calendar.png')),
                    SizedBox(width: 10,),
                    Text('Current Events'),
                  ],
                ),
                children: [
                  getList(),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Container(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/images/calendar.png')),
                    SizedBox(width: 10,),
                    Text('Upcoming Events'),
                  ],
                ),
                children: [
                  getList(),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent
              ),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Container(
                      height: 20,
                        width: 20,
                        child: Image.asset('assets/images/calendar.png')),
                    SizedBox(width: 10,),
                    Text('Past Events'),
                  ],
                ),
                children: [
                  getList(),
                ],
              ),
            ),
          ),

        ],
      )
     // getList(),
    );
  }

  Widget getList() {
    return ListView.builder(
      shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: 2,
        padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.toNamed(Routes.DETAIL_EVENT);
            },
            child: Card(
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
            ),
          );
        });
  }
}

