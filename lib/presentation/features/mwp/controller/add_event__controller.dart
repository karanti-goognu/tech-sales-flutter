import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class AddEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  AddEventController({@required this.repository}) : assert(repository != null);

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

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  openSplashScreen() {
    Get.toNamed(Routes.INITIAL);
  }
}
