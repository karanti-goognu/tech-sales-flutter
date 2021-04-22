import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  AllEventController allEventController = Get.find();
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
        print('RESPONSE, ${data}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    // Obx(() => (
                    //     '' ==
                    //     StringConstants.empty)
                    //     ? Container()
                    //     :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          option = 1;
                        });
                      },
                      child: Chip(
                        label: Text('Archive'),
                        backgroundColor: option == 1
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                              color:
                                  option == 1 ? Colors.blue : Colors.black12),
                        ),
                      ),
                    ),
                    //),
                    SizedBox(
                      width: 8,
                    ),

                    // Obx(() => (
                    //     '' ==
                    //     StringConstants.empty)
                    //     ? Container()
                    //     :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          option = 2;
                        });
                      },
                      child: Chip(
                        label: Text('Not Submitted'),
                        backgroundColor: option == 2
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                              color:
                                  option == 2 ? Colors.blue : Colors.black12),
                        ),
                      ),
                    ),
                    //),

                    SizedBox(
                      width: 8,
                    ),
                    // Obx(() => (
                    //     '' ==
                    //     StringConstants.empty)
                    //     ? Container()
                    //     :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          option = 3;
                        });
                      },
                      child: Chip(
                        label: Text('Pending Approval'),
                        backgroundColor: option == 3
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                              color:
                                  option == 3 ? Colors.blue : Colors.black12),
                        ),
                      ),
                    ),
                    //),
                    SizedBox(
                      width: 8,
                    ),

                    // Obx(() => (
                    //     '' ==
                    //     StringConstants.empty)
                    //     ? Container()
                    //     :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          option = 4;
                        });
                      },
                      child: Chip(
                        label: Text('Cancelled'),
                        backgroundColor: option == 4
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                              color:
                                  option == 4 ? Colors.blue : Colors.black12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    // Obx(() => (
                    //     '' ==
                    //     StringConstants.empty)
                    //     ? Container()
                    //     :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          option = 5;
                        });
                      },
                      child: Chip(
                        label: Text('Request Rejected'),
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
                    //),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              )),
          (option == 1)
              ? getList(HexColor('#39B54A'), 'Planned')
              : (option == 2)
                  ? getList(HexColor('#808080'), 'Not Submitted')
                  : (option == 3)
                      ? getList(HexColor('#F9A61A'), 'Pending Approval')
                      : (option == 4)
                          ? getList(HexColor('#808080'), 'Cancelled')
                          : (option == 5)
                              ? getList(HexColor('#B00020'), 'Request Rejected')
                              : getList(HexColor('#39B54A'), 'Planned')
        ],
      ),
    );

//  @override
//  void dispose() {
//    _dashboardController.dispose();
//    super.dispose();
//  }
  }

  Widget getList(Color borderColor, String status) {
    return (allEventsModel.eventListModels != null && allEventsModel.eventListModels.length > 0)?
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: allEventsModel.eventStatusEntities.length,
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
                  borderColor,
                  //(
                  //allEventsModel.eventStatusEntities[index].eventStatusId == 1)
                  //    ? HexColor(hexColor)?
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
                  // HexColor("#39B54A"),
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
                          allEventsModel.eventListModels[index].eventDate,
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
                          label: Text('Status: ${allEventsModel.eventListModels[index].eventStatusText}'),
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
                            allEventsModel.eventListModels[index].eventTypeText,
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
                            "Inf. Planned : ${allEventsModel.eventListModels[index].actualEventInflCount}",
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
                            "Venue: ${allEventsModel.eventListModels[index].eventVenue}",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                          ),
                          // ),
                          //Obx(
                          // () =>
                          Text(
                            "Dealer(s) : ${allEventsModel.eventListModels[index].dealerName}",
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
                            "EVENT ID: ${allEventsModel.eventListModels[index].eventId}",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                          ),
                          // ),
                          //Obx(
                          // () =>
                          Text(
                            "LEADS EXPECTED : ${allEventsModel.eventListModels[index].expectedLeadsCount}",
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
        }):Container(
      child: Center(
        child: Text("No data!!"),
      ),
    );
  }
}
