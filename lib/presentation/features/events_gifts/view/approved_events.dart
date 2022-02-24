import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/approved_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/end_event.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class ApprovedEvents extends StatefulWidget {
  @override
  _ApprovedEventsState createState() => _ApprovedEventsState();
}

class _ApprovedEventsState extends State<ApprovedEvents> {
  ApprovedEventsModel? approvedEventsModel;
  ScrollController? _scrollController;
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
      });
  }



  getSortedData() {
    DateTime now = DateTime.now();
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;

    if (approvedEventsModel != null && approvedEventsModel!.eventListModels != null) {

      for (int i = 0; i < approvedEventsModel!.eventListModels!.length; i++) {
        String date = approvedEventsModel!.eventListModels![i].eventDate!;
        DateTime eventDt = DateTime.parse(date);
        int yearEvent = eventDt.year;
        int monthEvent = eventDt.month;
        int dayEvent = eventDt.day;

       if((year == yearEvent && month == monthEvent && day == dayEvent) ||
           (year == yearEvent && month == monthEvent && dayEvent - day == 1)){
         current.add(approvedEventsModel!.eventListModels![i]);

       }else if((year == yearEvent && (month == monthEvent) && (dayEvent - day > 1)) ||
           (year - yearEvent > 0 && (month - monthEvent > 0 ))){
         upcoming.add(approvedEventsModel!.eventListModels![i]);

       }else if(year == yearEvent && (month == monthEvent || monthEvent - month < 0)){
         past.add(approvedEventsModel!.eventListModels![i]);
       }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
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
    return (approvedEventsModel != null &&
            approvedEventsModel!.eventListModels != null &&
            approvedEventsModel!.eventListModels!.length > 0 )

        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
            padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (list[index].eventStatusText == StringConstants.approved) {
                    Get.to(
                            () => DetailViewEvent(list[index].eventId),
                        binding: EGBinding());
                  }else{
                    Get.to(() => EndEvent(list[index].eventId,3));
                  }
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
                                list[index].eventDate!,
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
                                  list[index].eventTypeText!,
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

                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    list[index].eventVenue!,
                                    //"Venue:",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                // ),
                                //Obx(
                                // () =>
                                Flexible(
                                  flex: 3,
                                  child:

                                  // Text(
                                  //   "Dealer(s) : ${list[index].dealerName}",
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: TextStyle(
                                  //       fontSize: 15,
                                  //       fontFamily: "Muli",
                                  //       fontWeight: FontWeight.normal),
                                  //   // ),
                                  // ),

                                   ( list[index].dealerName != null)?
                                Text(
                                  "Dealer(s) : ${list[index].dealerName}",
                                  //"Dealer(s) : ${allEventController.egAllEventData.eventListModels[index].dealerName}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.normal),
                                ):Text(
                                  "Dealer(s) : -",
                                  //"Dealer(s) : ${allEventController.egAllEventData.eventListModels[index].dealerName}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.normal),
                                )
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
