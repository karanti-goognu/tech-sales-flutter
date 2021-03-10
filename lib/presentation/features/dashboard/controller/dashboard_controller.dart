import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/models/JorneyModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/repository/home_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
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
  final _validateOtpResponse = ValidateOtpModel().obs;
  final _checkInResponse = JourneyModel().obs;
  final _phoneNumber = "8860080067".obs;
  final _empId = "_empty".obs;
  final _employeeName = "_empty".obs;

  get accessKeyResponse => this._accessKeyResponse.value;


  get validateOtpResponse => this._validateOtpResponse.value;

  get checkInResponse => this._checkInResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get empId => this._empId.value;

  get employeeName => this._employeeName.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set validateOtpResponse(value) => this._validateOtpResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set empId(value) => this._empId.value = value;

  set employeeName(value) => this._employeeName.value = value;

  set checkInResponse(value) => this._checkInResponse.value = value;




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

  shareReport( File image){
    print(image.path);
    repository.getAccessKey().then((value){
     print(value.accessKey);
           this.accessKeyResponse = value;

    }     
     );


  }


}
