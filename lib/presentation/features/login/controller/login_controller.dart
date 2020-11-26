import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/app_shared_preference.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    super.onInit();
  }

  final MyRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  final _loginResponse = LoginModel().obs;
  final _retryOtpResponse = RetryOtpModel().obs;
  final _accessKeyResponse = AccessKeyModel().obs;
  final _validateOtpResponse = ValidateOtpModel().obs;
  final _phoneNumber = "8860080067".obs;
  final _empId = "_empty".obs;
  final _otpCode = "_empty".obs;
  final _retryOtpActive = false.obs;

  get loginResponse => this._loginResponse.value;

  get retryOtpResponse => this._retryOtpResponse.value;

  get accessKeyResponse => this._accessKeyResponse.value;

  get validateOtpResponse => this._validateOtpResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get empId => this._empId.value;

  get otpCode => this._otpCode.value;

  get retryOtpActive => this._retryOtpActive.value;

  set loginResponse(value) => this._loginResponse.value = value;

  set retryOtpResponse(value) => this._retryOtpResponse.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set validateOtpResponse(value) => this._validateOtpResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set empId(value) => this._empId.value = value;

  set otpCode(value) => this._otpCode.value = value;

  set retryOtpActive(value) => this._retryOtpActive.value = value;

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
        case RequestIds.LOGIN_REQUEST:
          checkLoginStatus();
          break;
        case RequestIds.RETRY_OTP_REQUEST:
          retryOtp();
          break;
        case RequestIds.VALIDATE_OTP_REQUEST:
          validateOTP();
          break;
      }
    });
  }

  //{"resp-code":"DM1011","resp-msg":"OTP generated successfully",
  // "otp-sms-time":"900000","otp-retry-sms-time":"180000","otp-token-id":"8e711d59-8820-41ee-b11d-59882041ee09"}

  //{"resp-code":null,"resp-msg":null,"otp-sms-time":null,"otp-retry-sms-time":null}
  checkLoginStatus() {
    debugPrint('Access Key Response :: ');
    repository
        .checkLoginStatus(
            this.empId, this.phoneNumber, this.accessKeyResponse.accessKey)
        .then((data) {
      if (data == null) {
        debugPrint('Login Response is null');
      } else {
        this.loginResponse = data;
        if (loginResponse.respCode == "DM1011") {
          openOtpVerificationPage(this.phoneNumber);
        } else {
          Get.dialog(CustomDialogs().errorDialog(loginResponse.respMsg));
        }
      }
    });
  }

  retryOtp() {
    repository
        .retryOtp(this.empId, this.phoneNumber,
            this.accessKeyResponse.accessKey, this.loginResponse.otpTokenId)
        .then((data) {
      if (data == null) {
        debugPrint('Otp Retry Response is null');
      } else {
        this.retryOtpResponse = data;
        print('Retry Otp Response is :: ${jsonEncode(this.retryOtpResponse)}');
        if (retryOtpResponse.respCode == "DM1015") {
          this.retryOtpActive = false;
        } else {
          Get.dialog(CustomDialogs().errorDialog(
              '${retryOtpResponse.respCode} ${retryOtpResponse.respMsg}'));
        }
      }
    });
  }

  validateOTP() {
    debugPrint('Otp Retry Response is null${this.otpCode}');
    repository
        .validateOtp(this.empId, this.phoneNumber,
            this.accessKeyResponse.accessKey, this.otpCode)
        .then((data) {
      if (data == null) {
        debugPrint('Otp Validation Response is null');
      } else {
        this.validateOtpResponse = data;
        if (validateOtpResponse.respCode == "DM1011") {
          debugPrint(
              'Otp Validation Response is :: ${json.encode(this.validateOtpResponse)}');
          //Get.dialog(CustomDialogs().errorDialog(validateOtpResponse.respMsg));
          Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
          _prefs.then((SharedPreferences prefs) {
            prefs.setString(StringConstants.userSecurityKey,
                this.validateOtpResponse.userSecurityKey);
            prefs.setString(StringConstants.isUserLoggedIn, "true");
            prefs.setString(StringConstants.employeeName,
                this.validateOtpResponse.employeeDetails.employeeName);
            prefs.setString(StringConstants.employeeId,
                this.validateOtpResponse.employeeDetails.referenceId);

            prefs.setString(StringConstants.mobileNumber,
                this.validateOtpResponse.employeeDetails.mobileNumber);
          });

          openSplashScreen();
        } else {
          Get.dialog(CustomDialogs().errorDialog(validateOtpResponse.respMsg));
        }
      }
    });
  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  openSplashScreen() {
    Get.toNamed(Routes.INITIAL);
  }
}
