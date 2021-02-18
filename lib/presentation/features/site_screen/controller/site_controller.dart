import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/Repository/sites_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositorySites repository;

  SiteController({@required this.repository}) : assert(repository != null);

  //final _filterDataResponse = SitesFilterModel().obs;
  final _sitesListResponse = SitesListModel().obs;
  final _accessKeyResponse = AccessKeyModel().obs;

  final _phoneNumber = "8860080067".obs;

  final _offset = 0.obs;
  get offset => this._offset.value;

  set offset(value) => this._offset.value = value;

  final _selectedPosition = 0.obs;
  final _selectedFilterCount = 0.obs;
  final _assignToDate = StringConstants.empty.obs;
  final _assignFromDate = StringConstants.empty.obs;
  final _sitePincode = StringConstants.empty.obs;
  final _searchKey = "".obs;

  final _selectedSiteStage = StringConstants.empty.obs;
  final _selectedSiteStageValue = StringConstants.empty.obs;

  final _selectedSiteStatus = StringConstants.empty.obs;
  final _selectedSiteStatusValue = StringConstants.empty.obs;

  final _selectedSiteInfluencerCat = StringConstants.empty.obs;
  final _selectedSiteInfluencerCatValue = StringConstants.empty.obs;

  get selectedFilterCount => this._selectedFilterCount.value;

  get accessKeyResponse => this._accessKeyResponse.value;

  get searchKey => this._searchKey.value;

  get assignToDate => this._assignToDate.value;

  get assignFromDate => this._assignFromDate.value;

  get selectedSitePincode => this._sitePincode.value;

  //get filterDataResponse => this._filterDataResponse.value;

  get sitesListResponse => this._sitesListResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get selectedPosition => this._selectedPosition.value;

  get selectedSiteStage => this._selectedSiteStage.value;

  get selectedSiteStageValue => this._selectedSiteStageValue.value;

  get selectedSiteStatus => this._selectedSiteStatus.value;

  get selectedSiteStatusValue => this._selectedSiteStatusValue.value;

  get selectedSiteInfluencerCat => this._selectedSiteInfluencerCat.value;

  get selectedSiteInfluencerCatValue =>
      this._selectedSiteInfluencerCatValue.value;

  set selectedFilterCount(value) => this._selectedFilterCount.value = value;

  //set filterDataResponse(value) => this._filterDataResponse.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set searchKey(value) => this._searchKey.value = value;

  set assignToDate(value) => this._assignToDate.value = value;

  set assignFromDate(value) => this._assignFromDate.value = value;

  set selectedPosition(value) => this._selectedPosition.value = value;

  set selectedSiteStage(value) => this._selectedSiteStage.value = value;

  set selectedSitePincode(value) => this._sitePincode.value = value;

  set selectedSiteStageValue(value) =>
      this._selectedSiteStageValue.value = value;

  set selectedSiteStatus(value) => this._selectedSiteStatus.value = value;

  set selectedSiteStatusValue(value) =>
      this._selectedSiteStatusValue.value = value;

  set selectedSiteInfluencerCat(value) =>
      this._selectedSiteInfluencerCat.value = value;

  set selectedSiteInfluencerCatValue(value) =>
      this._selectedSiteInfluencerCatValue.value = value;

  set sitesListResponse(value) => this._sitesListResponse.value = value;

  getSitesData(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      // print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      // print('User Security key is :: $userSecurityKey');
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

      String sitePincode = "";
      if (this.selectedSitePincode != StringConstants.empty) {
        siteStage = "&sitePincode=${this.selectedSitePincode}";
      }

      String siteInfluencerCat = "";
      if (this.selectedSiteInfluencerCatValue != StringConstants.empty) {
        siteStage = "&siteInflCat=${this.selectedSiteInfluencerCatValue}";
      }
      //debugPrint('request without encryption: $body');
      String url =
          "${UrlConstants.getSitesList}$empId$assignFrom$assignTo$siteStatus$siteStage$sitePincode$siteInfluencerCat&limit=500&offset=0";
      //${this.offset}
      var encodedUrl = Uri.encodeFull(url);
      // debugPrint('Url is : $encodedUrl');
      repository
          .getSitesData(accessKey, userSecurityKey, encodedUrl)
          .then((data) {
        if (data == null) {
          debugPrint('Sites Data Response is null');
        } else {
          this.sitesListResponse = data;
          if (sitesListResponse.respCode == "ST2006") {
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
          "${UrlConstants.getSiteSearchData}searchText=${this.searchKey}&referenceID=$empId";
      debugPrint('Url is : $url');
      repository.getSearchData(accessKey, userSecurityKey, url).then((data) {
        if (data == null) {
          debugPrint('Sites Data Response is null');
        } else {
          print('@@@@');
          print(data);
          this.sitesListResponse = data;
          if (sitesListResponse.respCode == "ST2004") {
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
    String empID = "";
    ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID =  prefs.getString(StringConstants.employeeId);
      print('User Security Key :: $userSecurityKey');
      viewSiteDataResponse = await repository.getSitedetailsData(accessKey, userSecurityKey, siteId, empID);
    });
//      viewSiteDataResponse = await repository.getSitedetailsData(accessKey, userSecurityKey, siteId, empID);
    // print(viewSiteDataResponse);

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

  void updateLeadData(var updateDataRequest, List<File> list,
      BuildContext context, int siteId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      // Get.back();

      this.accessKeyResponse = data;
//print(this.accessKeyResponse.accessKey);
      updateSiteDataInBackend(updateDataRequest, list, context, siteId);
    }
    );
  }

  Future<void> updateSiteDataInBackend(updateDataRequest, List<File> list,
      BuildContext context, int siteId) async {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');

      await repository.updateSiteData(this.accessKeyResponse.accessKey,
          userSecurityKey, updateDataRequest, list, context, siteId);
    });
  }
}
