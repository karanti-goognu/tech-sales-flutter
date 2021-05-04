import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/deleteEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
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

  final _deleteEventResponse = DeleteEventModel().obs;

  get egDetailEventDaa => _egDetailEventData.value;

  get deleteEventResponse => _deleteEventResponse.value;

  set egDetailEventDaa(value) => _egDetailEventData.value = value;

  set deleteEventResponse(value) => _deleteEventResponse.value = value;

  Future<String> getAccessKey() {
    return repository.getAccessKey();
  }

  Future<DetailEventModel> getDetailEventData(int eventId) async {
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
      String accessKey = await repository.getAccessKey();
      print('EMP: $empID');
      egDetailEventDaa =
      await repository.getdetailEvents(accessKey, userSecurityKey, empID, eventId);
    });
//    Get.back();
    return egDetailEventDaa;
  }

  Future<DeleteEventModel> deleteEvent(int eventId) async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
//     String userSecurityKey = "";
//     String empID = "";
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//     await _prefs.then((SharedPreferences prefs) async {
//       userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
//       // print(userSecurityKey);
//       empID = prefs.getString(StringConstants.employeeId);
//       String accessKey = await repository.getAccessKey();
//       print('EMP: $empID');
//       deleteEventResponse = await repository.deleteEvent(accessKey, userSecurityKey, empID, eventId);
//     });
//    Get.back();
 //   return deleteEventResponse;

    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {

      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        repository.deleteEvent(accessKey, userSecurityKey, empID, eventId)
            .then((value) {
          //Get.back();
          if (value.respMsg == 'DM1002') {
            Get.back();
            Get.defaultDialog(
                title: "Message",
                middleText: value.respMsg.toString(),
                confirm: MaterialButton(
                  onPressed: () => Get.back(),
                  child: Text('OK'),
                ),
                barrierDismissible: false);
          } else {
            Get.back();
            Get.dialog(
                CustomDialogs().messageDialogMWP(value.respMsg.toString()),
                barrierDismissible: false);
          }
        });
      });
    });
  }


}