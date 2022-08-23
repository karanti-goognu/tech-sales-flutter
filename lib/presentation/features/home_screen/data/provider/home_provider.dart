import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/models/JorneyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';

class MyApiClientHome {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String? version;

  MyApiClientHome({required this.httpClient});

  getAccessKey() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version));
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

  getCheckInDetails(
      String url,
      String? accessKey,
      String secretKey,
      String referenceId,
      String? journeyDate,
      String? journeyStartTime,
      String? journeyStartLat,
      String? journeyStartLong,
      String? journeyEndTime,
      String? journeyEndLat,
      String? journeyEndLong) async {
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

      version = VersionClass.getVersion();
      var response = await httpClient.post(Uri.parse(UrlConstants.getCheckInDetails),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, secretKey,version),
          body: jsonEncode(requestBody));


      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        print("____");
        JourneyModel journeyModel = JourneyModel.fromJson(data);
        return journeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getHomePageDashboardDetails(String? accessKey,String secretKey, String empId) async {
    late DashboardModel dashboardModel;
    try {
      version = VersionClass.getVersion();
      String url = UrlConstants.homepageDashboardData + empId;
      var response = await httpClient.get(Uri.parse(url), headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,secretKey, version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        dashboardModel = DashboardModel.fromJson(data);
      } else
        print('error: ${response.statusCode}');
    } catch (_) {
      print('Exception at Dashboard Repo (Homepage Dashboard Details) ${_.toString()}');
    }
    return dashboardModel;
  }

}
