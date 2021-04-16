import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/models/JorneyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class MyApiClientHome {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  MyApiClientHome({@required this.httpClient});

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

  getCheckInDetails(
      String url,
      String accessKey,
      String secretKey,
      String referenceId,
      String journeyDate,
      String journeyStartTime,
      String journeyStartLat,
      String journeyStartLong,
      String journeyEndTime,
      String journeyEndLat,
      String journeyEndLong) async {
    try {

      var requestBody = {
        "reference-id": referenceId,
        "journey-Date": journeyDate,
        "journey-Start-Time": journeyStartTime,
        "journey-Start-Lat": journeyStartLat,
        "journey-Start-Long": journeyStartLong,
        "journey-End-Time": journeyEndTime,
        "journey-End-Lat": journeyEndLat,
        "journey-End-Long": journeyEndLong
      };

//      print('Request Body is ${json.encode(requestBody)}');
//      print('Request header is  ${requestHeadersWithAccessKeyAndSecretKey(accessKey, secretKey)}');

      var response = await httpClient.post(UrlConstants.getCheckInDetails,
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, secretKey),
          body: jsonEncode(requestBody));

      print('Response body is : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        JourneyModel journeyModel = JourneyModel.fromJson(data);

        //print('Access key Object is :: $accessKeyModel');
        return journeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getHomePageDashboardDetails(String empId) async {
    try {
      String url = UrlConstants.homepageDashboardData + empId;
      print(url);
      var response = await httpClient.get(url, headers: requestHeaders);
      print('Response body is : Homepage Dashboard ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        DashboardModel dashboardModel;
        dashboardModel = DashboardModel.fromJson(data);
        return dashboardModel;
      } else
        print('error');
    } catch (_) {
      print('Exception at Dashboard Repo (Homepage Dashboard Details) ${_.toString()}');
    }
  }
}
