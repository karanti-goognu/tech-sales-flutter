import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class MyApiClientSplash {
  final http.Client httpClient;

  MyApiClientSplash({@required this.httpClient});

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

  getSecretKey(String empId, String mobile) async {
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': StringConstants.appVersion,
        'reference-id': empId,
        'mobile-number': mobile,
      };

      print('$requestHeadersEmpIdAndNo');
      print(UrlConstants.getSecretKey);

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

  getRefreshData(String url, String accessKey, String securityKey) async {
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': StringConstants.appVersion,
        'access-key': accessKey,
        'user-security-key': securityKey,
      };
      print(requestHeadersEmpIdAndNo);

      var response =
          await httpClient.get(url, headers: requestHeadersEmpIdAndNo);
      print('Response body is : ${(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SplashDataModel splashDataModel = SplashDataModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return splashDataModel;
        print(2);
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }
}
