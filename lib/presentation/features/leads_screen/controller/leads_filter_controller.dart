import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsFilterModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';

import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadsFilterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryLeads repository;

  LeadsFilterController({@required this.repository})
      : assert(repository != null);

  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;
  final _filterDataResponse = LeadsFilterModel().obs;
  final _leadsListResponse = LeadsListModel().obs;

  final _phoneNumber = "8860080067".obs;

  final _selectedPosition = 0.obs;
  final _selectedFilterCount = 0.obs;
  final _assignToDate = "".obs;
  final _assignFromDate = "".obs;

  final _selectedLeadStage = StringConstants.empty.obs;

  final _selectedLeadStatus = StringConstants.empty.obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  get selectedFilterCount => this._selectedFilterCount.value;

  get secretKeyResponse => this._secretKeyResponse.value;

  get assignToDate => this._assignToDate.value;

  get assignFromDate => this._assignFromDate.value;

  get filterDataResponse => this._filterDataResponse.value;

  get leadsListResponse => this._leadsListResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get selectedPosition => this._selectedPosition.value;

  get selectedLeadStage => this._selectedLeadStage.value;

  get selectedLeadStatus => this._selectedLeadStatus.value;

  set selectedFilterCount(value) => this._selectedFilterCount.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

  set filterDataResponse(value) => this._filterDataResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set assignToDate(value) => this._assignToDate.value = value;

  set assignFromDate(value) => this._assignFromDate.value = value;

  set selectedPosition(value) => this._selectedPosition.value = value;

  set selectedLeadStage(value) => this._selectedLeadStage.value = value;

  set selectedLeadStatus(value) => this._selectedLeadStatus.value = value;

  set leadsListResponse(value) => this._leadsListResponse.value = value;

  getSecretKey(int requestId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String empId = "empty";
    String mobileNumber = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      String empIdEncrypted =
          encryptString(empId, StringConstants.encryptedKey);
      String mobileNumberEncrypted =
          encryptString(mobileNumber, StringConstants.encryptedKey);
      repository
          .getSecretKey(empIdEncrypted, mobileNumberEncrypted)
          .then((data) {
        Get.back();
        this.secretKeyResponse = data;
        if (data != null) {
          prefs.setString(StringConstants.userSecurityKey,
              this.secretKeyResponse.secretKey);
          getAccessKey(RequestIds.GET_LEADS_LIST);
        } else {
          print('Secret kry response is null');
        }
      });
    });
  }

  getAccessKey(int requestId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();

      this.accessKeyResponse = data;
      switch (requestId) {
        case RequestIds.LEADS_FILTER_DATA_REQUEST:
          getFilterData();
          break;
        case RequestIds.GET_LEADS_LIST:
          getLeadsData(this.accessKeyResponse.accessKey);
          break;

        case RequestIds.SEARCH_LEADS:
          getLeadsData(this.accessKeyResponse.accessKey);
          break;
      }
    });
  }

  getFilterData() {
    debugPrint('Access Key Response :: ');
    repository.getFilterData(this.accessKeyResponse.accessKey).then((data) {
      if (data == null) {
        debugPrint('Filter Data Response is null');
      } else {
        this.filterDataResponse = data;
        if (filterDataResponse.respCode == "DM1011") {
          Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
        } else {
          Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
        }
      }
    });
  }

  getLeadsData(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');
      String encryptedEmpId =
          encryptString(empId, StringConstants.encryptedKey).toString();

      String leadStatus = "";
      if (this.selectedLeadStatus != StringConstants.empty) {
        leadStatus = "&leadStatus=${this.selectedLeadStatus}";
      }
      String leadStage = "";
      if (this.selectedLeadStage != StringConstants.empty) {
        leadStage = "&leadStage=${this.selectedLeadStage}";
      }
      //debugPrint('request without encryption: $body');
      String url =
          "${UrlConstants.getLeadsData}$encryptedEmpId$leadStatus$leadStage&limit=500&offset=0";
      debugPrint(
          'Url is : $url');
      repository
          .getLeadsData(accessKey, userSecurityKey, url)
          .then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          this.leadsListResponse = data;
          if (leadsListResponse.respCode == "LD2006") {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          } else {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          }
        }
      });
    });
  }

  searchLeads(String accessKey,String key) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');
      String encryptedEmpId =
      encryptString(empId, StringConstants.encryptedKey).toString();

      //debugPrint('request without encryption: $body');
      String url =
          "${UrlConstants.getLeadsData}$encryptedEmpId$leadStatus$leadStage&limit=500&offset=0";
      debugPrint(
          'Url is : $url');
      repository
          .getLeadsData(accessKey, userSecurityKey, url)
          .then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          this.leadsListResponse = data;
          if (leadsListResponse.respCode == "LD2006") {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          } else {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          }
        }
      });
    });
  }

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
}
