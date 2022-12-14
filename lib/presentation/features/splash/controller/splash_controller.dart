import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/core/services/notification_service.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/repository/splash_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final MyRepositorySplash repository;

  SplashController({@required this.repository}) : assert(repository != null);

  final _login = LoginModel().obs;
  final _accessKeyResponse = AccessKeyModel().obs;
  final _splashDataModel = SplashDataModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;

  get login => this._login.value;

  get accessKeyResponse => this._accessKeyResponse.value;

  get splashDataModel => this._splashDataModel.value;

  get secretKeyResponse => this._secretKeyResponse.value;

  set splashDataModel(value) => this._splashDataModel.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

  getAccessKey(int requestId) {
    Future.delayed(
        Duration.zero,
            () =>
            Get.dialog(Center(child: CircularProgressIndicator()),
                barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
        if (userSecurityKey != "empty") {
          bool hasExpired = JwtDecoder.isExpired(userSecurityKey);
          if (hasExpired) {
            getSecretKey(requestId);
          } else {
            switch (requestId) {
              case RequestIds.REFRESH_DATA:
                getRefreshData(this.accessKeyResponse.accessKey,
                    RequestIds.GET_MASTER_DATA_FOR_SPLASH);
                break;
            }
          }
          return data;
        }
      });
    });
  }

  getSecretKey(int requestId) {
    Future.delayed(
        Duration.zero,
            () =>
            Get.dialog(Center(child: CircularProgressIndicator()),
                barrierDismissible: false));
    String empId = "empty";
    String mobileNumber = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String isUserLoggedIn =
          prefs.getString(StringConstants.isUserLoggedIn) ?? "false";
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
          if (this.secretKeyResponse.respCode == "DM1005") {
            Get.dialog(
                CustomDialogs()
                    .appUserInactiveDialog(this.secretKeyResponse.respMsg),
                barrierDismissible: false);
          }
          if (isUserLoggedIn == "false") {
            Get.offNamed(Routes.LOGIN);
          }
          prefs.setString(StringConstants.userSecurityKey,
              this.secretKeyResponse.secretKey);
          return getAccessKey(requestId);
        } else {
          print('Secret key response is null');
        }
      });
    });
  }

  getRefreshData(String accessKey, int reqId) async {
    List<VersionUpdateModel> versionUpdateModel = new List.empty(
        growable: true);
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      // String encryptedEmpId =
      // encryptString(empId, StringConstants.encryptedKey).toString();

      String url = "${UrlConstants.refreshSplashData}$empId";
      await repository
          .getRefreshData(url, accessKey, userSecurityKey)
          .then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          this.splashDataModel = data;
          versionUpdateModel = this.splashDataModel.versionUpdateModel;
          if (versionUpdateModel != null && versionUpdateModel.length > 0) {
            for (int i = 0; i < versionUpdateModel.length; i++) {
              if (versionUpdateModel[i].platform == "ANDROID") {
                if (versionUpdateModel[i].oldVersion !=
                    versionUpdateModel[i].newVersion &&
                    versionUpdateModel[i].updateType == "SOFT") {
                  Get.dialog(
                      CustomDialogs().appUpdateDialog(
                          versionUpdateModel[i].versionUpdateText,
                          versionUpdateModel[i].appId,
                          "ANDROID"),
                      barrierDismissible: true)
                      .then((value) => openNextPage(1));
                } else if (versionUpdateModel[i].oldVersion !=
                    versionUpdateModel[i].newVersion &&
                    versionUpdateModel[i].updateType == "HARD") {
                  Get.dialog(
                      CustomDialogs().appForceUpdateDialog(
                          versionUpdateModel[i].versionUpdateText,
                          versionUpdateModel[i].appId,
                          "ANDROID"),
                      barrierDismissible: false);
                }
              }
              if (versionUpdateModel[i].platform == "IOS") {
                if (versionUpdateModel[i].oldVersion !=
                    versionUpdateModel[i].newVersion &&
                    versionUpdateModel[i].updateType == "SOFT") {
                  Get.dialog(
                      CustomDialogs().appUpdateDialog(
                          versionUpdateModel[i].versionUpdateText,
                          versionUpdateModel[i].appId,
                          "IOS"),
                      barrierDismissible: true)
                      .then((value) => openNextPage(2));
                } else if (versionUpdateModel[i].oldVersion !=
                    versionUpdateModel[i].newVersion &&
                    versionUpdateModel[i].updateType == "HARD") {
                  Get.dialog(
                      CustomDialogs().appForceUpdateDialog(
                          versionUpdateModel[i].versionUpdateText,
                          versionUpdateModel[i].appId,
                          "IOS"),
                      barrierDismissible: false);
                }
              }
            }
          }
          else {
            var journeyDate = splashDataModel.journeyDetails.journeyDate;
            var journeyEndTime = splashDataModel.journeyDetails.journeyEndTime;

            if (journeyDate != null) {
              prefs.setString(StringConstants.JOURNEY_DATE, journeyDate);
            } else {
              prefs.setString(StringConstants.JOURNEY_DATE, "NA");
            }
            if (journeyEndTime != null) {
              prefs.setString(StringConstants.JOURNEY_END_DATE, journeyEndTime);
            }
            if (reqId == RequestIds.GET_MASTER_DATA_FOR_SPLASH)
              openNextPage(3);
          }
        }
      });
    });
  }

  openNextPage(int n) {
    if (MoengageService.isPushClickCall)
      MoengageService.isPushClickCall = false;
    else
      Get.offNamed(Routes.HOME_SCREEN);
  }
}
