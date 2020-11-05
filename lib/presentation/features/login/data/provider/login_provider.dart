import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class MyApiClient {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  MyApiClient({@required this.httpClient});

  getAccessKey() async {
    try {
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
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

  checkLoginStatus(String empId, String mobileNumber,String accessKey) async {
    try {
      AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
      var bodyEncrypted = {
        //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
        "reference-id":
            encryptAESCryptoJS(empId, StringConstants.encryptionKey).toString(),
        "mobile-number":
            encryptAESCryptoJS(mobileNumber, StringConstants.encryptionKey)
                .toString(),
        //"device-id": " 18e86276-d1e2-4e36-bcc2-26036be5065e",
        "device-id": build.androidId,
        "device-type": build.manufacturer,
        "app-name" : StringConstants.appName,
        "app-version" : StringConstants.appVersion,
      };
      var body = {
        //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
        "reference-id":empId,
        "mobile-number":mobileNumber,
        //"device-id": " 18e86276-d1e2-4e36-bcc2-26036be5065e",
        "device-id": build.androidId,
        "device-type": build.manufacturer,
        "app-name" : StringConstants.appName,
        "app-version" : StringConstants.appVersion,
      };

      debugPrint('request with encryption: $bodyEncrypted');
      debugPrint('request without encryption: $body');
      /*debugPrint('request with encryption: ${requestHeadersWithAccessKey(accessKey)}');
      debugPrint('Url is : ${UrlConstants.loginCheck}');*/
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      final response = await post(Uri.parse(UrlConstants.loginCheck),
          headers: requestHeadersWithAccessKey(accessKey),
          body: json.encode(body),
          encoding: Encoding.getByName("utf-8"));
      //var response = await httpClient.post(UrlConstants.loginCheck);
      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
        print('success');
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
}
