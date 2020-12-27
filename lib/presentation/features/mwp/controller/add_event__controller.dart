import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveVisitRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/saveVisitResponse.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  AddEventController({@required this.repository}) : assert(repository != null);

  final _saveVisitResponse = SaveVisitResponse().obs;
  final _selectedView = "Visit".obs;
  final _selectedMonth = "January".obs;
  final _phoneNumber = "8860080067".obs;
  final _empId = "_empty".obs;
  final _otpCode = "_empty".obs;
  final _retryOtpActive = false.obs;
  final _visitSubType = StringConstants.empty.obs;
  final _visitSiteId = StringConstants.empty.obs;
  final _visitDateTime = StringConstants.empty.obs;
  final _visitRemarks = StringConstants.empty.obs;

  final _dalmiaInflCount = StringConstants.empty.obs;
  final _nonDalmiaInflCount = StringConstants.empty.obs;
  final _venue = StringConstants.empty.obs;
  final _expectedLeadsCount = StringConstants.empty.obs;
  final _giftsDistributedCount = StringConstants.empty.obs;
  final _eventLocation = StringConstants.empty.obs;
  final _isSaveDraft = StringConstants.empty.obs;
  final _createdBy = StringConstants.empty.obs;

  get saveVisitResponse => this._saveVisitResponse.value;

  get selectedView => this._selectedView.value;

  get selectedMonth => this._selectedMonth.value;

  get phoneNumber => this._phoneNumber.value;

  get empId => this._empId.value;

  get otpCode => this._otpCode.value;

  get retryOtpActive => this._retryOtpActive.value;

  get visitSubType => this._visitSubType.value;

  get visitSiteId => this._visitSiteId.value;

  get visitDateTime => this._visitDateTime.value;

  get visitRemarks => this._visitRemarks.value;

  get dalmiaInflCount => this._dalmiaInflCount.value;

  get nonDalmiaInflCount => this._nonDalmiaInflCount.value;

  get venue => this._venue.value;

  get expectedLeadsCount => this._expectedLeadsCount.value;

  get giftsDistributedCount => this._giftsDistributedCount.value;

  get eventLocation => this._eventLocation.value;

  get isSaveDraft => this._isSaveDraft.value;

  get createdBy => this._createdBy.value;

  set saveVisitResponse(value) => this._saveVisitResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set selectedView(value) => this._selectedView.value = value;

  set selectedMonth(value) => this._selectedMonth.value = value;

  set empId(value) => this._empId.value = value;

  set otpCode(value) => this._otpCode.value = value;

  set retryOtpActive(value) => this._retryOtpActive.value = value;

  set visitSubType(value) => this._visitSubType.value = value;

  set visitDateTime(value) => this._visitDateTime.value = value;

  set visitSiteId(value) => this._visitSiteId.value = value;

  set visitRemarks(value) => this._visitRemarks.value = value;

  set dalmiaInflCount(value) => this._dalmiaInflCount.value = value;

  set nonDalmiaInflCount(value) => this._nonDalmiaInflCount.value = value;

  set venue(value) => this._venue.value = value;

  set expectedLeadsCount(value) => this._expectedLeadsCount.value = value;

  set giftsDistributedCount(value) => this._giftsDistributedCount.value = value;

  set eventLocation(value) => this._eventLocation.value = value;

  set isSaveDraft(value) => this._isSaveDraft.value = value;

  set createdBy(value) => this._createdBy.value = value;

  saveVisit(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');

      SaveVisitRequest saveVisitRequest = new SaveVisitRequest(
        empId,
        "visit",
        this.visitSubType,
        this.visitSiteId,
        this.visitDateTime,
        this.visitRemarks,
      );

      debugPrint('Save MWP Model : ${json.encode(saveVisitRequest)}');
      String url = "${UrlConstants.saveVisit}";
      debugPrint('Url is : $url');
      repository
          .saveVisitPlan(accessKey, userSecurityKey, url, saveVisitRequest)
          .then((data) {
        if (data == null) {
          debugPrint('Save Visit Response is null');
        } else {
          debugPrint('Save Visit Response is not null');
          this.saveVisitResponse = data;
          if (saveVisitResponse.respCode == "MWP2007") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
            print('${saveVisitResponse.respMsg}');
            //SitesDetailWidget();
          }
        }
      });
    });
  }

  saveMeet(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');

      SaveMeetRequest saveMeetRequest = new SaveMeetRequest(
        empId,
        "MEET",
        "CONTRACTOR MEET",
        this.visitDateTime,
        this.dalmiaInflCount,
        this.nonDalmiaInflCount,
        this.venue,
        this.expectedLeadsCount,
        this.giftsDistributedCount,
        this.eventLocation,
        this.isSaveDraft,
        this.createdBy,
        this.eventLocation,
      );

      debugPrint('Save MWP Model : ${json.encode(saveMeetRequest)}');
      String url = "${UrlConstants.saveVisit}";
      debugPrint('Url is : $url');
      repository
          .saveMeetPlan(accessKey, userSecurityKey, url, saveMeetRequest)
          .then((data) {
        if (data == null) {
          debugPrint('Save Visit Response is null');
        } else {
          debugPrint('Save Visit Response is not null');
          this.saveVisitResponse = data;
          if (saveVisitResponse.respCode == "MWP2007") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
            print('${saveVisitResponse.respMsg}');
            //SitesDetailWidget();
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

  openSplashScreen() {
    Get.toNamed(Routes.INITIAL);
  }
}
