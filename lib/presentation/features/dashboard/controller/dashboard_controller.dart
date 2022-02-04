import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardMtdConvertedVolumeList.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardYearlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/MonthlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final DashboardRepository repository;

  DashboardController({@required this.repository}) : assert(repository != null);
  final _accessKeyResponse = AccessKeyModel().obs;
  final _mtdGeneratedVolumeSiteList = SitesListModel().obs;
  final _mtdConvertedVolumeList = DashboardMtdConvertedVolumeList().obs;
  final _dashboardYearlyViewModel = DashboardYearlyViewModel().obs;
  final _monthList = [].obs;
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
  final _isPrev = false.obs;
  final _barGraphLegend1 = ''.obs;
  final _lineChartLegend1 = ''.obs;
  final _lineChartLegend2 = ''.obs;
  final _yearMonth = ''.obs;
  final _gotYearlyData = false.obs;


  get gotYearlyData => _gotYearlyData;

  set gotYearlyData(value) {
    _gotYearlyData.value = value;
  }

  get yearMonth => _yearMonth;

  set yearMonth(value) {
    _yearMonth.value = value;
  }

  final _leadGenerated=[].obs;
  final _avgLeadGenerated=[].obs;
  final _leadConverted=[].obs;
  final _avgLeadConverted=[].obs;
  final _volumeConverted=[].obs;
  final _volumeGenerated=[].obs;
  final _avgVolumeConverted=[].obs;
  final _avgVolumeGenerated=[].obs;







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

  Future<bool> getYearlyViewDetails(String empID) async {
    print("called");
    bool isProcessComplete = false;
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false));
    String userSecurityCode;
    var value= await repository.getAccessKey();
      this.accessKeyResponse = value;
     var prefs = await SharedPreferences.getInstance();
//    String empID;
//        empID = prefs.getString(StringConstants.employeeId);
    userSecurityCode = prefs.getString(StringConstants.userSecurityKey);

    empID=empID=='_empty'?prefs.getString(StringConstants.employeeId):empID;
    print(empID);

    var data= await repository.getYearlyViewDetails(empID, this.accessKeyResponse.accessKey,userSecurityCode );
          this.dashboardYearlyViewModel = data;
         // print(":::: ${json.decode(data)} ::::");
          List tempMonthList = this.dashboardYearlyViewModel.dashboardYearlyModels
              .map(
                (e) => e.showMonth,
              )
              .toList();
          this.monthList = tempMonthList.toSet().toList();
          print(this.monthList);
          this.gotYearlyData= true;

          print("IN CONTROLLER");

//          this.countAndActualList= dataX.dashboardYearlyModels.map((e) => e.leadGenerated).toList();
//          print(dataX.dashboardYearlyModels);
//          print(this.dashboardYearlyViewModel.dashboardYearlyModels);
          isProcessComplete = true;
      Get.back();
    return isProcessComplete;
  }

  getDetailsForSharingReport(File image) {
    Future.delayed(
        Duration.zero,
        () => Center(
              child: CircularProgressIndicator(),
            ));
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
    print(' path$image.path');
    repository
        .shareReport(image, userSecurityKey, accessKey, empID)
        .then((value) {
      print("Inside controller $value");
    });
  }

  Future<bool> getMonthViewDetails({String empID, String yearMonth}) async {
    bool isProcessComplete = false;
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator())));
    print("EMP ID inside controller: $empID");
    String empId = empID ?? "empty";
    String userSecurityKey = "empty";
    var value= await repository.getAccessKey();
    this.accessKeyResponse = value;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {

      print("Before prefs: $empId");
      if (empId == 'empty'||empId == '_empty'){
        empId = prefs.getString(StringConstants.employeeId) ?? "empty";

      }
      print("empId    $empId");
      userSecurityKey =  prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print("After prefs: $empId");
      print('Controller empID: ${this.empId}');
      this.empId = empId;
      print('Controller empID after month details: ${this.empId}');
      isProcessComplete = true;
      repository.getMonthViewDetails(empId, yearMonth,this.accessKeyResponse.accessKey,userSecurityKey ).then((_) {
        print(_);

        DashboardMonthlyViewModel data = _;

        if(data!=null){
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
        }
        Get.back();
      });
    }).catchError((e) => print(e));
    return isProcessComplete;
  }

  getDashboardMtdGeneratedVolumeSiteList({String empID}) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    print("EMP ID inside controller volume site list: $empID");
    String empId = empID ?? "empty";
    String userSecurityKey = "empty";
    print("YearMonth from controller: : ${this.yearMonth}");

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      if (empId == 'empty')
        empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      repository
          .getDashboardMtdGeneratedVolumeSiteList(empId, this.yearMonth.toString(),this.accessKeyResponse.accessKey,userSecurityKey )
          .then((_) {
        SitesListModel data = _;
//        print(data);
        this.mtdGeneratedVolumeSiteList = data;
        Get.back();
//        print(this.mtdGeneratedVolumeSiteList);
//        print(this.mtdGeneratedVolumeSiteList.totalSiteCount);
      });
    }).catchError((e) => print(e));
  }

  getDashboardMtdConvertedVolumeList({String empID}) {
    String empId = empID ?? "empty";
    String userSecurityKey = "empty";

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      print("Before prefs: $empId");
      if (empId == 'empty')
        empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print("After prefs: $empId");

      var _=await repository.getDashboardMtdConvertedVolumeList(empId, this.yearMonth.toString(),this.accessKeyResponse.accessKey,userSecurityKey );
        DashboardMtdConvertedVolumeList data = _;
        this.mtdConvertedVolumeList = data;
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

  get convTargetCount => _convTargetCount.value;

  set convTargetCount(value) {
    _convTargetCount.value = value;
  }

  get dspRemaingTargetCount => _dspRemaingTargetCount.value;

  set dspRemaingTargetCount(value) {
    _dspRemaingTargetCount.value = value;
  }

  get dspSlabConvertedCount => _dspSlabConvertedCount.value;

  set dspSlabConvertedCount(value) {
    _dspSlabConvertedCount.value = value;
  }

  get dspSlabConvertedVolume => _dspSlabConvertedVolume.value;

  set dspSlabConvertedVolume(value) {
    _dspSlabConvertedVolume.value = value;
  }

  get dspTotalOpperVolume => _dspTotalOpperVolume.value;

  set dspTotalOpperVolume(value) {
    _dspTotalOpperVolume.value = value;
  }

  get dspTargetCount => _dspTargetCount.value;

  set dspTargetCount(value) {
    _dspTargetCount.value = value;
  }

  get dspTotalOpperCount => _dspTotalOpperCount.value;

  set dspTotalOpperCount(value) {
    _dspTotalOpperCount.value = value;
  }

  get generatedCount => _generatedCount.value;

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

  get remainingTargetCount => _remainingTargetCount.value;

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

  get convertedCount => _convertedCount.value;

  set convertedCount(value) {
    _convertedCount.value = value;
  }

  get convertedVolume => _convertedVolume;

  set convertedVolume(value) {
    _convertedVolume.value = value;
  }

  get mtdGeneratedVolumeSiteList => _mtdGeneratedVolumeSiteList.value;

  set mtdGeneratedVolumeSiteList(value) {
    _mtdGeneratedVolumeSiteList.value = value;
  }

  get mtdConvertedVolumeList => _mtdConvertedVolumeList.value;

  set mtdConvertedVolumeList(value) {
    _mtdConvertedVolumeList.value = value;
  }

  get monthList => _monthList;

  set monthList(value) {
    _monthList.assignAll(value);
  }

  get dashboardYearlyViewModel => _dashboardYearlyViewModel.value;

  set dashboardYearlyViewModel(value) {
    _dashboardYearlyViewModel.value = value;
  }
  get isPrev => _isPrev;

  set isPrev(value) {
    _isPrev.value = value;
  }

  get avgLeadGenerated => _avgLeadGenerated;

  set avgLeadGenerated(value) {
    _avgLeadGenerated.addAll(value);
  }

  get leadConverted => _leadConverted;

  set leadConverted(value) {
    _leadConverted.addAll(value);
  }

  get avgLeadConverted => _avgLeadConverted;

  set avgLeadConverted(value) {
    _avgLeadConverted.addAll(value);
  }

  get volumeConverted => _volumeConverted;

  set volumeConverted(value) {
    _volumeConverted.addAll(value);
  }

  get volumeGenerated => _volumeGenerated;

  set volumeGenerated(value) {
    _volumeGenerated.addAll(value);
  }

  get avgVolumeConverted => _avgVolumeConverted;

  set avgVolumeConverted(value) {
    _avgVolumeConverted.addAll(value);
  }

  get avgVolumeGenerated => _avgVolumeGenerated;

  set avgVolumeGenerated(value) {
    _avgVolumeGenerated.addAll(value);
  }
  get leadGenerated => _leadGenerated;

  set leadGenerated(value) {
    _leadGenerated.addAll(value);
  }

  get lineChartLegend2 => _lineChartLegend2;

  set lineChartLegend2(value) {
    _lineChartLegend2.value = value;
  }
  get lineChartLegend1 => _lineChartLegend1;

  set lineChartLegend1(value) {
    _lineChartLegend1.value = value;
  }

  get barGraphLegend1 => _barGraphLegend1;

  set barGraphLegend1(value) {
    _barGraphLegend1.value = value;
  }

  final _barGraphLegend2 = ''.obs;

  get barGraphLegend2 => _barGraphLegend2;

  set barGraphLegend2(value) {
    _barGraphLegend2.value = value;
  }
}
