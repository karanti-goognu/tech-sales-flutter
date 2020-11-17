import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApiClientLeads {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  MyApiClientLeads({@required this.httpClient});

  getAccessKey() async {
    try {
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
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

  getSecretKey(String empId, String mobile) async {
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': StringConstants.appVersion,
        'reference-id': empId,
        'mobile-number': mobile,
      };

      var response = await httpClient.get(UrlConstants.getSecretKey,
          headers: requestHeadersEmpIdAndNo);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SecretKeyModel secretKeyModel = SecretKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return secretKeyModel;
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getFilterData(String accessKey) async {
    try {
      String userSecurityKey = "empty";
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
        print('$userSecurityKey');
      });
      if (userSecurityKey == "empty") {
        var response = await httpClient.get(UrlConstants.getFilterData,
            headers: requestHeadersWithAccessKeyAndSecretKey(
                accessKey, userSecurityKey));
        print('Response body is : ${json.decode(response.body)}');
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
          //print('Access key Object is :: $accessKeyModel');
          return accessKeyModel;
        } else
          print('error');
      } else {
        print('user security key is empty');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getLeadsData(String accessKey, String securityKey, String url) async {
    try {
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      final response = await get(
          Uri.parse(url),
          headers:
              requestHeadersWithAccessKeyAndSecretKey(accessKey, securityKey));
      //var response = await httpClient.post(UrlConstants.loginCheck);
      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
        print('success');
        var data = json.decode(response.body);
        LeadsListModel leadsListModel = LeadsListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return leadsListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch${_.toString()}');
    }
  }

  getAddLeadsData(String accessKey, String userSecurityKey) async {
    try {
      print(
          requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var response = await httpClient.get(UrlConstants.addLeadsData,
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey));
      print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AddLeadInitialModel addLeadInitialModel =
            AddLeadInitialModel.fromJson(data);
        print(addLeadInitialModel.siteSubTypeEntity[0]);
        // return  addLeadInitialModel;
        // print('Initial Add Lead Object is :: $addLeadInitialModel');
        // return addLeadInitialModel;
        // print(addLeadInitialModel.siteSubTypeEntity.length);
        // AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        // //print('Access key Object is :: $accessKeyModel');
        // return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getInflDetailsData(
    accessKey,
    String userSecurityKey,
    phoneNumber,
  ) async {
    try {
      //  print(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var bodyEncrypted = {"inflContact": phoneNumber};
      print('Request body is  : ${json.encode(bodyEncrypted)}');
      print(
          'Request header is  : ${requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey)}');

      final response = await post(
        Uri.parse(UrlConstants.getInflData + "/$phoneNumber"),
        headers:
            requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey),
        body: json.encode(bodyEncrypted),
        // encoding: Encoding.getByName("utf-8")
      );
      print('Response body is  : ${json.decode(response.body)}');
      // print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }
}
