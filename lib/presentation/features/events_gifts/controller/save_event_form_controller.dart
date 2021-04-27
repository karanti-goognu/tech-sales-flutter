import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final EgRepository repository;

  SaveEventController({@required this.repository})
      : assert(repository != null);
  final _saveEventData = SaveEventFormModel().obs;
  get saveEventData => _saveEventData.value;
  set saveEventData(value) => _saveEventData.value = value;
  String responseForDialog = '';

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  getAccessKeyAndSaveRequest(
       SaveEventFormModel saveEventFormModel) {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {

      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        saveEventRequest(data.accessKey, userSecurityKey, saveEventFormModel)
            .then((value) {
          Get.back();
          // if (value.respCode == 'DM1002') {
          //   Get.defaultDialog(
          //       title: "Message",
          //       middleText: value.respMsg.toString(),
          //       confirm: MaterialButton(
          //         onPressed: () => Get.back(),
          //         child: Text('OK'),
          //       ),
          //       barrierDismissible: false);
          // } else {
          //   Get.back();
          //   Get.dialog(
          //       CustomDialogs().messageDialogMWP(value.respMsg.toString()),
          //       barrierDismissible: false);
          // }
        });
      });
    });
  }

  Future<SaveEventResponse> saveEventRequest(String accessKey,
      String userSecurityKey, SaveEventFormModel saveEventFormModel) {
    return repository.saveEventForm(accessKey, userSecurityKey, saveEventFormModel)
        .whenComplete(() => responseForDialog = 'Test');
  }

}

///Exeption error = 400,  DM1006
///success = Success - DM1002