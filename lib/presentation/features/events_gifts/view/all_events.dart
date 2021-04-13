import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';

class AllEvents extends StatefulWidget {
  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  ScrollController _scrollController;
  int option = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
                            color: option == 1
                                ? Colors.blue
                                : Colors.black12),
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
                            color: option == 2
                                ? Colors.blue
                                : Colors.black12),
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
                            color: option == 3
                                ? Colors.blue
                                : Colors.black12),
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
                            color: option == 4
                                ? Colors.blue
                                : Colors.black12),
                      ),
                    ),
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
                            color: option == 5
                                ? Colors.blue
                                : Colors.black12),
                      ),
                    ),
                  ),
                  //),
                  SizedBox(
                    width: 8,
                  ),

                  SizedBox(
                    width: 8,
                  ),
                ],
              )),
         // getList(bColor),
        ],
      ),
    );



//  @override
//  void dispose() {
//    _dashboardController.dispose();
//    super.dispose();
//  }
  }
  Widget getList(Color borderColor) {
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
                      color: borderColor,
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
                      //HexColor("#39B54A"),
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
