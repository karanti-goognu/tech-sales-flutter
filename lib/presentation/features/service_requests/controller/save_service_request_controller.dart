import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';

class SaveServiceRequestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final SrRepository repository;

  SaveServiceRequestController({@required this.repository})
      : assert(repository != null);
  final _saveRequestData = SrComplaintModel().obs;
  get saveRequestData => _saveRequestData.value;
  set saveRequestData(value) => _saveRequestData.value = value;
  String responseForDialog = '';

  List<File> imageList;

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  getAccessKeyAndSaveRequest(
      List<File> imageList, SaveServiceRequest saveRequestModel) {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {
      // Get.back();

      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        saveServiceRequest(
                imageList, data.accessKey, userSecurityKey, saveRequestModel)
            .then((value) {
           print(value);
          Get.back();
          if (value['resp-code'] == 'SRC2035') {
            Get.defaultDialog(
                title: "Message",
                middleText: value['resp-msg'].toString(),
                confirm: MaterialButton(
                  onPressed: () {
                     Get.back();
                     Get.offAndToNamed(Routes.SERVICE_REQUESTS);
                  },
                  //Get.toNamed(Routes.SERVICE_REQUESTS),
                  child: Text('OK'),
                ),
                barrierDismissible: false);
          } else {
            //Get.back();
            Get.dialog(
                CustomDialogs().messageDialogSRC(value['resp-msg'].toString()),
                barrierDismissible: false);
            // Get.defaultDialog(title:"Message",
            //   middleText: value['resp-msg'].toString(),
            //   // confirm: MaterialButton(onPressed: ()=>Get.back(),child: Text('OK'),),
            //   confirm: MaterialButton(onPressed: ()=>Get.toNamed(Routes.HOME_SCREEN),child: Text('OK'),),
            //     barrierDismissible: false
            // );
          }
        });
      });
    });
  }

  Future<Map> saveServiceRequest(List<File> imageList, String accessKey,
      String userSecurityKey, SaveServiceRequest saveRequestModel) {
    return repository
        .saveServiceRequest(
            imageList, accessKey, userSecurityKey, saveRequestModel)
        .whenComplete(() => responseForDialog = 'Test');
  }
}
