import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/sr_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/request_updation.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/view/sitedetails.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/sr_filter.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceRequests extends StatefulWidget {
  @override
  _ServiceRequestsState createState() => _ServiceRequestsState();
}

class _ServiceRequestsState extends State<ServiceRequests> {
  ScrollController _scrollController;
  bool isVisible = true;
  List<Text> tabs = [
    Text('Resolution Status'),
    Text('Severity'),
    Text('Type of Request'),
  ];
  TabController tabController;

  ServiceRequestComplaintListModel serviceRequestComplaintListModel;
  SRListController eventController = Get.find();
  int totalFilters;

  getSRListData() async {
    // Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    await eventController.getAccessKey().then((value) async {
      await eventController.getSrListData(value.accessKey, 0).then((data){
        setState(() {
          serviceRequestComplaintListModel = data;
        });
      });
    });
    // Get.back();
  }

  _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // print('offset old value ${eventController.offset}');
      eventController.offset += 10;
      // print('offset new value ${eventController.offset}');
      await eventController.getAccessKey().then((value) async {
        await eventController.getSrListData(value.accessKey, eventController.offset).then((data) {
          setState(() {
            serviceRequestComplaintListModel = data;
          });
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    eventController.srListData.srComplaintListModal = null;
    getSRListData();
    //  print("scroll controller init");
    _scrollController = ScrollController();
    _scrollController..addListener(_scrollListener);
    //  print("scroll listener added");


  }

  @override
  void dispose() {
    eventController.dispose();
    eventController.offset = 0;
    print(eventController.offset);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 80,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Service Request &\nComplaint".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Muli"),
                  ),
                ),

                FlatButton(
                  onPressed: () =>
                      Get.bottomSheet(FilterWidget()).then((value) {
                        print(value);
                        setState(() {
                          // totalFilters = value.isEmpty ? value[3] : 0;
                          totalFilters = value[3];
                        });
                        print("------+$totalFilters");
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
                            border:
                            Border.all(color: Colors.black, width: 0.0),
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
                            style:
                            TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
      bottomNavigationBar: BottomNavigator(),
      body: serviceRequestComplaintListModel == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            totalCountAndTotalPotential(),
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
                controller: _scrollController,
                  itemCount: serviceRequestComplaintListModel
                      .srComplaintListModal.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
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
                          decoration: BoxDecoration(
                            border: Border(left: BorderSide(
                              width: 5,
                              color: serviceRequestComplaintListModel
                                  .srComplaintListModal[
                              index]
                                  .request !=
                                  'SERVICE REQUEST'
                                  ? HexColor('#9E3A0D')
                                  : HexColor('#F9A61A'),
                            )),

                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 50,
                                child: Column(
                                  children: [
                                    topRowWithSiteId(index),
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
                                    bottomRowWithRequestId(index),
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
                  serviceRequestComplaintListModel.respMsg ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding totalCountAndTotalPotential() {
    return Padding(
      padding:
      const EdgeInsets.only(top: 10.0, left: 15.0, bottom: 5, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
       //     child: Text("Total Count : ${(eventController.srListData.srComplaintListModal == null) ? 0 : eventController.srListData.srComplaintListModal.length}",
      child: Text("Total Count : ${(eventController.srListData.totalCount == null) ? 0 : eventController.srListData.totalCount}",

        style: TextStyle(
                fontFamily: "Muli",
                fontSize: 12,
                // color: HexColor("#FFFFFF99"),
              ),
            ),
          ),
          Flexible(
            child: Text(
              serviceRequestComplaintListModel.totalPotential != null
                  ? "Total Potential : ${serviceRequestComplaintListModel.totalPotential} MT"
                  : "Total Potential : 0 MT",
              style: TextStyle(
                fontFamily: "Muli",
                fontSize: 12,
                // color: HexColor("#FFFFFF99"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row topRowWithSiteId(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Date of SR ${serviceRequestComplaintListModel.srComplaintListModal[index].createdOn}",
                    style: TextStyle(
                        color: HexColor('#FF000099'),
                        fontSize: 12,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.normal
                      //fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Site ID (${serviceRequestComplaintListModel.srComplaintListModal[index].siteId})",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.bold
                      //fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "District: ${serviceRequestComplaintListModel.srComplaintListModal[index].district}",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.bold
                      //fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Transform(
                        transform: new Matrix4.identity()..scale(0.7),
                        child: Chip(
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: serviceRequestComplaintListModel
                                  .srComplaintListModal[index]
                                  .severity ==
                                  'HIGH'
                                  ? HexColor('#9E3A0D')
                                  : serviceRequestComplaintListModel
                                  .srComplaintListModal[index]
                                  .severity ==
                                  'MEDIUM'
                                  ? HexColor('#F9A61A')
                                  : HexColor('#0054A6'),
                            ),
                          ),
                          backgroundColor: HexColor(
                              serviceRequestComplaintListModel
                                  .srComplaintListModal[index]
                                  .severity ==
                                  'HIGH'
                                  ? "#FFCD0014"
                                  : serviceRequestComplaintListModel
                                  .srComplaintListModal[index]
                                  .severity ==
                                  'MEDIUM'
                                  ? "#FFCD00"
                                  : "#0054A6")
                              .withOpacity(0.1),
                          label: Text(
                            "${serviceRequestComplaintListModel.srComplaintListModal[index].severity}",
                            style: TextStyle(
                                color: serviceRequestComplaintListModel
                                    .srComplaintListModal[index]
                                    .severity ==
                                    'HIGH'
                                    ? HexColor('#9E3A0D')
                                    : serviceRequestComplaintListModel
                                    .srComplaintListModal[index]
                                    .severity ==
                                    'MEDIUM'
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "",
                        //  textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          //fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Text(
                        "Site Pt: ",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 15,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
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
                      color: HexColor('#000000'),
                      fontSize: 12,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.bold
                    //fontWeight: FontWeight.normal
                  ),
                ),
                // Expanded(
                //   child: Container(),
                // ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  // padding: const EdgeInsets.only(left: 1.0, top: 20),
                  child: Transform(
                    transform: new Matrix4.identity()..scale(0.7),
                    alignment: Alignment.centerRight,
                    child: Chip(
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: HexColor("#666666"),
                        ),
                      ),
                      backgroundColor: HexColor("#00000014").withOpacity(0.1),
                      label: Text(
                        "Status: ${serviceRequestComplaintListModel.srComplaintListModal[index].status}",
                        style: TextStyle(
                            color: HexColor("#666666"),
                            fontSize: 12,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
                          //fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child:Container()
                    ),
                    Icon(
                      Icons.call,
                      color: HexColor("#8DC63F"),
                    ),
                    GestureDetector(
                      child: Text(
                        "${serviceRequestComplaintListModel.srComplaintListModal[index].siteContact}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        launch('tel:${serviceRequestComplaintListModel.srComplaintListModal[index].siteContact}');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding bottomRowWithRequestId(int index) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Request Id (${serviceRequestComplaintListModel.srComplaintListModal[index].srComplaintId}) "
                  .toUpperCase(),
              style: TextStyle(
                  color: HexColor('#002A64'),
                  fontSize: 12,
                  fontFamily: "Muli",
                  fontWeight: FontWeight.bold
                //fontWeight: FontWeight.normal
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(
                    SiteDetails(
                      siteId: serviceRequestComplaintListModel
                          .srComplaintListModal[index].siteId
                          .toString(),
                    ),
                    transition: Transition.rightToLeft);
              },
              child: Text(
                "${serviceRequestComplaintListModel.srComplaintListModal[index].summarySrOfSite}",
                textAlign: TextAlign.right,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: HexColor('#007CBF'),
                    fontSize: 10,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.bold
                  //fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}