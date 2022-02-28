import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_pending.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/end_event.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
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
    getAllEventsData();

    super.initState();
  }

  getAllEventsData() async {
    await allEventController.getAllEventData().then((data) {
      setState(() {
        allEventsModel = data;
      });

      getSortedData();
    });
  }

  getSortedData() {
    if (allEventsModel != null && allEventsModel.eventListModels != null) {
      for (int i = 0; i < allEventsModel.eventListModels.length; i++) {
        if (allEventsModel.eventListModels[i].eventStatusText ==
            StringConstants.pendingApproval) {
          pending.add(allEventsModel.eventListModels[i]);
        } else if (allEventsModel.eventListModels[i].eventStatusText ==
            StringConstants.approved) {
          approved.add(allEventsModel.eventListModels[i]);
        } else if (allEventsModel.eventListModels[i].eventStatusText ==
            StringConstants.rejected) {
          rejected.add(allEventsModel.eventListModels[i]);
        } else if (allEventsModel.eventListModels[i].eventStatusText ==
            StringConstants.completed) {
          completed.add(allEventsModel.eventListModels[i]);
        } else if (allEventsModel.eventListModels[i].eventStatusText ==
            StringConstants.cancelled) {
          cancelled.add(allEventsModel.eventListModels[i]);
        } else if (allEventsModel.eventListModels[i].eventStatusText ==
            StringConstants.notSubmitted) {
          notSubmitted.add(allEventsModel.eventListModels[i]);
        }
      }
    } else {}
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
          Obx(()=>!allEventController.isFilterApplied  ?getStatusList():Container()),
          Obx(
              ()=>
              allEventController.isFilterApplied  ?getFilteredList():
              (option == StringConstants.pendingApproval)
                  ? getListForPending(ColorConstants.eventPending, pending)
                  : (option == StringConstants.approved)
                  ? getList(ColorConstants.eventApproved, approved)
                  : (option == StringConstants.rejected)
                  ? getListForPending(
                  ColorConstants.eventRejected, rejected)
                  : (option == StringConstants.completed)
                  ? getListForCompleted(ColorConstants.eventCompleted, completed)
                  : (option == StringConstants.cancelled)
                  ? getList(
                  ColorConstants.eventCancelled, cancelled)
                  : (option == StringConstants.notSubmitted)
                  ? getListForPending(
                  HexColor('#808080'), notSubmitted)
                  : getList(HexColor('#F9A61A'), pending)
          )
        ],
      ),
    );
  }



  Widget getStatusList() {
    return (allEventsModel != null &&
            allEventsModel.eventStatusEntities != null &&
            allEventsModel.eventStatusEntities.length > 0)
        ? Container(
            padding: EdgeInsets.only(
              top: 5.sp,
            ),
            height: 45.sp,
            child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: allEventController
                    .egAllEventData.eventStatusEntities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FilterChip(
                      onSelected: (bool selected) {
                        setState(() {
                          option = allEventsModel
                              .eventStatusEntities[index].eventStatusText;

                          //allEventController.egAllEventData.eventStatusEntities[index].eventStatusText;
                        });
                      },
                      selectedColor: Colors.blue.withOpacity(0.2),
                      label: Text(allEventsModel
                          .eventStatusEntities[index].eventStatusText),
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
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailViewEvent(list[index].eventId),
                      binding: EGBinding());
                },
                child: eventCard(index, list, borderColor),
              );
            })
        : Container(
            child: Center(
              child: Text("No data!!"),
            ),
          );
  }
  HexColor _color(int id){
    switch(id){
      case 1:return HexColor('#F9A61A');
      case 2:return HexColor('#39B54A');
      case 3:return HexColor('#B00020');
      case 4:return HexColor('#39B54A');
      case 5:return HexColor('#B00020');
      case 6:return HexColor('#000000');
      case 7:return HexColor('#808080');
    }
  }

  Widget getFilteredList(){
    return (allEventsModel != null &&
        allEventsModel.eventListModels != null &&
        allEventsModel.eventListModels.length > 0 &&
        allEventController.egAllEventData.eventListModels != null)
        ?
    ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: allEventController.egAllEventData.eventListModels.length,
        padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => DetailPending(allEventController.egAllEventData.eventListModels[index].eventId, _color(allEventController.egAllEventData.eventListModels[index].eventStatusId)),
                  binding: EGBinding());
            },
            child: eventCard(index, allEventController.egAllEventData.eventListModels ,  _color(allEventController.egAllEventData.eventListModels[index].eventStatusId),
            ),
          );
        })
        : Container(
      height: 100,
      child: Center(
        child: Text("No Events!!"),
      ),
    );
  }

  Widget getListForPending(Color borderColor, List<EventListModels> list) {
    return (allEventsModel != null &&
            allEventsModel.eventListModels != null &&
            allEventsModel.eventListModels.length > 0 &&
            list != null)
        ?
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
            padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPending(list[index].eventId, borderColor),
                      binding: EGBinding());
                },
                child: eventCard(index, list, borderColor),
              );
            })
        : Container(
            height: 100,
            child: Center(
              child: Text("No Events!!"),
            ),
          );
  }

  Widget getListForCompleted(Color borderColor, List<EventListModels> list) {
    return (allEventsModel != null &&
        allEventsModel.eventListModels != null &&
        allEventsModel.eventListModels.length > 0 &&
        list != null)
        ?
    ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: list.length,
        padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Get.to(() => DetailPending(list[index].eventId, borderColor),
              //     binding: EGBinding());
              Get.to(() => EndEvent(list[index].eventId,1));
            },
            child: eventCard(index, list, borderColor),
          );
        })
        : Container(
      height: 100,
      child: Center(
        child: Text("No Events!!"),
      ),
    );
  }

  Widget eventCard(
    int index,
    List<EventListModels> list,
    Color borderColor,
  ) {
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
                  // Obx(
                  //   () =>
                  Text(
                    list[index].eventDate,
                    //"24-Mar-21",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Muli",
                        //fontWeight:
                        // FontWeight.bold
                        fontWeight: FontWeight.normal),
                  ),
                  // ),
                  // Obx(
                  //   () =>
                  Chip(
                    shape: StadiumBorder(side: BorderSide(color: borderColor)),
                    backgroundColor: borderColor.withOpacity(0.1),
                    label: Text('Status: ${list[index].eventStatusText}'),
                  ),
                  // )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Obx(
                //   () =>
                Text(
                  list[index].eventTypeText,
                  //allEventController.egAllEventData.eventListModels[index].eventTypeText,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.bold),
                ),
                // ),
                // Obx(
                //   () =>
                Text(
                  "Inf. Planned : ${list[index].actualEventInflCount}",
                  // "Inf. Planned : ${allEventController.egAllEventData.eventListModels[index].actualEventInflCount}",

                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.normal),
                ),
                //),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Obx(
                //   () =>
                Flexible(
                  flex: 2,
                  child: Text(
                    "Venue: ${list[index].eventVenue}",
                    //"Venue: ${allEventController.egAllEventData.eventListModels[index].eventVenue}",

                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // ),
                // Obx(
                //   () =>
                Flexible(
                  flex: 3,
                  child: ( list[index].dealerName != null)?
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
                //  ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Obx(
                //   () =>
                Text(
                  "EVENT ID: ${list[index].eventId}",
                  //"EVENT ID: ${allEventController.egAllEventData.eventListModels[index].eventId}",

                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.normal),
                ),
                // ),
                // Obx(
                //   () =>
                Text(
                  "LEADS EXPECTED : ${list[index].expectedLeadsCount}",
                  //"LEADS EXPECTED : ${allEventController.egAllEventData.eventListModels[index].expectedLeadsCount}",

                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.normal),
                ),
                // ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
