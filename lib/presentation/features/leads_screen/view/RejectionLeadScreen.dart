import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/background_container_image.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RejectionLeadScreen extends StatefulWidget {
  ViewLeadDataResponse viewLeadDataResponse;

  RejectionLeadScreen(this.viewLeadDataResponse);

  @override
  _RejectionLeadScreenState createState() => _RejectionLeadScreenState();
}

class _RejectionLeadScreenState extends State<RejectionLeadScreen> {
  List<LeadRejectReasonEntity> leadRejectReasonEntity;

  LeadRejectReasonEntity _selectedValue;

  var _commentsController = new TextEditingController();
  AddLeadsController _addLeadsController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addLeadsController = Get.find();
    leadRejectReasonEntity = gv.leadRejectReasonEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundContainerImage(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Image.asset(
                      'assets/images/rejected.png',
                    ),
                  ),
                  Text(
                    "Rejected",
                    style: TextStyle(fontSize: 30, color: HexColor("#B00020")),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Center(
                    child: Text(
                      "Please add your comment to complete this rejection",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,

                        //color: HexColor("#B00020")
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonFormField<LeadRejectReasonEntity>(
                      value: _selectedValue,
                      items: leadRejectReasonEntity
                          .map((label) => DropdownMenuItem(
                                child: Text(
                                  label.rejectionText,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: ColorConstants.inputBoxHintColor,
                                      fontFamily: "Muli"),
                                ),
                                value: label,
                              ))
                          .toList(),

                      // hint: Text('Rating'),
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Please select reason",
                        filled: false,
                        focusColor: Colors.black,
                        isDense: false,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _commentsController,
                      maxLength: 100,
                      onChanged: (value) async {},
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.backgroundColorBlue,
                              //color: HexColor("#0000001F"),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFF000000).withOpacity(0.4),
                              width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Comments",
                        filled: false,
                        focusColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Muli",
                            color: ColorConstants.inputBoxHintColorDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0),
                        fillColor: ColorConstants.backgroundColor,
                      ),
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: HexColor("#1C99D4"),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 17),
                        ),
                      ),
                      onPressed: () async {
                        ViewLeadDataResponse viewLeadDataResponse =
                            widget.viewLeadDataResponse;

                        String empId;
                        String mobileNumber;
                        String name;
                        Future<SharedPreferences> _prefs =
                            SharedPreferences.getInstance();
                        _prefs.then((SharedPreferences prefs) async {
                          empId = prefs.getString(StringConstants.employeeId) ??
                              "empty";
                          mobileNumber =
                              prefs.getString(StringConstants.mobileNumber) ??
                                  "empty";
                          name =
                              prefs.getString(StringConstants.employeeName) ??
                                  "empty";

                          var updateRequestModel = {
                            'leadId': viewLeadDataResponse.leadsEntity.leadId,
                            'leadSegment':
                                viewLeadDataResponse.leadsEntity.leadSegment,
                            'assignedTo':
                                viewLeadDataResponse.leadsEntity.assignedTo,
                            'eventId': viewLeadDataResponse.leadsEntity.eventId,
                            'leadStatusId': 2,
                            'leadStage':
                                viewLeadDataResponse.leadsEntity.leadStageId,
                            'contactName':
                                viewLeadDataResponse.leadsEntity.contactName,
                            'contactNumber':
                                viewLeadDataResponse.leadsEntity.contactNumber,
                            'geotagType':
                                viewLeadDataResponse.leadsEntity.geotagType,
                            'leadLatitude':
                                viewLeadDataResponse.leadsEntity.leadLatitude,
                            'leadLongitude':
                                viewLeadDataResponse.leadsEntity.leadLongitude,
                            'leadAddress':
                                viewLeadDataResponse.leadsEntity.leadAddress,
                            'leadPincode':
                                viewLeadDataResponse.leadsEntity.leadPincode,
                            'leadStateName':
                                viewLeadDataResponse.leadsEntity.leadStateName,
                            'leadDistrictName': viewLeadDataResponse
                                .leadsEntity.leadDistrictName,
                            'leadTalukName':
                                viewLeadDataResponse.leadsEntity.leadTalukName,
                            'leadSalesPotentialMt': viewLeadDataResponse
                                .leadsEntity.leadSitePotentialMt,
                            'leadReraNumber':
                                viewLeadDataResponse.leadsEntity.leadReraNumber,
                            'isStatus': "false",
                            'updatedBy': empId,
                            'leadIsDuplicate': viewLeadDataResponse
                                .leadsEntity.leadIsDuplicate,
                            'rejectionComment': _commentsController.text,
                            'leadRejectReason': _selectedValue.rejectionId,
                            'nextDateCconstruction': viewLeadDataResponse
                                .leadsEntity.nextDateCconstruction,
                            'nextStageConstruction': viewLeadDataResponse
                                .leadsEntity.nextStageConstruction,
                            'siteDealerId':
                                viewLeadDataResponse.leadsEntity.siteDealerId,
                            'listLeadcomments': new List(),
                            'listLeadImage': new List(),
                            'leadInfluencerEntity': new List()
                            // 'listLeadcomments': viewLeadDataResponse.leadcommentsEnitiy,
                            // 'listLeadImage': viewLeadDataResponse.leadphotosEntity,
                            // 'leadInfluencerEntity': viewLeadDataResponse.leadInfluencerEntity
                          };

                          _addLeadsController.updateLeadData(
                              updateRequestModel,
                              new List<File>(),
                              context,
                              viewLeadDataResponse.leadsEntity.leadId,1);

                          Get.back();
                        });
                      },
                    ),
                  ),
                  // Image.asset('assets/images/rejected.png'),
                ],
              ),
            ),
          ],
        ),
        // ]),
      ),
    );
  }
}
