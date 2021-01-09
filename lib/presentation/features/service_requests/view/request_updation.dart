import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/sr_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_action.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_details.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_history.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';

class RequestUpdation extends StatefulWidget {
  final id;
  RequestUpdation({this.id});
  @override
  _RequestUpdationState createState() => _RequestUpdationState();
}

class _RequestUpdationState extends State<RequestUpdation> {
  int option = 1;
  String dropdownValue = 'Select visit sub-types';
  // ComplaintViewController complaintViewController = Get.find();
  SRListController srListController = Get.find();
  ComplaintViewModel complaintViewModel;

  var data;
  getComplaintViewData() async {
    await srListController.getAccessKey().then((value) async {
      // print("id"+ widget.id.toString());
      await srListController
          .getComplaintViewData(value.accessKey, widget.id.toString())
          .then((value) {
        setState(() {
          complaintViewModel = value;
        });
      });
    });
  }

  @override
  void initState() {
    getComplaintViewData();
    //     .whenComplete((){
    //   setState(() {
    //   complaintViewModel = data;
    //   });
    //   print(data.toJson());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      bottomNavigationBar: BottomAppBar(
        color: ColorConstants.appBarColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        // currentScreen =
                        //     Dashboard(); // if user taps on this dashboard tab will be active
                        // currentTab = 0;
                        // Get.toNamed(Routes.HOME_SCREEN);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.white60,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     new CupertinoPageRoute(
                      //         builder: (BuildContext context) =>
                      //             DraftLeadListScreen()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.drafts,
                          color: Colors.white60,
                        ),
                        Text(
                          'Drafts',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Get.toNamed(Routes.SEARCH_SCREEN);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: complaintViewModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 200,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Container.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 56,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Request Updation',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: HexColor('#006838'),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children:[ Text(
                                    'ID: ${complaintViewModel.id}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold),
                                  ),
                                    Chip(
                                      label: Text('${complaintViewModel.escalationLevel}'),
                                    ),
                                  ]
                                ),
                                // Chip(
                                //   label: Text('${complaintViewModel.r}'),
                                // ),
                                Card(
                                    elevation: 6,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      complaintViewModel.srcResolutionEntity==null?Container()
                                      :Text(
                                        complaintViewModel.srcResolutionEntity[complaintViewModel.srcResolutionEntity.indexWhere((element) => element.id==complaintViewModel.resoulutionStatus)].resolutionText,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                    // child: DropdownButtonHideUnderline(
                                    //   child: DropdownButton(
                                    //     items:
                                    //         complaintViewModel.srcResolutionEntity
                                    //             .map(
                                    //               (e) => DropdownMenuItem(
                                    //                 child: Text(e.resolutionText),
                                    //                 value: e.id,
                                    //               ),
                                    //             )
                                    //             .toList(),
                                    //
                                    //     value:
                                    //         complaintViewModel.resoulutionStatus,
                                    //     onChanged: (value) {},
                                    //     elevation: 8,
                                    //   ),
                                    // ),
                                    ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      option = 1;
                                    });
                                  },
                                  child: Chip(
                                    label: Text('Details'),
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
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      option = 2;
                                    });
                                  },
                                  child: Chip(
                                      label: Text('Action'),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                            color: option == 2
                                                ? Colors.blue
                                                : Colors.black12),
                                      ),
                                      backgroundColor: option == 2
                                          ? Colors.blue.withOpacity(0.2)
                                          : Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      option = 3;
                                    });
                                  },
                                  child: Chip(
                                    label: Text('History'),
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
                                SizedBox(
                                  width: 120,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: option == 1
                                      ? RequestUpdateDetails(
                                          complaintViewModel:
                                              complaintViewModel,
                                          id: widget.id,
                                        )
                                      : option == 2
                                          ? RequestUpdateAction(
                                              dept: complaintViewModel
                                                  .deaprtmentText,
                                              resolutionStatus:
                                                  complaintViewModel
                                                      .srcResolutionEntity,
                                              id: complaintViewModel.id,
                                              severity:
                                                  complaintViewModel.severity,
                                            )
                                          : RequestUpdateHistory(
                                              srComplaintActionList:
                                                  complaintViewModel
                                                      .srComplaintActionList,
                                              // srComplaintActionList: complaintViewModel.srComplaintActionList,
                                            ),
                              ),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
