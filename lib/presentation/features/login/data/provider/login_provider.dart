import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';



class MyApiClient {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String? version;

  MyApiClient({required this.httpClient});

  getAccessKey() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version) );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  checkLoginStatus(String empId, String mobileNumber, String? accessKey) async {
    try {
      version = VersionClass.getVersion();
      String encryptedEmpId =
          encryptString(empId, StringConstants.encryptedKey).toString();
      String encryptedMobileNumber =
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
      var bodyEncrypted = {
        "reference-id": encryptedEmpId,
        "mobile-number": encryptedMobileNumber,
        "app-name": StringConstants.appName,
        "app-version": version,
        "device-id": deviceId,
        "device-type": deviceType,
      };

      final response = await post(Uri.parse(UrlConstants.loginCheck),
          headers: requestHeadersWithAccessKey(accessKey,version) ,
          body: json.encode(bodyEncrypted),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        LoginModel loginModel = LoginModel.fromJson(data);
        return loginModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }

  retryOtp(String empId, String mobileNumber, String? accessKey,
      String? otpTokenId) async {
    try {
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

      final response = await post(Uri.parse(UrlConstants.retryOtp),
          headers: requestHeadersWithAccessKey(accessKey,version) ,
          body: json.encode(body),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        RetryOtpModel retryOtpModel = RetryOtpModel.fromJson(data);
        return retryOtpModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }

  validateOtp(String empId, String mobileNumber, String? accessKey,
      String otpCode) async {
    String encryptedEmpId =
        encryptString(empId, StringConstants.encryptedKey).toString();

    String encryptedMobile =
        encryptString(mobileNumber, StringConstants.encryptedKey).toString();

    String encryptedOtp =
        encryptString(otpCode, StringConstants.encryptedKey).toString();
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

      final response = await post(Uri.parse(UrlConstants.validateOtp),
          headers: requestHeadersWithAccessKey(accessKey,version) ,
          body: json.encode(body),
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        ValidateOtpModel validateOtpModel = ValidateOtpModel.fromJson(data);
        return validateOtpModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }
}
