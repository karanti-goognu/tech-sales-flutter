import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_pending.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_rejected.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/enums/event_status.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class AllEvents extends StatefulWidget {
  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  AllEventsModel allEventsModel;
  AllEventController allEventController = Get.find();
  List<EventListModels> pending = [];
  List<EventListModels> approved = [];
  List<EventListModels> rejected = [];
  List<EventListModels> completed = [];
  List<EventListModels> cancelled = [];
  List<EventListModels> eventRejected = [];
  List<EventListModels> notSubmitted = [];

  ScrollController _scrollController;
  String option = StringConstants.pendingApproval;

  @override
  void initState() {
    allEventController.getAllEventData();
    //getAllEventsData();
    getSortedData();

    super.initState();
  }

  getAllEventsData() async {

      await allEventController.getAllEventData().then((data) {
        setState(() {
          allEventsModel = data;
        });
        print("response : ");

        //getSortedData();
      });
  }



  // getSortedData() {
  //   if (allEventsModel != null && allEventsModel.eventListModels != null) {
  //     for (int i = 0; i < allEventsModel.eventListModels.length; i++) {
  //       print("All data: ${allEventsModel.eventListModels.map((e) => e.eventId).toList()} I-$i");
  //       if (allEventsModel.eventListModels[i].eventStatusText == StringConstants.pendingApproval) {
  //         pending.add(allEventsModel.eventListModels[i]);
  //         print('PENDING : $pending');
  //
  //         print(allEventsModel.eventListModels[i].eventId);
  //       } else if (allEventsModel.eventListModels[i].eventStatusText == StringConstants.approved) {
  //         approved.add(allEventsModel.eventListModels[i]);
  //         print('APPROVED : $approved');
  //       } else if (allEventsModel.eventListModels[i].eventStatusText == StringConstants.rejected) {
  //         rejected.add(allEventsModel.eventListModels[i]);
  //
  //       } else if (allEventsModel.eventListModels[i].eventStatusText == StringConstants.completed) {
  //         completed.add(allEventsModel.eventListModels[i]);
  //
  //       } else if (allEventsModel.eventListModels[i].eventStatusText == StringConstants.cancelled) {
  //         cancelled.add(allEventsModel.eventListModels[i]);
  //
  //       } else if (allEventsModel.eventListModels[i].eventStatusText == StringConstants.notSubmitted) {
  //         notSubmitted.add(allEventsModel.eventListModels[i]);
  //
  //       }
  //
  //     }
  //     print("Pending : ${pending.map((e) => e.eventId).toList()}");
  //     print("approved : ${approved.map((e) => e.eventId).toList()}");
  //     print("rejected : ${rejected.map((e) => e.eventId).toList()}");
  //     print("completed : ${completed.map((e) => e.eventId).toList()}");
  //   } else {}
  // }

  getSortedData() {
    if (allEventController != null && allEventController.egAllEventData != null) {
      for (int i = 0; i < allEventController.egAllEventData.eventListModels.length; i++) {
        //print("All data: ${allEventsModel.eventListModels.map((e) => e.eventId).toList()} I-$i");
        if (allEventController.egAllEventData.eventListModels[i].eventStatusText == StringConstants.pendingApproval) {
          pending.add(allEventController.egAllEventData.eventListModels[i]);
          print('PENDING : $pending');

        } else if (allEventController.egAllEventData.eventListModels[i].eventStatusText == StringConstants.approved) {
          approved.add(allEventController.egAllEventData.eventListModels[i]);
          print('APPROVED : $approved');
        } else if (allEventController.egAllEventData.eventListModels[i].eventStatusText == StringConstants.rejected) {
          rejected.add(allEventController.egAllEventData.eventListModels[i]);

        } else if (allEventController.egAllEventData.eventListModels[i].eventStatusText == StringConstants.completed) {
          completed.add(allEventController.egAllEventData.eventListModels[i]);

        } else if (allEventController.egAllEventData.eventListModels[i].eventStatusText == StringConstants.cancelled) {
          cancelled.add(allEventController.egAllEventData.eventListModels[i]);

        } else if (allEventController.egAllEventData.eventListModels[i].eventStatusText == StringConstants.notSubmitted) {
          notSubmitted.add(allEventController.egAllEventData.eventListModels[i]);

        }

      }
      print("Pending : ${pending.map((e) => e.eventId).toList()}");
      print("approved : ${approved.map((e) => e.eventId).toList()}");
      print("rejected : ${rejected.map((e) => e.eventId).toList()}");
      print("completed : ${completed.map((e) => e.eventId).toList()}");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return Scaffold(
      body: ListView(
        children: [
          getStatusList(),
          (option == StringConstants.pendingApproval)
              ? getListForPending(ColorConstants.eventPending, pending)
              : (option == StringConstants.approved)
                  ? getList(ColorConstants.eventApproved, approved)
                  : (option == StringConstants.rejected)
                      ? getListForPending(ColorConstants.eventRejected, rejected)
                      : (option == StringConstants.completed)
                          ? getList(ColorConstants.eventCompleted, completed)
                          : (option == StringConstants.cancelled)
                              ? getList(ColorConstants.eventCancelled, cancelled)
                              // : (option == 6)
                              //      ? getList(HexColor('#B00020'), eventRejected)
                                   : (option == StringConstants.notSubmitted)
                                      ? getListForPending(
                                          HexColor('#808080'), notSubmitted)
                                      : getList(HexColor('#F9A61A'), pending)
        ],
      ),
    );
  }

  Widget getStatusList() {
    return (allEventController != null &&
        allEventController.egAllEventData.eventStatusEntities != null &&
        allEventController.egAllEventData.eventStatusEntities.length > 0)
        ? Container(
            padding: EdgeInsets.only(
              top: ScreenUtil().setSp(5),
            ),
            height: ScreenUtil().setSp(45),
            child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: allEventController.egAllEventData.eventStatusEntities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FilterChip(
                      onSelected: (bool selected) {
                        setState(() {

                          option = allEventController.egAllEventData.eventStatusEntities[index].eventStatusText;
                              //allEventsModel.eventStatusEntities[index].eventStatusText;
                        });
                        print("OPTION:::$option");
                      },
                      selectedColor: Colors.blue.withOpacity(0.2),
                      label: Text(allEventController.egAllEventData.eventStatusEntities[index].eventStatusText),
                      // backgroundColor: option == 1
                      //     ? Colors.blue.withOpacity(0.2)
                      //     : Colors.white,
                      // shape: StadiumBorder(
                      //   side: BorderSide(
                      //       color: option == 5 ? Colors.blue : Colors.black12),
                      // ),
                    ),
                    //),
                  );
                }),
          )
        : Container(
            child: Center(
              child: Text(''),
            ),
          );
  }

  Widget getList(Color borderColor, List<EventListModels> list) {
    print("List from outside: ${list.map((e) => e.eventStatusId).toList()}");
    return
        // allEventsModel != null &&
        //     allEventsModel.eventListModels != null &&
        //     allEventsModel.eventListModels.length > 0 &&
        //     list != null)
        // allEventController != null &&
        //     allEventController.egAllEventData.eventListModels != null &&
        //     allEventController.egAllEventData.eventListModels.length > 0 )
          //  && list != null)
       // ?
        Obx(
                () => (allEventController == null)
                ? Container(
              child: Center(
                child: Text("event controller  is empty!!"),
              ),
            )
                : (allEventController.egAllEventData == null)
                ? Container(
              child: Center(
                child: Text("event list response  is empty!!"),
              ),
            )
                : (allEventController.egAllEventData.eventListModels == null)
                ? Container(
              child: Center(
                child: Text("Leads list is empty!!"),
              ),
            )
                : (allEventController.egAllEventData.eventListModels.length ==
                0)
                ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You don't have any events..!!"),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        allEventController.getAllEventData();
                      },
                      color: ColorConstants.buttonNormalColor,
                      child: Text(
                        "TRY AGAIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
                : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
            padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailViewEvent(list[index].eventId),
                      binding: EGBinding());
                },
                child: eventCard(index, list, borderColor),
              );
            })
        );
        // : Container(
        //     child: Center(
        //       child: Text("No data!!"),
        //     ),
        //   );
  }

  Widget getListForPending(Color borderColor, List<EventListModels> list) {
    print("List from outside: ${list.map((e) => e.eventStatusId).toList()}");
    //return
        // (allEventsModel != null &&
      //       allEventsModel.eventListModels != null &&
      //       allEventsModel.eventListModels.length > 0 &&
      //       list != null)
      // (allEventController != null &&
      //     allEventController.egAllEventData.eventListModels != null &&
      //     allEventController.egAllEventData.eventListModels.length > 0 &&
      //     list != null)
    return Obx(
            () => (allEventController == null)
            ? Container(
          child: Center(
            child: Text("event controller  is empty!!"),
          ),
        )
            : (allEventController.egAllEventData == null)
            ? Container(
          child: Center(
            child: Text("event list response  is empty!!"),
          ),
        )
            : (allEventController.egAllEventData.eventListModels == null)
            ? Container(
          child: Center(
            child: Text("Leads list is empty!!"),
          ),
        )
            : (allEventController.egAllEventData.eventListModels.length ==
            0)
            ? Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have any events..!!"),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    allEventController.getAllEventData();
                  },
                  color: ColorConstants.buttonNormalColor,
                  child: Text(
                    "TRY AGAIN",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
            :
         ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
            padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPending(list[index].eventId, borderColor), binding: EGBinding());
                },
                child: eventCard(index, list, borderColor),
              );
            })
    );
        // : Container(
        //     height: 100,
        //     child: Center(
        //       child: Text("No Events!!"),
        //     ),
        //   );
  }

  Widget eventCard(int index, List<EventListModels> list, Color borderColor,){
    return  Card(
      clipBehavior: Clip.antiAlias,
      borderOnForeground: true,
      elevation: 6,
      margin: EdgeInsets.all(4.0),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                color: borderColor,
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
                  Obx(
                        () =>
                  Text(
                    allEventController.egAllEventData.eventListModels[index].eventDate,
                    //"24-Mar-21",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Muli",
                        //fontWeight:
                        // FontWeight.bold
                        fontWeight: FontWeight.normal),
                     ),
                  ),
                  Obx(
                        () =>
                  Chip(
                    shape: StadiumBorder(
                        side: BorderSide(color: borderColor)),
                    backgroundColor: borderColor.withOpacity(0.1),
                    label: Text(
                        'Status: ${allEventController.egAllEventData.eventListModels[index].eventStatusText}'),
                  ),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                    () =>

                    Text(allEventController.egAllEventData.eventListModels[index].eventTypeText,
                      //list[index].eventTypeText,
                      //"Mason Meet",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold),
                    ),
                     ),
                    Obx(
                    () =>
                    Text(
                      "Inf. Planned : ${allEventController.egAllEventData.eventListModels[index].actualEventInflCount}",
                     // "Inf. Planned : ${list[index].actualEventInflCount}",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.normal),
                       ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                    () =>

                    Flexible(
                      flex: 2,
                      child: Text(
                        "Venue: ${allEventController.egAllEventData.eventListModels[index].eventVenue}",
                       // "Venue: ${list[index].eventVenue}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    ),
                    Obx(
                    () =>
                    Flexible(
                      flex: 3,
                      child: Text(
                        "Dealer(s) : ${allEventController.egAllEventData.eventListModels[index].dealerName}",
                        // "Dealer(s) : ${list[index].dealerName}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.normal),
                         ),
                      ),
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
                    Obx(
                    () =>

                    Text(
                      "EVENT ID: ${allEventController.egAllEventData.eventListModels[index].eventId}",
                     // "EVENT ID: ${list[index].eventId}",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.normal),
                    ),
                    ),
                    Obx(
                    () =>
                    Text(
                      "LEADS EXPECTED : ${allEventController.egAllEventData.eventListModels[index].expectedLeadsCount}",
                      //"LEADS EXPECTED : ${list[index].expectedLeadsCount}",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.normal),
                       ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }

  // EventStatus _getStatusFromResult(EventListModels eventStatusText) {
  //   switch (eventStatusText.eventStatusText) {
  //     case  'Pending Approval':
  //       return EventStatus.PendingApproval;
  //     case  'Approved':
  //       return EventStatus.Approved;
  //     case  'Rejected':
  //       return EventStatus.Rejected;
  //     case  'Completed':
  //       return EventStatus.Completed;
  //     case  'Cancelled':
  //       return EventStatus.Cancelled;
  //     case  'Not Submitted':
  //       return EventStatus.Notsubmitted;
  //     default:
  //       return EventStatus.PendingApproval;
  //   }
  // }


}
// enum Status {
//   PendingApproval,
//   Approved,
//   Rejected,
//   Completed,
//   Cancelled,
//   EventRejected,
//   NotSubmitted
// }
