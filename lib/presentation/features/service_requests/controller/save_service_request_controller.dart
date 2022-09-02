import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';

class SaveServiceRequestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final SrRepository repository;

  SaveServiceRequestController({required this.repository});
  final _saveRequestData = SrComplaintModel().obs;
  get saveRequestData => _saveRequestData.value;
  set saveRequestData(value) => _saveRequestData.value = value;
  String responseForDialog = '';

  List<File>? imageList;

  Future<AccessKeyModel?> getAccessKey() {
    return repository.getAccessKey();
  }

  getAccessKeyAndSaveRequest(
      List<File> imageList, SaveServiceRequest saveRequestModel) async {
    String? userSecurityKey = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    AccessKeyModel data = await repository.getAccessKey();
    userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
    Map? value = await saveServiceRequest(
        imageList, data.accessKey, userSecurityKey, saveRequestModel);
    Get.back();
    if (value!['resp-code'] == 'SRC2035') {
      Get.defaultDialog(
          title: "Message",
          middleText: value['resp-msg'].toString(),
          confirm: MaterialButton(
            onPressed: () {
              Get.back();
              Get.offAndToNamed(Routes.SERVICE_REQUESTS);
            },
            child: Text('OK'),
          ),
          barrierDismissible: false);
    } else {
      Get.dialog(CustomDialogs.messageDialogSRC(value['resp-msg'].toString()),
          barrierDismissible: false);
    }
  }

  Future<Map?> saveServiceRequest(List<File> imageList, String? accessKey,
      String? userSecurityKey, SaveServiceRequest saveRequestModel) {
    return repository
        .saveServiceRequest(
            imageList, accessKey, userSecurityKey, saveRequestModel)
        .whenComplete(() => responseForDialog = 'Test');
  }
}
