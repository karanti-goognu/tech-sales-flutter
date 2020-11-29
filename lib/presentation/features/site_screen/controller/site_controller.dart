import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/repository/sites_repository.dart';

import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositorySites repository;


  SiteController({@required this.repository})
      : assert(repository != null);

  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;
  //final _filterDataResponse = SitesFilterModel().obs;
  final _sitesListResponse = SitesListModel().obs;

  final _phoneNumber = "8860080067".obs;

  final _selectedPosition = 0.obs;
  final _selectedFilterCount = 0.obs;
  final _assignToDate = StringConstants.empty.obs;
  final _assignFromDate = StringConstants.empty.obs;
  final _searchKey = "".obs;

  final _selectedSiteStage = StringConstants.empty.obs;
  final _selectedSiteStageValue = StringConstants.empty.obs;

  final _selectedSiteStatus = StringConstants.empty.obs;
  final _selectedSiteStatusValue = StringConstants.empty.obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  get selectedFilterCount => this._selectedFilterCount.value;

  get searchKey => this._searchKey.value;

  get secretKeyResponse => this._secretKeyResponse.value;

  get assignToDate => this._assignToDate.value;

  get assignFromDate => this._assignFromDate.value;

  //get filterDataResponse => this._filterDataResponse.value;

  get sitesListResponse => this._sitesListResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get selectedPosition => this._selectedPosition.value;

  get selectedSiteStage => this._selectedSiteStage.value;

  get selectedSiteStageValue => this._selectedSiteStageValue.value;

  get selectedSiteStatus => this._selectedSiteStatus.value;

  get selectedSiteStatusValue => this._selectedSiteStatusValue.value;

  set selectedFilterCount(value) => this._selectedFilterCount.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

  //set filterDataResponse(value) => this._filterDataResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set searchKey(value) => this._searchKey.value = value;

  set assignToDate(value) => this._assignToDate.value = value;

  set assignFromDate(value) => this._assignFromDate.value = value;

  set selectedPosition(value) => this._selectedPosition.value = value;

  set selectedSiteStage(value) => this._selectedSiteStage.value = value;

  set selectedSiteStageValue(value) =>
      this._selectedSiteStageValue.value = value;

  set selectedSiteStatus(value) => this._selectedSiteStatus.value = value;

  set selectedSiteStatusValue(value) =>
      this._selectedSiteStatusValue.value = value;

  set sitesListResponse(value) => this._sitesListResponse.value = value;

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
          getAccessKey(requestId);
        } else {
          print('Secret key response is null');
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
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
        print('User Security key is :: $userSecurityKey');
        if (userSecurityKey != "empty") {
          //Map<String, dynamic> decodedToken = JwtDecoder.decode(userSecurityKey);
          bool hasExpired = JwtDecoder.isExpired(userSecurityKey);
          if (hasExpired) {
            print('Has expired');
            getSecretKey(requestId);
          } else {
            print('Not expired');
            switch (requestId) {
              case RequestIds.GET_SITES_LIST:
                getSitesData(this.accessKeyResponse.accessKey);
                break;
            }
          }
        }
      });
    });
  }

  getSitesData(String accessKey) {
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

      String assignTo = "";
      if (this.assignToDate != StringConstants.empty) {
        assignTo = "&assignDateTo=${this.assignToDate}";
      }

      String assignFrom = "";
      if (this.assignFromDate != StringConstants.empty) {
        assignFrom = "&assignDateFrom=${this.assignFromDate}";
      }

      String siteStatus = "";
      if (this.selectedSiteStatusValue != StringConstants.empty) {
        siteStatus = "&siteStatus=${this.selectedSiteStatusValue}";
      }
      String siteStage = "";
      if (this.selectedSiteStageValue != StringConstants.empty) {
        siteStage = "&siteStage=${this.selectedSiteStageValue}";
      }
      //debugPrint('request without encryption: $body');
      String url =
          "${UrlConstants.getSitesList}$empId$assignFrom$assignTo$siteStatus$siteStage&limit=500&offset=0";
      var encodedUrl = Uri.encodeFull(url);
      debugPrint('Url is : $encodedUrl');
      repository
          .getSitesData(accessKey, userSecurityKey, encodedUrl)
          .then((data) {
        if (data == null) {
          debugPrint('Sites Data Response is null');
        } else {
          this.sitesListResponse = data;
          if (sitesListResponse.respCode == "LD2006") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
          } else {
            Get.dialog(CustomDialogs().errorDialog(sitesListResponse.respMsg));
          }
        }
      });
    });
  }

  searchSites(String accessKey) {
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
          "${UrlConstants.getSearchData}$empId&searchText=${this.searchKey}";
      debugPrint('Url is : $url');
      repository.getSearchData(accessKey, userSecurityKey, url).then((data) {
        if (data == null) {
          debugPrint('Sites Data Response is null');
        } else {
          this.sitesListResponse = data;
          if (sitesListResponse.respCode == "LD2004") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('success');
            //SitesDetailWidget();
          } else {
            Get.dialog(CustomDialogs().errorDialog(sitesListResponse.respMsg));
          }
        }
      });
    });
  }

  getAccessKeyOnly() {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));

    return repository.getAccessKey();
    //   return this.accessKeyResponse;
  }

  getSitedetailsData(String accessKey, int siteId) async {
    String userSecurityKey = "";
    ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');
     // viewSiteDataResponse =  await repository.getSitedetailsDataNew(accessKey, userSecurityKey,siteId);
      viewSiteDataResponse =  await repository.getSitedetailsData( accessKey,  userSecurityKey,  siteId);
    });
    print(viewSiteDataResponse);

    return viewSiteDataResponse;


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

  void updateLeadData(var updateDataRequest, List<File> list, BuildContext context, int siteId) {

    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      // Get.back();

      this.accessKeyResponse = data;
//print(this.accessKeyResponse.accessKey);
      updateSiteDataInBackend(updateDataRequest,list,context,siteId);

    });

  }

  Future<void> updateSiteDataInBackend(updateDataRequest, List<File> list, BuildContext context, int siteId) async {

    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');

      await repository.updateSiteData(
          this.accessKeyResponse.accessKey, userSecurityKey, updateDataRequest,list,context,siteId);
    });


  }


}
