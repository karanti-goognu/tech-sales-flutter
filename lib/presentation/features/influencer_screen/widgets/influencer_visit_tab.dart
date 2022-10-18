import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/infl_visit_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/UpdateInfluencerRequest.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';

class InfluencerVisitTab extends StatelessWidget {
  final String selectedDateString =
      DateFormat("yyyy-MM-dd").format(DateTime.now());
  final InflVisitController inflVisitController = Get.find();
  final String? eventType;
  final double spacing;
  final String empID;
  final int membershipId;
  final InfluencerModel? influencerModel;
  final TextEditingController contactNumberController;
  final TextEditingController totalSites;
  final TextEditingController dalmiaSites;
  final TextEditingController totalBags;
  final TextEditingController dalmiaBags;
  final TextEditingController nextVisitDate;
  final GlobalKey<FormState> addInfluencerFormKey;

  final InfluencerDetailDataModel influencerDetailDataModel;

  InfluencerVisitTab({
    Key? key,
    required this.spacing,
    required this.membershipId,
    required this.influencerDetailDataModel,
    required this.contactNumberController,
    required this.influencerModel,
    required this.eventType,
    required this.empID,
    required this.totalSites,
    required this.dalmiaSites,
    required this.totalBags,
    required this.dalmiaBags,
    required this.nextVisitDate,
    required this.addInfluencerFormKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InflVisitController>(
        builder: (InflVisitController controller) {
      return influencerDetailDataModel.response!.visitStatus == "no_start"
          ? Column(children: [
              TextFormField(
                controller: TextEditingController(text: eventType!),
                readOnly: true,
                style: FormFieldStyle.formFieldTextStyle,
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Event Type",
                ),
              ),
              SizedBox(
                height: spacing,
              ),
              TextFormField(
                controller: contactNumberController,
                readOnly: true,
                style: FormFieldStyle.formFieldTextStyle,
                decoration: FormFieldStyle.buildInputDecoration(
                  labelText: "Contact#",
                ),
              ),
              SizedBox(
                height: spacing,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: ColorConstants.lineColorFilter)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDateString,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.blackColor,
                              fontFamily: "Muli"),
                        ),
                        Icon(
                          Icons.calendar_today_sharp,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: spacing,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Visit Type"),
                  value: controller.selectedVisitType,
                  onChanged: (String? _) {
                    controller.updateVisit(_);
                  },
                  items: controller.visitTypeList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: spacing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorConstants.buttonNormalColor,
                    ),
                    onPressed: () async {
                      TsoLogger.printLog("In Create");
                      controller.startVisit("Start");
                      if (controller.selectedVisitType == null) {
                        Get.dialog(CustomDialogs.showMessage(
                            "Please select a visit type"));
                      } else {
                        Future.delayed(
                          Duration.zero,
                          () => Get.dialog(
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                        LocationDetails result =
                            await GetCurrentLocation.getCurrentLocation()
                                .whenComplete(() {
                          Get.back();
                          // Get.rawSnackbar(
                          //     message:
                          //     'Accessing your location. Please ensure location permission is enabled for this app.');
                        });
                        DateFormat dateFormat =
                            DateFormat("yyyy-MM-dd HH:mm:ss");
                        UpdateInfluencerRequest updateInflRequest =
                            UpdateInfluencerRequest.fromJson({
                          "docId": int.parse(contactNumberController.text),
                          "inflId": membershipId,
                          "visitStartLat": result.latLng?.latitude.toString(),
                          "visitStartLong": result.latLng?.longitude.toString(),
                          "visitStartTime": dateFormat.format(DateTime.now()),
                          "visitSubType": eventType!,
                          "visitType": controller.selectedVisitType!,
                          "visitDate": selectedDateString,
                          "nextVisitDate": null,
                          "referenceId": empID,
                          "dspAvailableQty": "",
                          "eventType": "",
                          "id": 0,
                          "isDspAvailable": "",
                          "remark": "",
                          "visitEndLat": "",
                          "visitEndLong": "",
                          "visitEndTime": "",
                          "visitOutcomes": null,
                        });
                        controller.updateInfluencer(updateInflRequest);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        'START',
                        style: ButtonStyles.buttonStyleBlue,
                      ),
                    ),
                  )
                ],
              )
            ])
          : Column(
              children: [
                TextFormField(
                  controller: totalSites,
                  style: FormFieldStyle.formFieldTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Total Number of Sites",
                  ),
                ),
                SizedBox(height: spacing),
                TextFormField(
                  controller: dalmiaSites,
                  style: FormFieldStyle.formFieldTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Dalmia Sites",
                  ),
                ),
                SizedBox(
                  height: spacing,
                ),
                TextFormField(
                  controller: totalBags,
                  style: FormFieldStyle.formFieldTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Total Potential (Bags)",
                  ),
                ),
                SizedBox(
                  height: spacing,
                ),
                TextFormField(
                  controller: dalmiaBags,
                  style: FormFieldStyle.formFieldTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Dalmia Potential (Bags)",
                  ),
                ),
                SizedBox(
                  height: spacing,
                ),
                TextFormField(
                  controller: nextVisitDate,
                  style: FormFieldStyle.formFieldTextStyle,
                  readOnly: true,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Next Visit Date",
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.date_range_rounded,
                        size: 22,
                        color: ColorConstants.clearAllTextColor,
                      ),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                        );

                        final DateFormat formatter = DateFormat("yyyy-MM-dd");
                        if (picked != null) {
                          final String formattedDate = formatter.format(picked);
                          nextVisitDate.text = formattedDate;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: spacing,
                ),
                influencerDetailDataModel.response!.visitStatus != "end"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorConstants.buttonNormalColor,
                            ),
                            onPressed: () async {
                              TsoLogger.printLog("In Create");
                              controller.startVisit("");
                              // if (_formKey.currentState!.validate()) {
                              //   _formKey.currentState!.save();
                              //   _getCurrentLocation(0);
                              // }
                              Future.delayed(
                                Duration.zero,
                                () => Get.dialog(
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                              LocationDetails result =
                                  await GetCurrentLocation.getCurrentLocation()
                                      .whenComplete(() {
                                Get.back();
                              });
                              DateFormat dateFormat =
                                  DateFormat("yyyy-MM-dd HH:mm:ss");

                              UpdateInfluencerRequest updateInflRequest =
                                  UpdateInfluencerRequest.fromJson({
                                "docId":
                                    int.parse(contactNumberController.text),
                                "inflId": membershipId,
                                "visitStartLat": null,
                                "visitStartLong": null,
                                "visitEndLat":
                                    result.latLng?.latitude.toString(),
                                "visitEndLong":
                                    result.latLng?.longitude.toString(),
                                "visitStartTime": null,
                                "visitSubType": eventType!,
                                "visitType": controller.selectedVisitType ?? "",
                                "visitDate": selectedDateString,
                                "nextVisitDate": nextVisitDate.text,
                                "referenceId": empID,
                                "totalSites": totalSites.text,
                                "dalmiaSites": dalmiaSites.text,
                                "totalBags": totalBags.text,
                                "dalmiaBags": dalmiaBags.text,
                                "visitEndTime":
                                    dateFormat.format(DateTime.now()),
                                "dspAvailableQty": "",
                                "eventType": "",
                                "id": 0,
                                "isDspAvailable": "",
                                "remark": "",
                                "visitOutcomes": null
                              });
                              print(jsonEncode(updateInflRequest));

                              controller.updateInfluencer(updateInflRequest);
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Text(
                                'END',
                                style: ButtonStyles.buttonStyleBlue,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container()
              ],
            );
    });
  }
}
