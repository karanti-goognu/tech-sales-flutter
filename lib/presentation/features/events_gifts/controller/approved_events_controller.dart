
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsFilterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    super.onReady();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    super.onClose();
  }

  final EgRepository repository;

  EventsFilterController({@required this.repository})
      : assert(repository != null);


  final _egApprovedEventData = ApprovedEventsModel().obs;

  get egApprovedEventDaa => _egApprovedEventData.value;

  set egApprovedEventDaa(value) => _egApprovedEventData.value = value;

  Future getAccessKey() {
    return repository.getAccessKey();
  }

  Future<ApprovedEventsModel> getApprovedEventData() async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    var accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      egApprovedEventDaa =
      await repository.getApprovedEvents(accessKey, userSecurityKey, empID);
    });
//    Get.back();
    return egApprovedEventDaa;
  }
}



