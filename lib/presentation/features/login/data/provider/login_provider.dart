import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'dart:io';

import 'package:package_info/package_info.dart';

class MyApiClient {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String version;

  MyApiClient({@required this.httpClient});

  getAccessKey() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // version= packageInfo.version;
      version = VersionClass.getVersion();
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders(version));
//      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  checkLoginStatus(String empId, String mobileNumber, String accessKey) async {
    try {
      version = VersionClass.getVersion();
      String encryptedEmpId =
          encryptString(empId, StringConstants.encryptedKey).toString();

      String decryptedEmpId =
          decryptString(encryptedEmpId, StringConstants.encryptedKey)
              .toString();

      String encryptedMobileNumber =
          encryptString(mobileNumber, StringConstants.encryptedKey).toString();

      String decryptedMobileNumber =
          decryptString(encryptedMobileNumber, StringConstants.encryptedKey)
              .toString();

      var deviceId, deviceType;

      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        deviceId = build.androidId;
        deviceType = build.manufacturer;
      }else{
        IosDeviceInfo buildIos = await deviceInfoPlugin.iosInfo;
        deviceId = buildIos.identifierForVendor;
        deviceType = buildIos.model;
      }
      var bodyEncrypted = {
        "reference-id": encryptedEmpId,
        "mobile-number": encryptedMobileNumber,
        "app-name": StringConstants.appName,
        "app-version": version,
        "device-id": deviceId,
        "device-type": deviceType,

      };

//      print('request with encryption: $bodyEncrypted');
//      print('decrypted EmpId :: $decryptedEmpId   Encrypted MobileNumber :: $decryptedMobileNumber');
      //debugPrint('request without encryption: $body');
//      print('request with encryption: ${requestHeadersWithAccessKey(accessKey)}');
//      print('Url is : ${UrlConstants.loginCheck}');
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      final response = await post(Uri.parse(UrlConstants.loginCheck),
          headers: requestHeadersWithAccessKey(accessKey,version),
          body: json.encode(bodyEncrypted),
          encoding: Encoding.getByName("utf-8"));
      //var response = await httpClient.post(UrlConstants.loginCheck);
//      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
//        print('success');
        var data = json.decode(response.body);
        LoginModel loginModel = LoginModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return loginModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }

  retryOtp(String empId, String mobileNumber, String accessKey,
      String otpTokenId) async {
    try {
//      print('Token Id :: $otpTokenId');
      version = VersionClass.getVersion();
      String encryptedEmpId =
          encryptString(empId, StringConstants.encryptedKey).toString();

      String encryptedMobile =
          encryptString(mobileNumber, StringConstants.encryptedKey).toString();

      var deviceId, deviceType;

      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        deviceId = build.androidId;
        deviceType = build.manufacturer;
      }else{
        IosDeviceInfo buildIos = await deviceInfoPlugin.iosInfo;
        deviceId = buildIos.identifierForVendor;
        deviceType = buildIos.model;
      }

      var body = {
        "reference-id": encryptedEmpId,
        "mobile-number": encryptedMobile,
        "device-id": deviceId,
        "device-type": deviceType,
        "app-name": StringConstants.appName,
        "app-version": version,
        "otp-token-id": otpTokenId,
      };

      debugPrint('request without encryption: $body');
      debugPrint('request without encryption: ${json.encode(body)}');
      final response = await post(Uri.parse(UrlConstants.retryOtp),
          headers: requestHeadersWithAccessKey(accessKey,version),
          body: json.encode(body),
          encoding: Encoding.getByName("utf-8"));
      //var response = await httpClient.post(UrlConstants.loginCheck);
//      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
//        print('success');
        var data = json.decode(response.body);
        RetryOtpModel retryOtpModel = RetryOtpModel.fromJson(data);
//        print('Retry Model key Object is :: ${json.encode(retryOtpModel)}');
        return retryOtpModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }

  validateOtp(String empId, String mobileNumber, String accessKey,
      String otpCode) async {
    String encryptedEmpId =
        encryptString(empId, StringConstants.encryptedKey).toString();

    String encryptedMobile =
        encryptString(mobileNumber, StringConstants.encryptedKey).toString();

    String encryptedOtp =
        encryptString(otpCode, StringConstants.encryptedKey).toString();

    String decryptedOtp =
        decryptString(encryptedOtp, StringConstants.encryptedKey).toString();

//    print('$encryptedOtp  -----Decrypt String :: $decryptedOtp');
    try {
      var deviceId, deviceType;
      version = VersionClass.getVersion();
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        deviceId = build.androidId;
        deviceType = build.manufacturer;
      }else{
        IosDeviceInfo buildIos = await deviceInfoPlugin.iosInfo;
        deviceId = buildIos.identifierForVendor;
        deviceType = buildIos.model;
      }
      var body = {
        "reference-id": encryptedEmpId,
        "mobile-number": encryptedMobile,
        "device-id": deviceId,
        "device-type": deviceType,
        "app-name": StringConstants.appName,
        "app-version": version,
        "otp-code": encryptedOtp,
      };

//      debugPrint('request without encryption: $body');
//      debugPrint('request headers: ${requestHeadersWithAccessKey(accessKey)}');
      final response = await post(Uri.parse(UrlConstants.validateOtp),
          headers: requestHeadersWithAccessKey(accessKey,version),
          body: json.encode(body),
          encoding: Encoding.getByName("utf-8"));
//      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
//        print('success');
        var data = json.decode(response.body);
        print(data);
        ValidateOtpModel validateOtpModel = ValidateOtpModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return validateOtpModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }
}
