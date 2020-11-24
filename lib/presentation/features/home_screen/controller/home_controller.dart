import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/models/JorneyModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/repository/home_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    super.onInit();
  }

  final MyRepositoryHome repository;

  HomeController({@required this.repository}) : assert(repository != null);

  final _accessKeyResponse = AccessKeyModel().obs;
  final _validateOtpResponse = ValidateOtpModel().obs;
  final _checkInResponse = JourneyModel().obs;
  final _phoneNumber = "8860080067".obs;
  final _empId = "_empty".obs;
  final _employeeName = "_empty".obs;
  final _checkInStatus = StringConstants.empty.obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  get checkInStatus => this._checkInStatus.value;

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

  set checkInStatus(value) => this._checkInStatus.value = value;

  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }

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
        case RequestIds.CHECK_IN:
          getCheckInDetails(this.accessKeyResponse.accessKey);
          break;
      }
    });
  }

  getCheckInDetails(String accessKey) {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    String empId = "empty";
    String userSecurityKey = "empty";
    String journeyStartLat = "empty";
    String journeyStartLong = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";

      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        journeyStartLat = position.latitude.toString();
        journeyStartLong = position.longitude.toString();
        //debugPrint('request without encryption: $body');
        String url = "${UrlConstants.getCheckInDetails}";
        debugPrint('Url is : $url');
        var date = DateTime.now();
        var formattedDate = "${date.year}-${date.month}-${date.day}";
        print(
            'Date is ${date.toString()} Formatted Date :: $formattedDate Latitude $journeyStartLat Longitude $journeyStartLong');

        repository
            .getCheckInDetails(
                url,
                accessKey,
                userSecurityKey,
                empId,
                formattedDate,
                date.toString(),
                journeyStartLat,
                journeyStartLong,
                null,
                null,
                null)
            .then((data) {
          if (data == null) {
            debugPrint('Check in  Data Response is null');
          } else {
            this.checkInResponse = data;
            print("${this.checkInResponse}");
          }
        });
      }).catchError((e) {
        print(e);
      });
    });
  }

  getCheckOutDetails(String accessKey) {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    String empId = "empty";
    String userSecurityKey = "empty";
    String journeyStartLat = "empty";
    String journeyStartLong = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";

      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        journeyStartLat = position.latitude.toString();
        journeyStartLong = position.longitude.toString();
        //debugPrint('request without encryption: $body');
        String url = "${UrlConstants.getCheckInDetails}";
        debugPrint('Url is : $url');
        var date = DateTime.now();
        var formattedDate = "${date.year}-${date.month}-${date.day}";
        var formattedDateTime = "${date.year}-${date.month}-${date.day} ${date.hour}-${date.minute}-${date.second}";
        print(
            'Date is ${date.toString()} Formatted Date :: $formattedDate Latitude $journeyStartLat Longitude $journeyStartLong');

        repository
            .getCheckInDetails(
            url,
            accessKey,
            userSecurityKey,
            empId,
            formattedDate,
            date.toString(),
            journeyStartLat,
            journeyStartLong,
            "",
            "",
            "")
            .then((data) {
          if (data == null) {
            debugPrint('Check in  Data Response is null');
          } else {
            this.checkInResponse = data;
            print("${this.checkInResponse}");
          }
        });
      }).catchError((e) {
        print(e);
      });
    });
  }

  //{"resp-code":"DM1011","resp-msg":"OTP generated successfully",
  // "otp-sms-time":"900000","otp-retry-sms-time":"180000","otp-token-id":"8e711d59-8820-41ee-b11d-59882041ee09"}

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  openHomeScreen() {
    Get.toNamed(Routes.HOME_SCREEN);
  }
}
