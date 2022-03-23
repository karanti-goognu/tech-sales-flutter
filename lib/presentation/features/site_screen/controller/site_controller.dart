import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/SecretKeyModel.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/KittyBagsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/Pending.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/PendingSupplyDetails.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/repository/sites_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    /// called after the widget is rendered on screen
    super.onReady();
  }

  @override
  void onClose() {
    /// called just before the Controller is deleted from memory
    super.onClose();
  }


  final MyRepositorySites repository;

  SiteController({@required this.repository}) : assert(repository != null);
  final _sitesListResponse = SitesListModel().obs;
  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;
  final _pendingSupplyListResponse = PendingSupplyDataResponse().obs;
  final _pendingSupplyDetailsResponse = PendingSupplyDetailsEntity().obs;
  final _siteDistResponse = SiteDistrictListModel().obs;
  final _kittyBagsListModel = KittyBagsListModel().obs;
  final _counterId = StringConstants.empty.obs;
  final _floorId= 0.obs;

  get floorId => _floorId.value;

  set floorId(value) {
    _floorId.value = value;
  }

  get counterId => _counterId.value;

  set counterId(value) => _counterId.value = value;

  get pendingSupplyListResponse => _pendingSupplyListResponse.value;

  set pendingSupplyListResponse(value) {
    _pendingSupplyListResponse.value = value;
  }

  get pendingSupplyDetailsResponse => _pendingSupplyDetailsResponse.value;

  set pendingSupplyDetailsResponse(value) {
    _pendingSupplyDetailsResponse.value = value;
  }



  get siteDistResponse => _siteDistResponse.value;
  set siteDistResponse(value) => _siteDistResponse.value = value;


  get kittyBagsListModel => _kittyBagsListModel.value;
  set kittyBagsListModel(value) => _kittyBagsListModel.value = value;

  var _sitesListOffline = List<SitesEntity>.empty(growable: true).obs;

  List<SitesEntity> _siteList = new List.empty(growable: true);


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

  final _selectedSiteDistrict = StringConstants.empty.obs;

  final _infName = StringConstants.empty.obs;

  final _selectedDeliveryPointsValue = StringConstants.empty.obs;

  get selectedDeliveryPointsValue => _selectedDeliveryPointsValue.value;

  set selectedDeliveryPointsValue(value) => _selectedDeliveryPointsValue.value = value;

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

  get selectedSiteDistrict => this._selectedSiteDistrict.value;

  get infname => this._infName.value;

  set selectedFilterCount(value) => this._selectedFilterCount.value = value;


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

  set selectedSiteDistrict(value) => this._selectedSiteDistrict.value = value;

  set sitesListResponse(value) => this._sitesListResponse.value = value;

  set infName(value) => this._infName.value = value;

  final _isFilterApplied = false.obs;

  get isFilterApplied => _isFilterApplied;

  set isFilterApplied(value) {
    _isFilterApplied.value = value;
  }

   getAccessKey() {
    return repository.getAccessKey();
  }

  getSitesData(BuildContext context, String accessKey,String influencerId) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      String encryptedEmpId =  encryptString(empId, StringConstants.encryptedKey).toString();

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

      String siteDistrict = "";
      if (this.selectedSiteDistrict != StringConstants.empty) {
        siteDistrict = "&siteDistrict=${this.selectedSiteDistrict}";
      }
      String deliveryPoints = "";
      if (this.selectedDeliveryPointsValue != StringConstants.empty) {
        deliveryPoints = "&deliveryPoints=${this.selectedDeliveryPointsValue}";
        switch (this.selectedDeliveryPointsValue) {
          case "Yes":
            deliveryPoints="&deliveryPoint=Y";
            break;
          case "No":
            deliveryPoints="&deliveryPoint=N";
            break;
          default:
            deliveryPoints = "";
            break;
        }
      }

      String influencerID = "";
      if (influencerId != StringConstants.empty) {
        influencerID = "&influencerID=$influencerId";
      }
      String url = "${UrlConstants.getSitesList}$empId$deliveryPoints$assignFrom$assignTo$siteStatus$siteStage$sitePincode$siteInfluencerCat$influencerID$siteDistrict&limit=10&offset=${this.offset}";
      var encodedUrl = Uri.encodeFull(url);
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
            SitesListModel sitesListModel = data;
            if (sitesListModel.sitesEntity.isNotEmpty) {
              sitesListModel.sitesEntity.addAll(this.sitesListResponse.sitesEntity);
              this.sitesListResponse = sitesListModel;
              this.sitesListResponse.sitesEntity.sort((SitesEntity a, SitesEntity b) => b.createdOn.compareTo(a.createdOn));
              if(this.isFilterApplied==true){
                this.sitesListResponse = sitesListModel;
              }
              // Get.rawSnackbar(
              //   titleText: Text("Note"),
              //   messageText: Text(
              //       "Loading more .."),
              //   backgroundColor: Colors.white,
              // );
              final snackBar = SnackBar(
                content: const Text("Loading more ..", style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 700),
                dismissDirection: DismissDirection.down,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              // Get.rawSnackbar(
              //   titleText: Text("Note"),
              //   messageText: Text(
              //       "No more leads .."),
              //   backgroundColor: Colors.white,
              // );
              final snackBar = SnackBar(
                content: const Text("No more sites ..", style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
                duration: Duration(milliseconds: 700),
                dismissDirection: DismissDirection.down,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (sitesListResponse.respCode == "ST2006") {
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
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      String encryptedEmpId = encryptString(empId, StringConstants.encryptedKey).toString();
      String url = "${UrlConstants.getSiteSearchData}searchText=${this.searchKey}&referenceID=$empId";
      repository.getSearchData(accessKey, userSecurityKey, url).then((data) {
        if (data == null) {
          debugPrint('Sites Data Response is null');
        } else {
          this.sitesListResponse = data;
          if (sitesListResponse.respCode == "ST2004") {
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

  Future<SiteDistrictListModel> getSiteDistList() async {
    String userSecurityKey = "";
    String empID = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKeyNew();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId) ?? "empty";
      siteDistResponse = await repository.getSiteDistList(accessKey, userSecurityKey, empID);
    });
    return siteDistResponse;
  }

  getAccessKeyOnly() {
    return repository.getAccessKey();
  }

  getSitedetailsData(String accessKey, int siteId) async {
    String userSecurityKey = "";
    String empID = "";
    ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID =  prefs.getString(StringConstants.employeeId);
      viewSiteDataResponse = await repository.getSitedetailsData(accessKey, userSecurityKey, siteId, empID);
    });
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

      this.accessKeyResponse = data;
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
  }

  fetchFliterSiteList(String appendQuery,String whereArgs) async {
    final db = SiteListDBHelper();
    db.filterSiteEntityList(appendQuery, whereArgs).then((value) => {
    this.sitesListOffline = value,
      _siteList = value
    });
    return _siteList;
  }


  fetchFliterSiteList1(List<SitesEntity> value) async {

      _siteList = value;

    return _siteList;
  }




  Future<SiteVisitResponseModel>getAccessKeyAndSaveSiteRequest(SiteVisitRequestModel siteVisitRequestModel) async{
    SiteVisitResponseModel siteVisitResponseModel;
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKeyNew();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      siteVisitResponseModel = await repository.siteVisitSave(accessKey, userSecurityKey, siteVisitRequestModel);
    });
    return siteVisitResponseModel;
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
      repository.getPendingSupplyData(accessKey, userSecurityKey, url).then((data) {
        Get.back();
        if (data == null) {
          debugPrint('Supply Data Response is null');
        } else {
          this.pendingSupplyListResponse = data;
          if (pendingSupplyListResponse.respCode == "DM1002") {
            debugPrint('Supply Data Response is not null');
          }
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
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";

      String url = "${UrlConstants.getPendingSupplyDetails+empId}&supplyHistoryId=$supplyHistoryId&siteId=$siteId";
      var data = await repository.getPendingSupplyDetails(accessKey, userSecurityKey, url);
        Get.back();
        if (data == null) {
          debugPrint('Supply Detail Response is null');
        } else {
          this.pendingSupplyDetailsResponse = data;
          if (pendingSupplyDetailsResponse.respCode == "DM1002") {
            debugPrint('Supply Detail Response is not null');
          }
        }
    });
    return this.pendingSupplyDetailsResponse;
  }

  Future<PendingSuppliesDetailsModel>pendingSupplyDetailsNew (String supplyHistoryId,String siteId) async {
    PendingSuppliesDetailsModel _pendingSuppliesDetailsModel;
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKeyNew();
    String empId = "empty";
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      String url = "${UrlConstants.getPendingSupplyDetails+empId}&supplyHistoryId=$supplyHistoryId&siteId=$siteId";

      _pendingSuppliesDetailsModel = await repository.getPendingSupplyDetailsNew(accessKey, userSecurityKey, url);
    });
    return _pendingSuppliesDetailsModel;
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

  ///siteKittyBags
  Future<KittyBagsListModel> getSiteKittyBags(String partyCode) async {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKeyNew();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      kittyBagsListModel = await repository.getKittyBagsList(accessKey, partyCode, userSecurityKey);
    });
    return kittyBagsListModel;
  }


}
