import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/MonthlyViewModel.dart';
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
  final _convTargetCount = 0.obs;
  final _convTargetVolume = 0.obs;
  final _convertedCount = 0.obs;
  final _convertedVolume = 0.obs;
  final _dspRemaingTargetCount = 0.obs;
  final _dspSlabConvertedCount = 0.obs;
  final _dspSlabConvertedVolume = 0.obs;
  final _dspTargetCount = 0.obs;
  final _dspTotalOpperCount = 0.obs;
  final _dspTotalOpperVolume = 0.obs;
  final _generatedCount = 0.obs;
  final _generatedVolume = 0.obs;
  final _mwpPlanApproveStatus = ''.obs;
  final _remainingTargetCount = 0.obs;
  final _remainingTargetVolume = 0.obs;


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
        userSecurityCode = prefs.getString(StringConstants.userSecurityKey);
        empID = prefs.getString(StringConstants.employeeId);
        shareReport(
            image, userSecurityCode, this.accessKeyResponse.accessKey, empID);
      });
    });
  }

  shareReport(
      File image, String userSecurityKey, String accessKey, String empID) {
    print('waheguru path$image.path');
    print('waheguru accesskey $accessKey');
    print('waheguru secretkey $userSecurityKey');
    print(empID);
    repository
        .shareReport(image, userSecurityKey, accessKey, empID)
        .then((value) {
      print(value);
      Get.snackbar('Note', value.toString());
    });
  }

  getMonthViewDetails({String empID}) {
    print("EMP ID inside controller: $empID");
    String empId = empID??"empty";
    String userSecurityKey = "empty";
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    String yearMonth;
    if (month > 3) {
      yearMonth = year.toString() + '-' + month.toString();
    } else {
      yearMonth = (year - 1).toString() +
          '-' +
          (month.toString().length == 1
              ? '0' + month.toString()
              : month.toString());
    }
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      print("Before prefs: $empId");
      if (empId=='empty')
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print("After prefs: $empId");

      repository.getMonthViewDetails(empId, yearMonth).then((_) {
        DashboardMonthlyViewModel data = _;
        this.convTargetCount = data.convTargetCount;
        this.convTargetVolume = data.convTargetVolume;
        this.convertedCount = data.convertedCount;
        this.convertedVolume = data.convertedVolume;
        this.dspRemaingTargetCount = data.dspRemaingTargetCount;
        this.dspSlabConvertedCount = data.dspSlabConvertedCount;
        this.dspSlabConvertedVolume = data.dspSlabConvertedVolume;
        this.dspTargetCount = data.dspTargetCount;
        this.dspTotalOpperCount = data.dspTotalOpperCount;
        this.dspTotalOpperVolume = data.dspTotalOpperVolume;
        this.generatedCount = data.generatedCount;
        this.generatedVolume = data.generatedVolume;
        this.mwpPlanApproveStatus = data.mwpPlanApproveStatus;
        this.remainingTargetCount = data.remainingTargetCount;
        this.remainingTargetVolume = data.remainingTargetVolume;
      });
    }).catchError((e) => print(e));
  }



















  get accessKeyResponse => this._accessKeyResponse.value;
  get phoneNumber => this._phoneNumber.value;
  get empId => this._empId.value;
  get employeeName => this._employeeName.value;
  set accessKeyResponse(value) => this._accessKeyResponse.value = value;
  set phoneNumber(value) => this._phoneNumber.value = value;
  set empId(value) => this._empId.value = value;
  set employeeName(value) => this._employeeName.value = value;

  get convTargetCount => _convTargetCount;

  set convTargetCount(value) {
    _convTargetCount.value = value;
  }

  get dspRemaingTargetCount => _dspRemaingTargetCount;

  set dspRemaingTargetCount(value) {
    _dspRemaingTargetCount.value = value;
  }

  get dspSlabConvertedCount => _dspSlabConvertedCount;

  set dspSlabConvertedCount(value) {
    _dspSlabConvertedCount.value = value;
  }

  get dspSlabConvertedVolume => _dspSlabConvertedVolume;

  set dspSlabConvertedVolume(value) {
    _dspSlabConvertedVolume.value = value;
  }

  get dspTotalOpperVolume => _dspTotalOpperVolume;

  set dspTotalOpperVolume(value) {
    _dspTotalOpperVolume.value = value;
  }

  get dspTargetCount => _dspTargetCount;

  set dspTargetCount(value) {
    _dspTargetCount.value = value;
  }

  get dspTotalOpperCount => _dspTotalOpperCount;

  set dspTotalOpperCount(value) {
    _dspTotalOpperCount.value = value;
  }

  get generatedCount => _generatedCount;

  set generatedCount(value) {
    _generatedCount.value = value;
  }

  get generatedVolume => _generatedVolume;

  set generatedVolume(value) {
    _generatedVolume.value = value;
  }

  get mwpPlanApproveStatus => _mwpPlanApproveStatus;

  set mwpPlanApproveStatus(value) {
    _mwpPlanApproveStatus.value = value;
  }

  get remainingTargetCount => _remainingTargetCount;

  set remainingTargetCount(value) {
    _remainingTargetCount.value = value;
  }

  get remainingTargetVolume => _remainingTargetVolume;

  set remainingTargetVolume(value) {
    _remainingTargetVolume.value = value;
  }

  get convTargetVolume => _convTargetVolume;

  set convTargetVolume(value) {
    _convTargetVolume.value = value;
  }

  get convertedCount => _convertedCount;

  set convertedCount(value) {
    _convertedCount.value = value;
  }

  get convertedVolume => _convertedVolume;

  set convertedVolume(value) {
    _convertedVolume.value = value;
  }
}
