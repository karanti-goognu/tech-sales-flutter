import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  // @override
  // void onInit() {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   super.onInit();
  // }

  final DashboardRepository repository;

  DashboardController({@required this.repository}) : assert(repository != null);

  final _accessKeyResponse = AccessKeyModel().obs;
  final _phoneNumber = "8860080067".obs;
  final _empId = "_empty".obs;
  final _employeeName = "_empty".obs;

  get accessKeyResponse => this._accessKeyResponse.value;



  get phoneNumber => this._phoneNumber.value;

  get empId => this._empId.value;

  get employeeName => this._employeeName.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;


  set phoneNumber(value) => this._phoneNumber.value = value;

  set empId(value) => this._empId.value = value;

  set employeeName(value) => this._employeeName.value = value;


  getAccessKey(int requestId) {
    print('EmpId :: ${this.empId} Phone Number :: ${this.phoneNumber} ');
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;
      switch (requestId) {
        case RequestIds.SHARE_REPORT:
          break;
      }
    });
  }

  getDetailsForSharingReport(File image) {
    print(image.path);
    String userSecurityCode;
    String empID;
    repository.getAccessKey().then((value) {
      print(value.accessKey);
      this.accessKeyResponse = value;
       Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
     userSecurityCode=prefs.getString(StringConstants.userSecurityKey);
     empID=prefs.getString(StringConstants.employeeId);
         shareReport(image, userSecurityCode, this.accessKeyResponse.accessKey, empID);

    });
    });
   

  }
 
 shareReport(File image, String userSecurityKey, String accessKey, String empID){
   print('waheguru path$image.path');
   print('waheguru accesskey $accessKey');
   print('waheguru secretkey $userSecurityKey');
   print(empID);
   repository.shareReport(image, userSecurityKey, accessKey, empID);
  //  .then((value) => print(value));

 }


}
