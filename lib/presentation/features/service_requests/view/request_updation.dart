import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_action.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_details.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_history.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';

class RequestUpdation extends StatefulWidget {
  final id;
  RequestUpdation({this.id});
  @override
  _RequestUpdationState createState() => _RequestUpdationState();
}

class _RequestUpdationState extends State<RequestUpdation>{
  AppController _appController= Get.find();
  UpdateServiceRequestController updateServiceRequestController = Get.find();


  getComplaintViewData() async {
    updateServiceRequestController.id = widget.id.toString();
    await _appController.getAccessKey(RequestIds.GET_REQUEST_DETAILS_FOR_UPDATE);
  }

  @override
  void initState() {
    getComplaintViewData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
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
      body: updateServiceRequestController.complaintListData == null
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
            child: GetBuilder<UpdateServiceRequestController>(
              builder: (controller) {
                return Column(
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
                              Row(
                                  children:[ Text(
                                    'ID: ${updateServiceRequestController.complaintListData.id}   ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.bold,),
                                  ),
                                    Transform(
                                      transform: new Matrix4.identity()..scale(0.7),
                                      alignment: Alignment.center,
                                      child: Chip(
                                        backgroundColor: Colors.red.withOpacity(0.09),
                                        label: Text('Escl. Level-${updateServiceRequestController.complaintListData.escalationLevel}', style: TextStyle(fontSize: 10, color: Colors.red),),
                                        padding: EdgeInsets.zero,
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                              color: controller.option == 1
                                                  ? Colors.red
                                                  : Colors.red),
                                        ),
                                      ),
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
                                    updateServiceRequestController.complaintListData.srcResolutionEntity==null?Container()
                                        :Text(
                                      updateServiceRequestController.complaintListData.srcResolutionEntity[updateServiceRequestController.complaintListData.srcResolutionEntity.indexWhere((element) => element.id==updateServiceRequestController.complaintListData.resoulutionStatus)].resolutionText,
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
                                  controller.setTabOption(1);
                                  print(controller.option);
                                },
                                child: Chip(
                                  label: Text('Details'),
                                  backgroundColor: controller.option == 1
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.white,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                        color: controller.option == 1
                                            ? Colors.blue
                                            : Colors.black12),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.setTabOption(2);
                                  },
                                child: Chip(
                                    label: Text('Action'),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                          color:controller. option == 2
                                              ? Colors.blue
                                              : Colors.black12),
                                    ),
                                    backgroundColor:controller. option == 2
                                        ? Colors.blue.withOpacity(0.2)
                                        : Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.setTabOption(3);
                                },
                                child: Chip(
                                  label: Text('History'),
                                  backgroundColor: controller. option == 3
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.white,
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                        color:controller. option == 3
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
                              child: controller.option == 1
                                  ? RequestUpdateDetails(
                                complaintViewModel:
                                updateServiceRequestController.complaintListData,
                                id: widget.id,
                              )
                                  : controller.option == 2
                                  ? RequestUpdateAction(
                                dept: updateServiceRequestController.complaintListData
                                    .deaprtmentText,
                                resolutionStatus:
                                updateServiceRequestController.complaintListData
                                    .srcResolutionEntity,
                                id: updateServiceRequestController.complaintListData.id,
                                severity:
                                updateServiceRequestController.complaintListData.severity,
                              )
                                  : RequestUpdateHistory(
                                srComplaintActionList:
                                updateServiceRequestController.complaintListData
                                    .srComplaintActionList,
                                updatedOn: updateServiceRequestController.complaintListData.updatedOn,
                                requestStatus: updateServiceRequestController.complaintListData.requestText,
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
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}