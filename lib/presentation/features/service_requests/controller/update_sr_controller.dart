import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';

class UpdateServiceRequestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final SrRepository repository;

  UpdateServiceRequestController({@required this.repository})
      : assert(repository != null);
  final _updateRequestData = UpdateSRModel().obs;
  // final _siteId = StringConstants.empty.obs;

  get updateRequestData => _updateRequestData.value;

  // get siteId => this._siteId.value;
  //
  // set siteId(value) => this._siteId.value = value;

  set updateRequestData(value) => _updateRequestData.value = value;
  String responseForDialog = '';
  List<File> imageList;

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  getAccessKeyAndUpdateRequest(
      List<File> imageList, UpdateSRModel updateRequestModel) {
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
        updateServiceRequest(
                imageList, data.accessKey, userSecurityKey, updateRequestModel)
            .then((value) {
          Get.back();
          // if(value['resp-code']=='SRC2035'){
          // Get.defaultDialog(title:"Message",
          //   middleText: value['resp-msg'].toString(),
          //   confirm: MaterialButton(onPressed: ()=>Get.back(),child: Text('OK'),),
          // );
          // } else{
          Get.defaultDialog(
            title: "Message",
            middleText: value['resp-msg'].toString(),
            barrierDismissible: false,
            // confirm: MaterialButton(onPressed: ()=>Get.back(),child: Text('OK'),),

            confirm: MaterialButton(
              onPressed: () => Get.toNamed(Routes.HOME_SCREEN),
              child: Text('OK'),
            ),
          );
          // }
        });
      });
    });
  }

  Future<Map> updateServiceRequest(List<File> imageList, String accessKey,
      String userSecurityKey, UpdateSRModel updateRequestModel) {
    return repository
        .updateServiceRequest(
            imageList, accessKey, userSecurityKey, updateRequestModel)
        .whenComplete(() => responseForDialog = 'Test');
  }
}
