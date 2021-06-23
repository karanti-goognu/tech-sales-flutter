import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/repository/splash_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

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
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
        if (userSecurityKey != "empty") {
          //Map<String, dynamic> decodedToken = JwtDecoder.decode(userSecurityKey);
          bool hasExpired = JwtDecoder.isExpired(userSecurityKey);
          if (hasExpired) {
            print('Has expired');
            getSecretKey(requestId);
          } else {
            print('Not expired');
            switch (requestId) {
              case RequestIds.REFRESH_DATA:
                print("on splash_controller.dart :::: getAccessKey");
                getRefreshData(this.accessKeyResponse.accessKey,RequestIds.GET_MASTER_DATA_FOR_SPLASH);
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
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String empId = "empty";
    String mobileNumber = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      print('$empId$mobileNumber');
      String empIdEncrypted =
          encryptString(empId, StringConstants.encryptedKey);
      String mobileNumberEncrypted =
          encryptString(mobileNumber, StringConstants.encryptedKey);
      print('$empIdEncrypted \n$mobileNumberEncrypted');
      repository.getSecretKey(empIdEncrypted, mobileNumberEncrypted).then((data) {
        Get.back();
        this.secretKeyResponse = data;

        print(data);
        if (data != null) {
          prefs.setString(StringConstants.userSecurityKey,
              this.secretKeyResponse.secretKey);
          return getAccessKey(requestId);
        } else {
          print('Secret key response is null');
        }
      });
    });
  }

   getRefreshData(String accessKey, int reqId ) async {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      String encryptedEmpId = encryptString(empId, StringConstants.encryptedKey).toString();

      //debugPrint('request without encryption: $body');
      String url = "${UrlConstants.refreshSplashData}$empId";
      debugPrint('Url is : $url');
    await  repository.getRefreshData(url, accessKey, userSecurityKey).then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          this.splashDataModel = data;
          var journeyDate= splashDataModel.journeyDetails.journeyDate;
          var journeyEndTime= splashDataModel.journeyDetails.journeyEndTime;
          prefs.setString(StringConstants.JOURNEY_DATE, journeyDate);
          prefs.setString(StringConstants.JOURNEY_END_DATE, journeyEndTime);

          if(reqId== RequestIds.GET_MASTER_DATA_FOR_SPLASH)
          openNextPage();

        }
      });
    });
  }

  openNextPage() {
    print("on splash_controller.dart openNextPage()");
    Get.offNamed(Routes.HOME_SCREEN);
  }

//  checkAppVersion() async {
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    var prefs = await SharedPreferences.getInstance();
//    String version=prefs.getString(StringConstants.appVersionForSharedPref);
////    print("version: $version");
//    String v = packageInfo.version;
////    print("v : $v");
//
//    if (version == null){
//      prefs.setString(StringConstants.appVersionForSharedPref, v);
//      prefs.setString(StringConstants.userSecurityKey, '');
//      prefs.setString(StringConstants.isUserLoggedIn, "false");
//      prefs.setString(StringConstants.employeeName, '');
//      prefs.setString(StringConstants.employeeId, '');
//      prefs.setString(StringConstants.mobileNumber, '');
//      prefs.setString(StringConstants.appVersionForSharedPref, v);
//    } else{
//      if (version==v){
////        print(version);
////        print(v);
//        print("Not updated recently");
//      }else{
////        print(version);
////        print(v);
//        print("App has been updated! Logging out");
//        prefs.setString(StringConstants.appVersionForSharedPref, v);
//        prefs.setString(StringConstants.userSecurityKey, '');
//        prefs.setString(StringConstants.isUserLoggedIn, "false");
//        prefs.setString(StringConstants.employeeName, '');
//        prefs.setString(StringConstants.employeeId, '');
//        prefs.setString(StringConstants.mobileNumber, '');
//
//      }
//    }
//  }
}
