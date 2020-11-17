import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsFilterModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';

import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/enums/lead_stage.dart';
import 'package:flutter_tech_sales/utils/enums/lead_status.dart';
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

  AddLeadsController({@required this.repository})
      : assert(repository != null);
  final _phoneNumber = "8860080067".obs;

  get phoneNumber => this._phoneNumber.value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  final _accessKeyResponse = AccessKeyModel().obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  final _addLeadsInitialDataResponse = AddLeadInitialModel().obs;

  get addLeadsInitialDataResponse => this._addLeadsInitialDataResponse.value;

  set addLeadsInitialDataResponse(value) => this._addLeadsInitialDataResponse.value = value;

  getAccessKey(int requestId) {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();

      this.accessKeyResponse = data;
      switch (requestId) {
        case RequestIds.ADD_LEADS_DATA_REQUEST:
          getAddLeadsData();
          break;
        case RequestIds.Get_Infl_Detail:
          getInflDetailsData();
          break;
      }
    });
  }

  getAddLeadsData() {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey="";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');
      repository.getAddLeadsData(this.accessKeyResponse.accessKey, userSecurityKey).then((data) {
        if (data == null) {
          debugPrint('Add Lead Data Response is null');
        } else {
          print("Dhawan");
          print(data);
          this.addLeadsInitialDataResponse = data;
          if (addLeadsInitialDataResponse.respCode == "DM1011") {
            Get.dialog(CustomDialogs().errorDialog(addLeadsInitialDataResponse.respMsg));
          } else {
            Get.dialog(CustomDialogs().errorDialog(addLeadsInitialDataResponse.respMsg));
          }
          // this.filterDataResponse = data;
          // if (filterDataResponse.respCode == "DM1011") {
          //   Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
          // } else {
          //   Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
          // }
        }
      });
    });
    //print("access" + this.accessKeyResponse.accessKey);

  }


  getInflDetailsData() {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey="";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      userSecurityKey =prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');
      repository.getInflDetailsData(this.accessKeyResponse.accessKey, userSecurityKey,this.phoneNumber ).then((data) {
        if (data == null) {
          debugPrint('Get Infl Data Response is null');
        } else {
          print("Dhawannn");
          print(data);
          this.addLeadsInitialDataResponse = data;
          if (addLeadsInitialDataResponse.respCode == "DM1011") {
            Get.dialog(CustomDialogs().errorDialog(addLeadsInitialDataResponse.respMsg));
          } else {
            Get.dialog(CustomDialogs().errorDialog(addLeadsInitialDataResponse.respMsg));
          }
          // this.filterDataResponse = data;
          // if (filterDataResponse.respCode == "DM1011") {
          //   Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
          // } else {
          //   Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
          // }
        }
      });
    });
    //print("access" + this.accessKeyResponse.accessKey);

  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }
}
