import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/sr_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/request_updation.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/sitedetails.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/sr_filter.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/test.dart';
import 'package:get/get.dart';

class ServiceRequests extends StatefulWidget {
  @override
  _ServiceRequestsState createState() => _ServiceRequestsState();
}

class _ServiceRequestsState extends State<ServiceRequests> {
  bool isVisible = true;
  List<Text> tabs = [
    Text('Resolution Status',),
    Text('Severity'),
    Text('Type of Request'),
  ];
  TabController tabController;
  SpeedDialController _controller = SpeedDialController();

  ServiceRequestComplaintListModel serviceRequestComplaintListModel;
  SRListController eventController = Get.find();
  UpdateServiceRequestController _updateServiceRequestController = Get.find();
  int totalFilters;
  var data;
  getSRListData() async {
    await eventController.getAccessKey().then((value) async {
      data = await eventController.getSrListData(value.accessKey);
    });
  }

  @override
  void initState() {
    getSRListData().whenComplete(() {
      setState(() {
        serviceRequestComplaintListModel = data;
      });
    });
    super.initState();
  }

  Widget _buildFloatingActionButton({bool isVisible}) {
    final TextStyle customStyle =
        TextStyle(inherit: false, color: Colors.black, fontSize: 12);
    final icons = [
      SpeedDialAction(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/img2.png',
            height: 23,
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('Add Lead', style: customStyle),
        ),
      ),
      SpeedDialAction(
        child: Icon(Icons.mode_edit),
        label: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('Add MWP', style: customStyle),
        ),
      ),
      SpeedDialAction(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/img4.png',
            height: 23,
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('Add Influencer', style: customStyle),
        ),
      ),
      SpeedDialAction(
        child: Icon(Icons.list),
        label: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('Add SR / Complaint', style: customStyle),
        ),
      ),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Icon(
        Icons.add,
        color: Colors.black,
        key: UniqueKey(),
      ),
      screenColor: Colors.black.withOpacity(0.3),
      childOnUnfold: Icon(
        Icons.clear,
        color: Colors.black,
      ),
      useRotateAnimation: true,
      onAction: _onSpeedDialAction,
      controller: _controller,
      isDismissible: true,
      backgroundColor: Colors.amber,
    );
  }

  _onSpeedDialAction(int selectedActionIndex) {
    print('$selectedActionIndex Selected');
    setState(() {
      isVisible = false;
    });
    switch (selectedActionIndex) {
      case 0:
        Get.toNamed(Routes.ADD_CALENDER_SCREEN);
        break;

      case 1:
        Get.toNamed(Routes.SERVICE_REQUESTS);
        break;

      case 2:
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
        break;

      case 3:
        Get.toNamed(Routes.SERVICE_REQUEST_CREATION).whenComplete(
          () => setState(() {
            isVisible = true;
          }),
        );

        break;

      default:
        print("Invalid choice");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                  "Service Request &\nComplaint".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Muli"),
                ),
                FlatButton(
                  onPressed: () =>
                      Get.bottomSheet(FilterWidget()).then((value) {
                        print(value);

                        eventController.getAccessKey().then((accessKeyModel) {
                      eventController
                          .getSrListDataWithFilters(accessKeyModel.accessKey,
                              value[0], value[1], value[2])
                          .then((data) {
                        // print(data.toJson());
                        setState(() {
                          serviceRequestComplaintListModel = data;
                        });
                      });
                    });
                    setState(() {
                      totalFilters = value.isEmpty ? value[3] : 0;
                    });
                  }),
                  // filterBottomSheet,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 0.0),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Center(
                            child: Text(
                              totalFilters != null
                                  ? totalFilters.toString()
                                  : 0.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  //fontFamily: 'Raleway',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'FILTER',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          // isVisible ? _buildFloatingActionButton() : null,
          // isVisible ?  : null,
          Container(
        height: 68.0,
        width: 68.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              // gv.fromLead = false;
              Get.toNamed(
                Routes.SERVICE_REQUEST_CREATION,
              );
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
                          serviceRequestComplaintListModel.totalCount != null
                              ? "Total Count : ${serviceRequestComplaintListModel.totalCount}"
                              : "Total Count : 0",
                          style: TextStyle(
                            fontFamily: "Muli",
                            fontSize: 12,
                            // color: HexColor("#FFFFFF99"),
                          ),
                        ),
                        Text(
                          serviceRequestComplaintListModel.totalPotential !=
                                  null
                              ? "Total Potential : ${serviceRequestComplaintListModel.totalPotential} MT"
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
                  serviceRequestComplaintListModel.srComplaintListModal != null
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: serviceRequestComplaintListModel
                                  .srComplaintListModal.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // _updateServiceRequestController.siteId = serviceRequestComplaintListModel
                                    //     .srComplaintListModal[index]
                                    //     .srComplaintId;
                                    Get.to(
                                      RequestUpdation(
                                          id: serviceRequestComplaintListModel
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              color: serviceRequestComplaintListModel
                                                          .srComplaintListModal[
                                                              index]
                                                          .request !=
                                                      'SERVICE REQUEST'
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              "Date of SR ${serviceRequestComplaintListModel.srComplaintListModal[index].createdOn}",
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      '#FF000099'),
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      "Muli",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal
                                                                  //fontWeight: FontWeight.normal
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              "Site ID (${serviceRequestComplaintListModel.srComplaintListModal[index].siteId})",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      "Muli",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold
                                                                  //fontWeight: FontWeight.normal
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              "District: ${serviceRequestComplaintListModel.srComplaintListModal[index].district}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38,
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
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            1.0),
                                                                child: Chip(
                                                                  shape:
                                                                      StadiumBorder(
                                                                    side:
                                                                        BorderSide(
                                                                      color: serviceRequestComplaintListModel.srComplaintListModal[index].severity ==
                                                                              'HIGH'
                                                                          ? HexColor(
                                                                              '#9E3A0D')
                                                                          : serviceRequestComplaintListModel.srComplaintListModal[index].severity == 'MEDIUM'
                                                                              ? HexColor('#F9A61A')
                                                                              : HexColor('#0054A6'),
                                                                    ),
                                                                  ),
                                                                  backgroundColor: HexColor(serviceRequestComplaintListModel.srComplaintListModal[index].severity ==
                                                                              'HIGH'
                                                                          ? "#FFCD0014"
                                                                          : serviceRequestComplaintListModel.srComplaintListModal[index].severity ==
                                                                                  'MEDIUM'
                                                                              ? "#FFCD00"
                                                                              : "#0054A6")
                                                                      .withOpacity(
                                                                          0.1),
                                                                  label: Text(
                                                                    "${serviceRequestComplaintListModel.srComplaintListModal[index].severity}",
                                                                    style: TextStyle(
                                                                        color: serviceRequestComplaintListModel.srComplaintListModal[index].severity == 'HIGH'
                                                                            ? HexColor('#9E3A0D')
                                                                            : serviceRequestComplaintListModel.srComplaintListModal[index].severity == 'MEDIUM'
                                                                                ? HexColor('#F9A61A')
                                                                                : HexColor('#0054A6'),
                                                                        fontSize: 12,
                                                                        fontFamily: "Muli",
                                                                        fontWeight: FontWeight.bold
                                                                        //fontWeight: FontWeight.normal
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0),
                                                                child: Text(
                                                                  "",
                                                                  //  textAlign: TextAlign.start,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
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
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 10, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8.0,
                                                                    bottom: 10),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Site Pt: ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black38,
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          "Muli",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold
                                                                      //fontWeight: FontWeight.normal
                                                                      ),
                                                                ),
                                                                Text(
                                                                  "${serviceRequestComplaintListModel.srComplaintListModal[index].sitePotential}MT",
                                                                  style: TextStyle(
                                                                      // color: Colors.black38,
                                                                      fontSize: 15,
                                                                      fontFamily: "Muli",
                                                                      fontWeight: FontWeight.bold
                                                                      //fontWeight: FontWeight.normal
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            "SLA Remaining: ${serviceRequestComplaintListModel.srComplaintListModal[index].slaRemaining}",
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    '#000000'),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold
                                                                //fontWeight: FontWeight.normal
                                                                ),
                                                          ),
                                                          // Expanded(
                                                          //   child: Container(),
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 1.0,
                                                                    top: 20),
                                                            child: Chip(
                                                              shape:
                                                                  StadiumBorder(
                                                                side:
                                                                    BorderSide(
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
                                                                "Status: ${serviceRequestComplaintListModel.srComplaintListModal[index].status}",
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        "#666666"),
                                                                    fontSize:
                                                                        12,
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 4, 8, 0),
                                                  child: Container(
                                                    color: Colors.grey,
                                                    width: double.infinity,
                                                    height: 1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Request Id (${serviceRequestComplaintListModel.srComplaintListModal[index].srComplaintId}) "
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '#002A64'),
                                                            fontSize: 12,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.bold
                                                            //fontWeight: FontWeight.normal
                                                            ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              SiteDetails(
                                                                siteId: serviceRequestComplaintListModel
                                                                    .srComplaintListModal[
                                                                        index]
                                                                    .siteId
                                                                    .toString(),
                                                              ),
                                                              transition: Transition
                                                                  .rightToLeft);
                                                        },
                                                        child: Text(
                                                          "${serviceRequestComplaintListModel.srComplaintListModal[index].summarySrOfSite}",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color: HexColor(
                                                                  '#007CBF'),
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
                        )
                      : Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              serviceRequestComplaintListModel.respMsg,
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
