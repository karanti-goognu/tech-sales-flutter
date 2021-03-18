import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardMtdConvertedVolumeList.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardMtdGeneratedVolumeSiteList.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/MonthlyViewModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
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
      String url = UrlConstants.shareReport+empID;
      http.MultipartRequest request = new http.MultipartRequest(
          'POST', Uri.parse(url));
      request.headers.addAll(
          requestHeadersWithAccessKeyAndSecretKeywithoutContentType(accessKey, userSecurityKey));
      String fileName = image.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var multipartFileSign =
          new http.MultipartFile('file', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
      request.fields['shareReportWithFileModel '] =
          json.encode({"shareWith": "S"});
      request.send().then((result) async{
        http.Response.fromStream(result).then((response) {
          print("---@@---");
          print(response.body);
          var data = json.decode(response.body);
              print(data);

        });
          });
//      print("Request headers :: " + request.headers.toString());
//      print("Request Body/Fields :: " + request.fields.toString());
//      print("Files:: " + request.files.toString());
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
        print("waheguru: $data");
        DashboardMtdConvertedVolumeList dashboardMtdConvertedVolumeList;
        dashboardMtdConvertedVolumeList = DashboardMtdConvertedVolumeList.fromJson(data);
        return dashboardMtdConvertedVolumeList;
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Volume MTD Converted ${_.toString()}');
    }

  }
}
