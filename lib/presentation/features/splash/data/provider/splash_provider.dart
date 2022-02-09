import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
// import 'package:package_info/package_info.dart';

class MyApiClientSplash {
  final http.Client httpClient;
  String version;

  MyApiClientSplash({@required this.httpClient});

  getAccessKey() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      //version= packageInfo.version;
      version = VersionClass.getVersion();
      Uri uri = Uri.parse(UrlConstants.getAccessKey);
      var response = await httpClient.get(uri,
          headers: requestHeaders(version));
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
    version = VersionClass.getVersion();
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': version,
        'reference-id': empId,
        'mobile-number': mobile,
      };

      print('$requestHeadersEmpIdAndNo');
      print(UrlConstants.getSecretKey);
      Uri uri = Uri.parse(UrlConstants.getSecretKey);
      var response = await httpClient.get(uri,
          headers: requestHeadersEmpIdAndNo);
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
    version = VersionClass.getVersion();
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': version,
        'access-key': accessKey,
        'user-security-key': securityKey,
      };
      print(requestHeadersEmpIdAndNo);
      Uri uri= Uri.parse(url);

      var response = await httpClient.get(uri, headers: requestHeadersEmpIdAndNo);
      print('Response body for refresh Api is : ${(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("data['employee-details']   $data");
        print(data['employee-details']);
        print("-------------");
        print("versionUpdateModel: ${data['versionUpdateModel']}");
        SplashDataModel splashDataModel = SplashDataModel.fromJson(data);
        print(splashDataModel.employeeDetails);
        //print('Access key Object is :: $accessKeyModel');
        return splashDataModel;
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }
}
