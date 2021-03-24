import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardMtdConvertedVolumeList.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardMtdGeneratedVolumeSiteList.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardYearlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/MonthlyViewModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApiClientDashboard {
  final http.Client httpClient;

  MyApiClientDashboard({this.httpClient});

  getAccessKey() async {
    try {
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel;
        accessKeyModel = AccessKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  Future shareReport(File image, String userSecurityKey, String accessKey,
      String empID) async {
    try {
      var data;
      String url = UrlConstants.shareReport+empID;
      http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(requestHeadersWithAccessKeyAndSecretKeywithoutContentType(accessKey, userSecurityKey));
      String fileName = image.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var multipartFileSign =new http.MultipartFile('file', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
      request.fields['shareReportWithFileModel '] =json.encode({"shareWith": "S",  "repotName":empID});
      request.send().then((result) async{http.Response.fromStream(result).then((response) {
           data = json.decode(response.body);
              print(data);
           Get.snackbar('Note', data['resp-msg'].toString(),backgroundColor: ColorConstants.checkinColor);
           return data;
        });
          });

    } catch (_) {
      print('exception at Dashboard Repo : ShareReport method ${_.toString()}');
    }
  }

  Future getMonthViewDetails(String empID, String yearMonth)async{
    try{
      var url=UrlConstants.dashboadrMonthlyView+empID+'&yearMonth='+yearMonth;
      print(url);
      var response = await httpClient.get(url,headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        DashboardMonthlyViewModel dashboardMonthlyViewModel;
        dashboardMonthlyViewModel = DashboardMonthlyViewModel.fromJson(data);
        return dashboardMonthlyViewModel;
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Monthly View ${_.toString()}');
    }


  }

  Future getDashboardMtdGeneratedVolumeSiteList(String empID, String yearMonth) async{
    print('$empID $yearMonth');
    try{
      var url=UrlConstants.dashboardMtdGeneratedVolumeSiteList+'EMP0006700'+'&yearMonth='+yearMonth;
      print(url);
      var response = await httpClient.get(url,headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        DashboardMtdGeneratedVolumeSiteList dashboardMtdGeneratedVolumeSiteList;
        dashboardMtdGeneratedVolumeSiteList = DashboardMtdGeneratedVolumeSiteList.fromJson(data);
        return dashboardMtdGeneratedVolumeSiteList;
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Volume Site List View ${_.toString()}');
    }

  }

  Future getDashboardMtdConvertedVolumeList(String empID, String yearMonth) async{
    print('$empID $yearMonth');
    try{
      var url=UrlConstants.dashboardMtdConvertedVolumeList+'EMP0006700'+'&yearMonth='+yearMonth;
      print(url);
      var response = await httpClient.get(url,headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        DashboardMtdConvertedVolumeList dashboardMtdConvertedVolumeList;
        dashboardMtdConvertedVolumeList = DashboardMtdConvertedVolumeList.fromJson(data);
        return dashboardMtdConvertedVolumeList;
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Volume MTD Converted ${_.toString()}');
    }

  }

  Future getYearlyViewDetails(String empID)async{
    try{
      var url=UrlConstants.dashboardYearlyView+empID;
      print(url);
      var response = await httpClient.get(url,headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        DashboardYearlyViewModel dashboardYearlyViewModel;
        dashboardYearlyViewModel = DashboardYearlyViewModel.fromJson(data);
        return dashboardYearlyViewModel;
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Yearly View ${_.toString()}');
    }


  }
}
