import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onReady() {
  //   // called after the widget is rendered on screen
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   // called just before the Controller is deleted from memory
  //   super.onClose();
  // }

  final EgRepository repository;

  DetailEventController({@required this.repository}) : assert(repository != null);


  final _egDetailEventData = DetailEventModel().obs;

  get egDetailEventDaa => _egDetailEventData.value;

  set egDetailEventDaa(value) => _egDetailEventData.value = value;

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  Future<DetailEventModel> getDetailEventData(String accessKey, int eventId) async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      egDetailEventDaa =
      await repository.getdetailEvents(accessKey, userSecurityKey, empID, eventId);
    });
//    Get.back();
    return egDetailEventDaa;
  }
}