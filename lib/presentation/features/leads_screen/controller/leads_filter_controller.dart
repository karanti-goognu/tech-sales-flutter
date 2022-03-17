import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsFilterModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadsFilterController extends GetxController {
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

  final MyRepositoryLeads repository;

  LeadsFilterController({required this.repository});
  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;
  final _filterDataResponse = LeadsFilterModel().obs;
  final Rx<LeadsListModel?> _leadsListResponse = LeadsListModel().obs;
  final Rx<SiteDistrictListModel?> _leadDistResponse = SiteDistrictListModel().obs;

  final _phoneNumber = "8860080067".obs;
  final _offset = 0.obs;
  final _isFilterApplied = false.obs;

  get leadDistResponse => _leadDistResponse.value;
  set leadDistResponse(value) => _leadDistResponse.value = value;


  get isFilterApplied => _isFilterApplied;

  set isFilterApplied(value) {
    _isFilterApplied.value = value;
  }

  get offset => this._offset.value;

  set offset(value) => this._offset.value = value;



  final _selectedPosition = 0.obs;
  final _selectedFilterCount = 0.obs;
  final _assignToDate = StringConstants.empty.obs;
  final _assignFromDate = StringConstants.empty.obs;
  final _searchKey = "".obs;

  final _selectedLeadStage = StringConstants.empty.obs;
  final _selectedLeadStageValue = StringConstants.empty.obs;

  final _selectedLeadStatus = StringConstants.empty.obs;
  final _selectedLeadStatusValue = StringConstants.empty.obs;

  final _selectedLeadPotential = StringConstants.empty.obs;
  final _selectedLeadPotentialValue = StringConstants.empty.obs;
  final _selectedDeliveryPointsValue = StringConstants.empty.obs;

  final _selectedLeadDistrict = StringConstants.empty.obs;

  get selectedDeliveryPointsValue => _selectedDeliveryPointsValue.value;

  get accessKeyResponse => this._accessKeyResponse.value;

  get selectedFilterCount => this._selectedFilterCount.value;

  get searchKey => this._searchKey.value;

  get secretKeyResponse => this._secretKeyResponse.value;

  get assignToDate => this._assignToDate.value;

  get assignFromDate => this._assignFromDate.value;

  get filterDataResponse => this._filterDataResponse.value;

  get leadsListResponse => this._leadsListResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get selectedPosition => this._selectedPosition.value;

  get selectedLeadStage => this._selectedLeadStage.value;

  get selectedLeadStageValue => this._selectedLeadStageValue.value;

  get selectedLeadStatus => this._selectedLeadStatus.value;

  get selectedLeadStatusValue => this._selectedLeadStatusValue.value;

  get selectedLeadPotential => this._selectedLeadPotential.value;

  get selectedLeadPotentialValue => this._selectedLeadPotentialValue.value;

  get selectedLeadDistrict => this._selectedLeadDistrict.value;

  set selectedFilterCount(value) => this._selectedFilterCount.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

  set filterDataResponse(value) => this._filterDataResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set searchKey(value) => this._searchKey.value = value;

  set assignToDate(value) => this._assignToDate.value = value;

  set assignFromDate(value) => this._assignFromDate.value = value;

  set selectedPosition(value) => this._selectedPosition.value = value;

  set selectedLeadStage(value) => this._selectedLeadStage.value = value;

  set selectedDeliveryPointsValue(value) => _selectedDeliveryPointsValue.value = value;

  set selectedLeadStageValue(value) =>
      this._selectedLeadStageValue.value = value;

  set selectedLeadStatus(value) => this._selectedLeadStatus.value = value;

  set selectedLeadStatusValue(value) =>
      this._selectedLeadStatusValue.value = value;

  set selectedLeadPotentialValue(value) =>
      this._selectedLeadPotentialValue.value = value;

  set selectedLeadDistrict(value) => this._selectedLeadDistrict.value = value;

  set selectedLeadPotential(value) => this._selectedLeadPotential.value = value;

  set leadsListResponse(value) => this._leadsListResponse.value = value;

  String? accessKeyNew;

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

      if (this.accessKeyResponse.respCode == 'DM1005') {
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
        if (userSecurityKey != "empty") {
          //Map<String, dynamic> decodedToken = JwtDecoder.decode(userSecurityKey);
          bool hasExpired = JwtDecoder.isExpired(userSecurityKey);
          if (hasExpired) {
            getSecretKey(requestId);
          } else {
            switch (requestId) {
              case RequestIds.LEADS_FILTER_DATA_REQUEST:
                getFilterData();
                break;
              case RequestIds.GET_LEADS_LIST:
                getLeadsData(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.SEARCH_LEADS:
                searchLeads(this.accessKeyResponse.accessKey);
                break;
            }
          }
        }
      });
    });
  }

  getFilterData() {
    repository.getFilterData(this.accessKeyResponse.accessKey).then((data) {
      if (data == null) {
        debugPrint('Filter Data Response is null');
      } else {
        this.filterDataResponse = data;
        if (filterDataResponse.respCode == "DM1011") {
          //Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
        } else if(this.filterDataResponse.respCode == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              filterDataResponse.respMsg), barrierDismissible: false);
        }
        else {
          Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
        }
      }
    });
  }

  getLeadsData(String? accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      String assignTo = "";
      if (this.assignToDate != StringConstants.empty) {
        assignTo = "&assignDateTo=${this.assignToDate}";
      }

      String assignFrom = "";
      if (this.assignFromDate != StringConstants.empty) {
        assignFrom = "&assignDateFrom=${this.assignFromDate}";
      }

      String leadStatus = "";
      if (this.selectedLeadStatusValue != StringConstants.empty) {
        leadStatus = "&leadStatus=${this.selectedLeadStatusValue}";
      }
      String leadStage = "";
      if (this.selectedLeadStageValue != StringConstants.empty) {
        leadStage = "&leadStage=${this.selectedLeadStageValue}";
      }
      String leadPotentialFrom = "";
      String leadPotentialTo = "";
      if (this.selectedLeadPotentialValue != StringConstants.empty) {
        switch (selectedLeadPotentialValue) {
          case "0":
            leadPotentialFrom = "&leadPotentialFrom=0";
            leadPotentialTo = "&leadPotentialTo=200";
            break;
          case "1":
            leadPotentialFrom = "&leadPotentialFrom=201";
            leadPotentialTo = "&leadPotentialTo=500";
            break;
          case "2":
            leadPotentialFrom = "&leadPotentialFrom=501";
            break;
          default:
            leadPotentialFrom = "";
            leadPotentialTo = "";
            break;
        }
      }
      String deliveryPoints = "";
      if (this.selectedDeliveryPointsValue != StringConstants.empty) {
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

      String districtName = "";
      if (this.selectedLeadDistrict != StringConstants.empty) {
        districtName = "&districtName=${this.selectedLeadDistrict}";
      }

      //debugPrint('request without encryption: $body');
      String url = "${UrlConstants.getLeadsData}$empId$assignFrom$assignTo$leadStatus$leadStage$leadPotentialFrom$leadPotentialTo$deliveryPoints$districtName&limit=10&offset=${this.offset}";

      var encodedUrl = Uri.encodeFull(url);
      repository
          .getLeadsData(accessKey, userSecurityKey, encodedUrl)
          .then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          if(this.leadsListResponse.leadsEntity == null|| this.leadsListResponse.leadsEntity.isEmpty){
            this.leadsListResponse = data;
          }else{

            LeadsListModel leadListResponseServer = data;
            if(leadListResponseServer.leadsEntity!.isNotEmpty){
              leadListResponseServer.leadsEntity!.addAll(this.leadsListResponse.leadsEntity );
              this.leadsListResponse = leadListResponseServer;
              this.leadsListResponse.leadsEntity.sort((LeadsEntity a, LeadsEntity b) => b.createdOn!.compareTo(a.createdOn!));

              ///filter issue
              if(this.isFilterApplied==true){

                this.leadsListResponse = leadListResponseServer;
                Get.rawSnackbar(
                  titleText: Text("Note"),
                  messageText: Text(
                      "Loading more .."),
                  backgroundColor: Colors.white,
                );
              }
              Get.rawSnackbar(
                titleText: Text("Note"),
                messageText: Text(
                    "Loading more .."),
                backgroundColor: Colors.white,
              );
            }
              else{
                Get.rawSnackbar(
                  titleText: Text("Note"),
                  messageText: Text(
                      "No more leads .."),
                  backgroundColor: Colors.white,
                );
              }


          }

          if (leadsListResponse.respCode == "LD2006") {
          }else if(this.leadsListResponse.respCode == "DM1005"){
            Get.dialog(CustomDialogs().appUserInactiveDialog(
                leadsListResponse.respMsg), barrierDismissible: false);
          }
          else {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          }
        }
      });
    });
  }

  Future<LeadsListModel>?searchLeads(String? accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      String url = "${UrlConstants.getSearchData}$empId&searchText=${this.searchKey}";
      repository.getSearchData(accessKey, userSecurityKey, url).then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          this.leadsListResponse = data;
          if (leadsListResponse.respCode == "LD2004") {
            //Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
            //leadsDetailWidget();
          } else if(leadsListResponse.respCode == "DM1005"){
            Get.dialog(CustomDialogs().appUserInactiveDialog(
                leadsListResponse.respMsg), barrierDismissible: false);
          }
          else {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          }
        }
      });
    });
    return leadsListResponse;
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


  Future srSearch(String searchText) async {
    String? userSecurityKey = "";
    String? empID = "";

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    String? accessKey = await (repository.getAccessKeyNew() );
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
    });
    leadsListResponse = await repository.getSearchDataNew(
        accessKey, userSecurityKey, empID, searchText);
  }


  Future<SiteDistrictListModel?> getLeadDistList() async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? accessKey = await repository.getAccessKeyNew();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      leadDistResponse = await repository.getLeadDistList(accessKey, userSecurityKey, empID!);
    });
    return leadDistResponse;
  }

}
