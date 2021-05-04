import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/approved_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class ApprovedEvents extends StatefulWidget {
  @override
  _ApprovedEventsState createState() => _ApprovedEventsState();
}

class _ApprovedEventsState extends State<ApprovedEvents> {
  ApprovedEventsModel approvedEventsModel;
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

      await eventsFilterController
          .getApprovedEventData()
          .then((data) {
        setState(() {
          approvedEventsModel = data;
        });
        getSortedData();
        print('DDDD: $data');
      });
  }



  getSortedData() {
    print('In getSortedData');
    DateTime now = DateTime.now();

    if (approvedEventsModel != null && approvedEventsModel.eventListModels != null) {
      for (int i = 0; i < approvedEventsModel.eventListModels.length; i++) {
        String date = approvedEventsModel.eventListModels[i].eventDate;
        DateTime eventDt = DateTime.parse(date);
        print("All data: ${approvedEventsModel.eventListModels.map((e) => e.eventId).toList()} I-$i");

        if (eventDt.compareTo(now) == 0 && eventDt.compareTo(now) == 1) {
       // if (now.difference(eventDt).inDays == 0 && now.difference(eventDt).inDays == 1) {
          current.add(approvedEventsModel.eventListModels[i]);
          //current = approvedEventsModel.eventListModels;
          print('Current : $current');
        } else if (eventDt.isBefore(now)) {
        //} else if (now.difference(eventDt).inDays.isNegative) {
          past.add(approvedEventsModel.eventListModels[i]);
          //past = approvedEventsModel.eventListModels;
          print('Past : $past');
        } else if (eventDt.compareTo(now) < 1) {
        //} else if (now.difference(eventDt).inDays > 1) {
          upcoming.add(approvedEventsModel.eventListModels[i]);
          //upcoming = approvedEventsModel.eventListModels;
          print('Upcoming : $upcoming');
        } else {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Scaffold(
        body: ListView(
      children: [
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  Container(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/images/calendar.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Current Events'),
                ],
              ),
              children: [
                (current != null && current.length > 0)?
                getList(current):Container(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('No Current Events !!'),
                  ),),)
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  Container(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/images/calendar.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Upcoming Events'),
                ],
              ),
              children: [
                (upcoming != null && upcoming.length > 0)?
                getList(upcoming):Container(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('No Upcoming Events !!'),
                  ),),)
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: ExpansionTile(
              title: Row(
                children: [
                  Container(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/images/calendar.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Past Events'),
                ],
              ),
              children: [
                (past != null && past.length > 0)?
                getList(past):Container(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('No Past Events !!'),
                  ),),)
              ],
            ),
          ),
        ),
      ],
    )
        // getList(),
        );
  }

  Widget getList(List<EventListModels> list) {
    getSortedData();
    return (approvedEventsModel != null &&
            approvedEventsModel.eventListModels != null &&
            approvedEventsModel.eventListModels.length > 0 &&
            list != null)
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
            padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // print('EVENT ID: ${list[index].eventId}');
                  // Get.to(
                  //         () => DetailViewEvent(list[index].eventId),
                  //     binding: EGBinding());
                 // Get.toNamed(Routes.DETAIL_EVENT);
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
                                list[index].eventDate,
                                //"24-Mar-21",
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
                                    side:
                                        BorderSide(color: HexColor("#39B54A"))),
                                backgroundColor:
                                    HexColor("#39B54A").withOpacity(0.1),
                                label: Text(
                                    'Status: ${list[index].eventStatusText}'),

                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Obx(
                                // () =>

                                Text(
                                  list[index].eventTypeText,
                                  // "Mason Meet",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.bold),
                                ),
                                // ),
                                //Obx(
                                // () =>
                                Text(
                                  "Planned : ${list[index].eventInflCount}",
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
                                  list[index].eventVenue,
                                  //"Venue:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.normal),
                                ),
                                // ),
                                //Obx(
                                // () =>
                                Text(
                                  "Dealer(s) : ${list[index].dealerName}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.normal),
                                  // ),
                                ),
                              ]),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                                  "EVENT ID: ${list[index].eventId}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.normal),
                                ),
                                // ),
                                //Obx(
                                // () =>
                                Text(
                                  "LEADS EXPECTED : ${list[index].expectedLeadsCount}",
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
            })
        : Container(
            child: Center(
              child: Text("No data!!"),
            ),
          );
  }
}
