import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/SecretKeyModel.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/Pending.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/PendingSupplyDetails.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/repository/sites_repository.dart';
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

  @override
  void onReady() {
    // called after the widget is rendered on screen
    super.onReady();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    super.onClose();
  }

  final MyRepositorySites repository;

  SiteController({@required this.repository}) : assert(repository != null);

  //final _filterDataResponse = SitesFilterModel().obs;
  final _sitesListResponse = SitesListModel().obs;
  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;
  final _pendingSupplyListResponse = PendingSupplyDataResponse().obs;
  final _pendingSupplyDetailsResponse = PendingSupplyDetailsEntity().obs;

  get pendingSupplyListResponse => _pendingSupplyListResponse.value;

  set pendingSupplyListResponse(value) {
    _pendingSupplyListResponse.value = value;
  }

  get pendingSupplyDetailsResponse => _pendingSupplyDetailsResponse.value;

  set pendingSupplyDetailsResponse(value) {
    _pendingSupplyDetailsResponse.value = value;
  }

  var _sitesListOffline = List<SitesEntity>().obs;

  List<SitesEntity> _siteList = new List();


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

  get secretKeyResponse => this._secretKeyResponse.value;

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

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

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

  get sitesListOffline => _sitesListOffline;

  List<SitesEntity> get cartListing => _siteList;

  set sitesListOffline(value) {
    this._sitesListOffline.assignAll(value);
  }

  set selectedSiteInfluencerCat(value) =>
      this._selectedSiteInfluencerCat.value = value;

  set selectedSiteInfluencerCatValue(value) =>
      this._selectedSiteInfluencerCatValue.value = value;

  set sitesListResponse(value) => this._sitesListResponse.value = value;

  final _isFilterApplied = false.obs;

  get isFilterApplied => _isFilterApplied;

  set isFilterApplied(value) {
    _isFilterApplied.value = value;
  }

  // set sitesListOffline(value) => this._sitesListOffline.assignAll(value);
/*
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
        print(data.toJson()['secret-key']);
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

      if (this.accessKeyResponse.respCode == 'DM1005') {
        print(this.accessKeyResponse.respMsg);
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        _prefs.then((SharedPreferences prefs) {
          prefs.setString(StringConstants.userSecurityKey, '');
          prefs.setString(StringConstants.isUserLoggedIn, "false");
          prefs.setString(StringConstants.employeeName, '');
          prefs.setString(StringConstants.employeeId, '');
          prefs.setString(StringConstants.mobileNumber, '');
        });
        SystemNavigator.pop();
      }
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
//        print('User Security key is :: $userSecurityKey');
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
              // case RequestIds.GET_LEADS_LIST:
              //   getLeadsData(this.accessKeyResponse.accessKey);
              //   break;
              // case RequestIds.SEARCH_LEADS:
              //   searchLeads(this.accessKeyResponse.accessKey);
              //   break;
            }
          }
        }
      });
    });
  }
*/
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
      debugPrint('request without encryption: ${this.offset}');
      String url = "${UrlConstants.getSitesList}$empId$assignFrom$assignTo$siteStatus$siteStage$sitePincode$siteInfluencerCat&limit=10&offset=${this.offset}";
      //${this.offset}
      var encodedUrl = Uri.encodeFull(url);
       debugPrint('Url is : $url');
      repository
          .getSitesData(accessKey, userSecurityKey, encodedUrl)
          .then((data) {
        if (data == null) {
          debugPrint('Sites Data Response is null');
        } else {

          if(sitesListResponse.respCode == "DM1005"){
            Get.dialog(CustomDialogs().appUserInactiveDialog(
                sitesListResponse.respMsg), barrierDismissible: false);
          }
          if (this.sitesListResponse.sitesEntity == null ||
              this.sitesListResponse.sitesEntity.isEmpty) {
            this.sitesListResponse = data;
          } else {
            // this.sitesListResponse = data;
            SitesListModel sitesListModel = data;
            if (sitesListModel.sitesEntity.isNotEmpty) {
               // sitesListModel.sitesEntity=[];
              sitesListModel.sitesEntity.addAll(this.sitesListResponse.sitesEntity);
              this.sitesListResponse = sitesListModel;
              this.sitesListResponse.sitesEntity.sort((SitesEntity a, SitesEntity b) => b.createdOn.compareTo(a.createdOn));

              ///filter issue
              if(this.isFilterApplied==true){
                this.sitesListResponse = sitesListModel;
              }
              ////
              Get.rawSnackbar(
                titleText: Text("Note"),
                messageText: Text(
                    "Loading more .."),
                backgroundColor: Colors.white,
              );
            } else {
              Get.rawSnackbar(
                titleText: Text("Note"),
                messageText: Text(
                    "No more leads .."),
                backgroundColor: Colors.white,
              );
            }
            if (sitesListResponse.respCode == "ST2006") {
              //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            } else {
              Get.dialog(
                  CustomDialogs().errorDialog(sitesListResponse.respMsg));
            }
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
          } else if(sitesListResponse.respCode == "DM1005"){
            Get.dialog(CustomDialogs().appUserInactiveDialog(
                sitesListResponse.respMsg), barrierDismissible: false);
          }
          else {
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

   fetchSiteList() async {

     final db = SiteListDBHelper();
     db.fetchAllSites().then((value) => {
       this.sitesListOffline = value,
       _siteList = value
     });
     return _siteList;
    //await db.removeLeadInDraft(2);
  }

  fetchFliterSiteList(String appendQuery,String whereArgs) async {
    final db = SiteListDBHelper();
    db.filterSiteEntityList(appendQuery, whereArgs).then((value) => {
    this.sitesListOffline = value,
      _siteList = value
    });
    return _siteList;
    //await db.removeLeadInDraft(2);
  }


  fetchFliterSiteList1(List<SitesEntity> value) async {

      _siteList = value;

    return _siteList;
    //await db.removeLeadInDraft(2);
  }



  getAccessKeyAndSaveSiteRequest(
      SiteVisitRequestModel siteVisitRequestModel, ) {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));

    _prefs.then((SharedPreferences prefs) async {
      String accessKey = await repository.getAccessKeyNew();
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      await repository.siteVisitSave(accessKey, userSecurityKey, siteVisitRequestModel)
          .then((value) {
        Get.back();
        if (value.respCode == 'MWP2028') {
          Get.dialog(
              CustomDialogs().showDialogSubmitSite(value.respMsg.toString()),
              barrierDismissible: false);
        } else {
          Get.back();
          Get.dialog(
              CustomDialogs().errorDialog(value.respMsg.toString()),
              barrierDismissible: false);
        }
      });
    });
  }


  Future siteSearch(String searchText) async{
    String userSecurityKey = "";
    String empID = "";
    String accessKey = await repository.getAccessKeyNew();
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
    });
    sitesListResponse = await repository.getSearchDataNew(accessKey, userSecurityKey, empID, searchText);
  }

  pendingSupplyList() async {
    Future.delayed(Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String accessKey = await repository.getAccessKeyNew();
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";

      String url = "${UrlConstants.getPendingSupplyList+empId}";
      debugPrint('Url is : $url');
      repository.getPendingSupplyData(accessKey, userSecurityKey, url).then((data) {
        Get.back();
        if (data == null) {
          debugPrint('Supply Data Response is null');
        } else {
          this.pendingSupplyListResponse = data;
          if (pendingSupplyListResponse.respCode == "DM1002") {
            debugPrint('Supply Data Response is not null');
          }
          // else {
          //   Get.dialog(CustomDialogs().errorDialog(sitesListResponse.respMsg));
          // }
        }

      });
    });
    return pendingSupplyListResponse;
  }

  pendingSupplyDetails(String supplyHistoryId,String siteId) async {
    Future.delayed(Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String accessKey = await repository.getAccessKeyNew();
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";

      String url = "${UrlConstants.getPendingSupplyDetails+empId}&supplyHistoryId=$supplyHistoryId&siteId=$siteId";

      repository.getPendingSupplyDetails(accessKey, userSecurityKey, url).then((data) {
        Get.back();
        if (data == null) {
          debugPrint('Supply Detail Response is null');
        } else {
          this.pendingSupplyDetailsResponse = data;
          if (pendingSupplyDetailsResponse.respCode == "DM1002") {
            debugPrint('Supply Detail Response is not null');
          }
          // else {
          //   Get.dialog(CustomDialogs().errorDialog(sitesListResponse.respMsg));
          // }
        }

      });
    });
    return pendingSupplyDetailsResponse;
  }

  updatePendingSupplyDetails(Map<String, dynamic> jsonData) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String accessKey = await repository.getAccessKeyNew();
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      String url = "${UrlConstants.updatePendingSupply}";
      repository.updatePendingSupplyDetails(accessKey, userSecurityKey, url,jsonData).then((data) {
        Get.back();
        if (data == null) {
          debugPrint('Update Supply Response is null');
        } else {
          var dataValue = data;
          if(dataValue['response']['respCode']=="DM1002"){
            Get.dialog(CustomDialogs().showPendingSupplyData(dataValue['response']['respMsg']));
          }else {
            Get.dialog(
                CustomDialogs().errorDialog(dataValue['response']['respMsg']));
          }
        }
      });
    });
  }


}
