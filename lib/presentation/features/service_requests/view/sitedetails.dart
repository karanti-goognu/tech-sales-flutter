import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/sr_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/request_updation.dart';


class SiteDetails extends StatefulWidget {
  final siteId;
  SiteDetails({this.siteId});
  @override
  _SiteDetailsState createState() => _SiteDetailsState();
}

class _SiteDetailsState extends State<SiteDetails> {
  ServiceRequestComplaintListModel siteListModel;

  SRListController eventController = Get.find();
  var data;

  getData() async {
    await eventController.getAccessKey().then((value) async {
      data =
          await eventController.getSiteListData(value.accessKey, widget.siteId);
    });
  }

  @override
  void initState() {
    getData().whenComplete(() {
      if (mounted) {
        // Update data.
        setState(() {
          siteListModel = data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 120,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Site ID (${widget.siteId})".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Muli"),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 68.0,
        width: 68.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: ColorConstants.checkinColor,
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigator(),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 15.0, bottom: 5, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          siteListModel.totalCount != null
                              ? "Total Count : ${siteListModel.totalCount}"
                              : "Total Count : 0",
                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: 12,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ),
                        Text(
                          siteListModel.totalPotential != null
                              ? "Total Potential : ${siteListModel.totalPotential} MT"
                              : "Total Potential : 0 MT",
                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: 12,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: HexColor('#F9A61A'),
                        radius: 10,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Service Request',
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: HexColor('#9E3A0D'),
                        radius: 10,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Complaint',
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  siteListModel.srComplaintListModal != null?
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: siteListModel.srComplaintListModal.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(
                                  RequestUpdation(
                                      id: siteListModel
                                          .srComplaintListModal[index]
                                          .srComplaintId),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                borderOnForeground: true,
                                elevation: 6,
                                margin: EdgeInsets.all(5.0),
                                color: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          color: siteListModel
                                                      .srComplaintListModal[index]
                                                      .request ==
                                                  'COMPLAINT'
                                              ? HexColor('#9E3A0D')
                                              : HexColor('#F9A61A'),
                                          height: 165,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 50,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                        child: Text(
                                                          "Date of SR ${siteListModel.srComplaintListModal[index].createdOn}",
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  '#FF000099'),
                                                              fontSize: 12,
                                                              fontFamily: "Muli",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal
                                                              //fontWeight: FontWeight.normal
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                        child: Text(
                                                          "Site ID (${siteListModel.srComplaintListModal[index].siteId})",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily: "Muli",
                                                              fontWeight:
                                                                  FontWeight.bold
                                                              //fontWeight: FontWeight.normal
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                        child: Text(
                                                          "District: ${siteListModel.srComplaintListModal[index].district}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black38,
                                                              fontSize: 12,
                                                              fontFamily: "Muli",
                                                              fontWeight:
                                                                  FontWeight.bold
                                                              //fontWeight: FontWeight.normal
                                                              ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1.0),
                                                            child: Chip(
                                                              shape:
                                                                  StadiumBorder(
                                                                side: BorderSide(
                                                                    color: siteListModel
                                                                                .srComplaintListModal[
                                                                                    index]
                                                                                .severity ==
                                                                            'HIGH'
                                                                        ? HexColor(
                                                                            '#9E3A0D')
                                                                        : siteListModel.srComplaintListModal[index].severity ==
                                                                                'MEDIUM'
                                                                            ? HexColor(
                                                                                '#F9A61A')
                                                                            : HexColor(
                                                                                '#0054A6'),
                                                                ),
                                                              ),
                                                              backgroundColor: HexColor(siteListModel
                                                                              .srComplaintListModal[
                                                                                  index]
                                                                              .severity ==
                                                                          'HIGH'
                                                                      ? "#FFCD0014"
                                                                      : siteListModel.srComplaintListModal[index].severity ==
                                                                              'MEDIUM'
                                                                          ? "#FFCD00"
                                                                          : "#0054A6")
                                                                  .withOpacity(
                                                                      0.1),
                                                              label: Text(
                                                                "${siteListModel.srComplaintListModal[index].severity}",
                                                                style: TextStyle(
                                                                    color: siteListModel
                                                                                .srComplaintListModal[
                                                                                    index]
                                                                                .severity ==
                                                                            'HIGH'
                                                                        ? HexColor(
                                                                            '#9E3A0D')
                                                                        : siteListModel.srComplaintListModal[index].severity ==
                                                                                'MEDIUM'
                                                                            ? HexColor(
                                                                                '#F9A61A')
                                                                            : HexColor(
                                                                                '#0054A6'),
                                                                    fontSize: 12,
                                                                    fontFamily:
                                                                        "Muli",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold
                                                                    //fontWeight: FontWeight.normal
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              "",
                                                              //  textAlign: TextAlign.start,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                //fontWeight: FontWeight.normal
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 10, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 8.0,
                                                                bottom: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Site Pt: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Muli",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold
                                                                  //fontWeight: FontWeight.normal
                                                                  ),
                                                            ),
                                                            Text(
                                                              "${siteListModel.srComplaintListModal[index].sitePotential}MT",
                                                              style: TextStyle(
                                                                  // color: Colors.black38,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Muli",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold
                                                                  //fontWeight: FontWeight.normal
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "SLA Remaining: ${siteListModel.srComplaintListModal[index].slaRemaining}",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '#000000'),
                                                            fontSize: 12,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                      // Expanded(
                                                      //   child: Container(),
                                                      // ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 1.0,
                                                                top: 20),
                                                        child: Chip(
                                                          shape: StadiumBorder(
                                                            side: BorderSide(
                                                              color: HexColor(
                                                                  "#666666"),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              HexColor(
                                                                      "#00000014")
                                                                  .withOpacity(
                                                                      0.1),
                                                          label: Text(
                                                            "Status: ${siteListModel.srComplaintListModal[index].status}",
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "#666666"),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  8, 4, 8, 0),
                                              child: Container(
                                                color: Colors.grey,
                                                width: double.infinity,
                                                height: 1,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Request Id (${siteListModel.srComplaintListModal[index].srComplaintId}) "
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color:
                                                            HexColor('#002A64'),
                                                        fontSize: 12,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.bold
                                                        //fontWeight: FontWeight.normal
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                      : Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        siteListModel.respMsg,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
