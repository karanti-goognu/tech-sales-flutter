import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    super.onInit();
  }

  final MyRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  final _loginResponse = LoginModel().obs;
  final _accessKeyResponse = AccessKeyModel().obs;
  final _phoneNumber = "8860080067".obs;

  get loginResponse => this._loginResponse.value;

  get accessKeyResponse => this._accessKeyResponse.value;

  get phoneNumber => this._phoneNumber.value;

  set loginResponse(value) => this._loginResponse.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  getAccessKey(int requestId) {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;
      switch (requestId) {
        case 1:

          break;
      }
    });
  }

  getAccessKeyWithEmpId(String empId, String mobileNumber, int requestId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;
      switch (requestId) {
        case 1:
          checkLoginStatus(
              empId, mobileNumber, this.accessKeyResponse.accessKey);
          break;
      }
    });
  }

  //{"resp-code":"DM1011","resp-msg":"OTP generated successfully",
  // "otp-sms-time":"900000","otp-retry-sms-time":"180000","otp-token-id":"8e711d59-8820-41ee-b11d-59882041ee09"}

  //{"resp-code":null,"resp-msg":null,"otp-sms-time":null,"otp-retry-sms-time":null}
  checkLoginStatus(String empId, String mobileNumber, String accessKey) {
    repository.checkLoginStatus(empId, mobileNumber, accessKey).then((data) {
      if (data == null) {
        debugPrint('Login Response is null');
      } else {
        this.loginResponse = data;
        if (loginResponse.respCode == "DM1011") {
          this.phoneNumber = mobileNumber;
          Get.snackbar("Success", "${loginResponse.respMsg}");
          openOtpVerificationPage(mobileNumber);
        } else {
          Get.dialog(CustomDialogs().errorDialog(loginResponse.respMsg));
        }
      }
    });
  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }
}
