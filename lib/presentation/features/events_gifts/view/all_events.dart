import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class AllEvents extends StatefulWidget {
  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  AllEventsModel allEventsModel;
  EventListModels _eventListModels;
  AllEventController allEventController = Get.find();
  List<EventListModels> pending = [];
  List<EventListModels> approved = [];
  List<EventListModels> rejected = [];
  List<EventListModels> completed = [];
  List<EventListModels> cancelled = [];
  List<EventListModels> eventRejected = [];
  List<EventListModels> notSubmitted = [];

  ScrollController _scrollController;
  int option = 1;
  String hexColor;

  @override
  void initState() {
    getAllEventsData();

    super.initState();
  }

  getAllEventsData() async {
    await allEventController.getAccessKey().then((value) async {
      print(value.accessKey);
      await allEventController.getAllEventData(value.accessKey).then((data) {
        setState(() {
          allEventsModel = data;
        });
      });
    });
  }

  getSortedData() {
    if (allEventsModel != null && allEventsModel.eventListModels != null) {
      for (int i = 0; i < allEventsModel.eventListModels.length; i++) {
        if (allEventsModel.eventListModels[i].eventStatusId == 1) {
          pending = allEventsModel.eventListModels;
          print('PENDING : $pending');
        } else if (allEventsModel.eventListModels[i].eventStatusId == 2) {
          approved = allEventsModel.eventListModels;
          print('APPROVED : $approved');
        } else if (allEventsModel.eventListModels[i].eventStatusId == 3) {
          rejected = allEventsModel.eventListModels;
          print('rejected : $_eventListModels');
        } else if (allEventsModel.eventListModels[i].eventStatusId == 4) {
          completed = allEventsModel.eventListModels;
          print('completed : $_eventListModels');
        } else if (allEventsModel.eventListModels[i].eventStatusId == 5) {
          cancelled = allEventsModel.eventListModels;
          print('Cancelled : $_eventListModels');
        } else if (allEventsModel.eventListModels[i].eventStatusId == 6) {
          eventRejected = allEventsModel.eventListModels;
          print('Event Rejected : $_eventListModels');
        } else if (allEventsModel.eventListModels[i].eventStatusId == 7) {
          notSubmitted = allEventsModel.eventListModels;
          print('Not Submitted : $_eventListModels');
        }
      }
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
          // SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //             width: 8,
          //           ),
          //           // Obx(() => (
          //           //     '' ==
          //           //     StringConstants.empty)
          //           //     ? Container()
          //           //     :
          //           GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 option = 1;
          //               });
          //             },
          //             child: Chip(
          //               label: Text('Archive'),
          //               backgroundColor: option == 1
          //                   ? Colors.blue.withOpacity(0.2)
          //                   : Colors.white,
          //               shape: StadiumBorder(
          //                 side: BorderSide(
          //                     color:
          //                         option == 1 ? Colors.blue : Colors.black12),
          //               ),
          //             ),
          //           ),
          //           // ),
          //           SizedBox(
          //             width: 8,
          //           ),
          //
          //           // Obx(() => (
          //           //     '' ==
          //           //     StringConstants.empty)
          //           //     ? Container()
          //           //     :
          //           GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 option = 2;
          //                 getSortedData();
          //                 // print('PENDING : $pending');
          //                 // print('APPROVED: $approved');
          //               });
          //             },
          //             child: Chip(
          //               label: Text('Not Submitted'),
          //               backgroundColor: option == 2
          //                   ? Colors.blue.withOpacity(0.2)
          //                   : Colors.white,
          //               shape: StadiumBorder(
          //                 side: BorderSide(
          //                     color:
          //                         option == 2 ? Colors.blue : Colors.black12),
          //               ),
          //             ),
          //           ),
          //           //),
          //
          //           SizedBox(
          //             width: 8,
          //           ),
          //           // Obx(() => (
          //           //     '' ==
          //           //     StringConstants.empty)
          //           //     ? Container()
          //           //     :
          //           GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 option = 3;
          //               });
          //             },
          //             child: Chip(
          //               label: Text('Pending Approval'),
          //               backgroundColor: option == 3
          //                   ? Colors.blue.withOpacity(0.2)
          //                   : Colors.white,
          //               shape: StadiumBorder(
          //                 side: BorderSide(
          //                     color:
          //                         option == 3 ? Colors.blue : Colors.black12),
          //               ),
          //             ),
          //           ),
          //           //),
          //           SizedBox(
          //             width: 8,
          //           ),
          //
          //           // Obx(() => (
          //           //     '' ==
          //           //     StringConstants.empty)
          //           //     ? Container()
          //           //     :
          //           GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 option = 4;
          //               });
          //             },
          //             child: Chip(
          //               label: Text('Cancelled'),
          //               backgroundColor: option == 4
          //                   ? Colors.blue.withOpacity(0.2)
          //                   : Colors.white,
          //               shape: StadiumBorder(
          //                 side: BorderSide(
          //                     color:
          //                         option == 4 ? Colors.blue : Colors.black12),
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             width: 8,
          //           ),
          //           // Obx(() => (
          //           //     '' ==
          //           //     StringConstants.empty)
          //           //     ? Container()
          //           //     :
          //           GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 option = 5;
          //               });
          //             },
          //             child: Chip(
          //               label: Text('Request Rejected'),
          //               backgroundColor: option == 5
          //                   ? Colors.blue.withOpacity(0.2)
          //                   : Colors.white,
          //               shape: StadiumBorder(
          //                 side: BorderSide(
          //                     color:
          //                         option == 5 ? Colors.blue : Colors.black12),
          //               ),
          //             ),
          //           ),
          //           //),
          //           SizedBox(
          //             width: 8,
          //           ),
          //         ],
          //       ),
          //     )),

          (option == 1)
              ? getList(HexColor('#F9A61A'), pending)
              : (option == 2)
                  ? getList(HexColor('#39B54A'), approved)
                  : (option == 3)
                      ? getList(HexColor('#B00020'), rejected)
                      : (option == 4)
                          ? getList(HexColor('#808080'), completed)
                          : (option == 5)
                              ? getList(HexColor('#808080'), cancelled)
                              : (option == 6)
                                  ? getList(HexColor('#B00020'), eventRejected)
                                  : (option == 7)
                                      ? getList(
                                          HexColor('#808080'), notSubmitted)
                                      : getList(HexColor('#F9A61A'), pending)
        ],
      ),
    );

//  @override
//  void dispose() {
//    _dashboardController.dispose();
//    super.dispose();
//  }
  }

  Widget getStatusList() {
    return (allEventsModel != null &&
            allEventsModel.eventStatusEntities != null &&
            allEventsModel.eventStatusEntities.length > 0)
        ? Container(
            padding: EdgeInsets.only(
              top: ScreenUtil().setSp(5),
            ),
            height: ScreenUtil().setSp(45),
            child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: allEventsModel.eventStatusEntities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          option = allEventsModel
                              .eventStatusEntities[index].eventStatusId;
                        });
                      },
                      child: Chip(
                        label: Text(allEventsModel
                            .eventStatusEntities[index].eventStatusText),
                        backgroundColor: option == 5
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                              color:
                                  option == 5 ? Colors.blue : Colors.black12),
                        ),
                      ),
                    ),
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
    getSortedData();
    return (allEventsModel != null &&
            allEventsModel.eventListModels != null &&
            allEventsModel.eventListModels.length > 0 &&
            list != null)
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
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
                                  side: BorderSide(color: borderColor)),
                              backgroundColor: borderColor.withOpacity(0.1),
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
                                //"Mason Meet",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.bold),
                              ),
                              // ),
                              //Obx(
                              // () =>
                              Text(
                                "Inf. Planned : ${list[index].actualEventInflCount}",
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
                                "Venue: ${list[index].eventVenue}",
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
              );
            })
        : Container(
            child: Center(
              child: Text("No data!!"),
            ),
          );
  }
}
