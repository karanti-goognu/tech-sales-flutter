import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/core/data/models/SecretKeyModel.dart';

import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class MyApiClientApp {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  MyApiClientApp({@required this.httpClient});

  getAccessKey() async {
    try {
      // print("dsacsdcc" + requestHeaders.toString());
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

  getTargetVsActualData(String url) async {
    try {
      print('$requestHeaders');
      var response = await httpClient.get(url,
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
}
