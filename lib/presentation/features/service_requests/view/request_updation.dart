import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_action.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_details.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/widgets/request_update_history.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:get/get.dart';

class RequestUpdation extends StatefulWidget {
  final id;
  RequestUpdation({this.id});
  @override
  _RequestUpdationState createState() => _RequestUpdationState();
}

class _RequestUpdationState extends State<RequestUpdation>{
  UpdateServiceRequestController updateServiceRequestController = Get.find();
  Future<ComplaintViewModel> _complaintViewModel;
  ComplaintViewModel complaintViewModel = new ComplaintViewModel();


  Future<ComplaintViewModel> getComplaintViewData() async {
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    var data = await updateServiceRequestController.getAccessKey();
      accessKeyModel = data;
      updateServiceRequestController.id = widget.id.toString();
      updateServiceRequestController.coverBlockProvidedNo.clear();
      updateServiceRequestController.formwarkRemovalDate.clear();
      updateServiceRequestController.setTabOption(1);
      await updateServiceRequestController.getRequestUpdateDetailsData(accessKeyModel.accessKey).then((value) => {
      setState(() {
        complaintViewModel = value;
      }),
      // });
    });
    return complaintViewModel;
  }

  @override
  void initState() {
     _complaintViewModel=getComplaintViewData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 68.0,
        width: 68.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: ColorConstants.checkInColor,
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
      body: FutureBuilder(
          future: _complaintViewModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Please wait data loading...')
                    ],
                  ));
            } else {
              if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
              else
                return  Stack(
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
                                                'ID: ${widget.id}   ',
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
                                                    label: Text('Escl. Level-${snapshot.data.escalationLevel}', style: TextStyle(fontSize: 10, color: Colors.red),),
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
                                          Card(
                                              elevation: 6,
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child:
                                                snapshot.data.srcResolutionEntity==null?Container()
                                                    :Text(
                                                  snapshot.data.srcResolutionEntity[snapshot.data.srcResolutionEntity.indexWhere((element) => element.id==snapshot.data.resoulutionStatus)].resolutionText,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.setTabOption(1);
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
                                            snapshot.data,
                                            id: widget.id,
                                          )
                                              : controller.option == 2
                                              ? RequestUpdateAction(
                                            dept:snapshot.data
                                                .deaprtmentText,
                                            resolutionStatus: snapshot.data.srcResolutionEntity,
                                            id: snapshot.data.id,
                                            severity:
                                            snapshot.data.severity,
                                            requestType: snapshot.data.requestText,
                                          )
                                              : RequestUpdateHistory(
                                            srComplaintActionList:
                                            snapshot.data
                                                .srComplaintActionList,
                                            updatedOn: snapshot.data.updatedOn,
                                            requestStatus: snapshot.data..requestText,
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
                );

            }
          })
    );
  }
}