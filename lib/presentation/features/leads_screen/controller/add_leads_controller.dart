import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLeadsController extends GetxController {
  @override
  void onInit() {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    super.onInit();
  }

  final MyRepositoryLeads repository;

  AddLeadsController({@required this.repository}) : assert(repository != null);
  final _phoneNumber = "8860080067".obs;

  get phoneNumber => this._phoneNumber.value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  final _accessKeyResponse = AccessKeyModel().obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  final _inflDetailResponse = InfluencerDetail().obs;

  get inflDetailResponse => this._inflDetailResponse.value;

  set inflDetailResponse(value) => this._inflDetailResponse.value = value;

  final _addLeadsInitialDataResponse = AddLeadInitialModel().obs;

  get addLeadsInitialDataResponse => this._addLeadsInitialDataResponse.value;

  set addLeadsInitialDataResponse(value) =>
      this._addLeadsInitialDataResponse.value = value;

  getAddLeadsData(String accessKey) async {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey = "";
    AddLeadInitialModel addLeadInitialModel = new AddLeadInitialModel();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');
      addLeadInitialModel =
          await repository.getAddLeadsData(accessKey, userSecurityKey);
    });
    return addLeadInitialModel;
    //print("access" + this.accessKeyResponse.accessKey);
  }

  getInflDetailsData(String accessKey) async {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey = "";
    InfluencerDetail influencerDetail = new InfluencerDetail();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');

      influencerDetail = await repository.getInflDetailsData(
          accessKey, userSecurityKey, this.phoneNumber);
    });
    // print("access" + this. accessKeyResponse.accessKey);
    return influencerDetail;
  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  getAccessKeyOnly() {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    return repository.getAccessKey();
    //   return this.accessKeyResponse;
  }

  getAccessKeyAndSaveLead(SaveLeadRequestModel saveLeadRequestModel,
      List<File> imageList, BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      // Get.back();

      this.accessKeyResponse = data;
//print(this.accessKeyResponse.accessKey);
      saveLeadsData(saveLeadRequestModel, imageList, context);
    });
  }

  saveLeadsData(SaveLeadRequestModel saveLeadRequestModel, List<File> imageList,
      BuildContext context) async {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');

      await repository.saveLeadsData(this.accessKeyResponse.accessKey,
          userSecurityKey, saveLeadRequestModel, imageList, context);
    });
  }

   getLeadData(String accessKey, int leadId) async {

    print(":::getLeadData()");
     String userSecurityKey = "";
    String empID = "";
    ViewLeadDataResponse viewLeadDataResponse = new ViewLeadDataResponse();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('User Security Key :: $userSecurityKey  Employee ID :: $empID');
      viewLeadDataResponse = await repository.getLeadData(accessKey, userSecurityKey, leadId, empID);
     });
    print(viewLeadDataResponse);

    return viewLeadDataResponse;
  }

  void updateLeadData(var updateRequestModel, List<File> imageList,
      BuildContext context, int leadId,int from) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      // Get.back();

      this.accessKeyResponse = data;
//print(this.accessKeyResponse.accessKey);
      updateLeadDataInBackend(updateRequestModel, imageList, context, leadId,from);
    });
  }

  Future<void> updateLeadDataInBackend(var updateRequestModel,
      List<File> imageList, BuildContext context, int leadId,int from) async {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');

      await repository.updateLeadsData(this.accessKeyResponse.accessKey,
          userSecurityKey, updateRequestModel, imageList, context, leadId,from);
    });
  }

  Future<InfluencerDetailModel> getInfNewData(String accessKey) async {
    InfluencerDetailModel _infDetailModel;
    InfluencerModel _influencerModel;
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
    //Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // String accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      _infDetailModel = await repository.getInflNewDetailsData(accessKey, userSecurityKey, this.phoneNumber);
      _influencerModel = _infDetailModel.influencerModel;
    });
    return _infDetailModel;
  }
}
