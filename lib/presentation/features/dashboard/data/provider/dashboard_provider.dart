

import 'dart:convert';
import 'dart:io';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardMtdConvertedVolumeList.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardYearlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/MonthlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApiClientDashboard {
  final http.Client? httpClient;
   String? version;
  MyApiClientDashboard({this.httpClient});

  getAccessKey() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // version= packageInfo.version;
      version = VersionClass.getVersion();
      var response = await httpClient!.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version) as Map<String, String>?);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel;
        accessKeyModel = AccessKeyModel.fromJson(data);
//        print('Access key Object is :: $accessKeyModel');
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  Future shareReport(File image, String? userSecurityKey, String? accessKey,
      String empID) async {
    try {
      var data;
      version = VersionClass.getVersion();
      String url = UrlConstants.shareReport+empID;
      http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headersWithAccessAndSecretWithoutContent(accessKey, userSecurityKey,version) as Map<String, String>);
      String fileName = image.path.split("/").last;
      var stream = new http.ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();
      var multipartFileSign =new http.MultipartFile('file', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
      request.fields['shareReportWithFileModel '] =json.encode({"shareWith": "S",  "repotName":empID});
      request.send().then((result) async{http.Response.fromStream(result).then((response) {
           data = json.decode(response.body);
 //             print(data);
           if(data["resp_code"] == "DM1005"){
             Get.dialog(CustomDialogs().appUserInactiveDialog(
                 data["resp_msg"]), barrierDismissible: false);
           }
           //else {
           Get.snackbar('Note', data['resp-msg'].toString(),backgroundColor: ColorConstants.checkInColor);
           return data;
        });
          });

    } catch (_) {
      print('exception at Dashboard Repo : ShareReport method ${_.toString()}');
    }
  }

  Future getMonthViewDetails(String empID, String yearMonth, String? accessKey, String userSecurityKey, )async{
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.dashboadrMonthlyView+empID+'&yearMonth='+yearMonth;
  //    print(url);
      var response = await httpClient!.get(Uri.parse(url),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey, version) as Map<String, String>?);
  //    print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
  //      print("Monthly data ${response.body}");
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          DashboardMonthlyViewModel dashboardMonthlyViewModel;
          dashboardMonthlyViewModel = DashboardMonthlyViewModel.fromJson(data);

          return dashboardMonthlyViewModel;
        }
      } else
        print('error_');

    }catch(_){
      print('Exception at Dashboard Repo : Monthly View ${_.toString()}');
    }


  }

  Future getDashboardMtdGeneratedVolumeSiteList(String empID, String yearMonth, String? accessKey, String userSecurityKey, ) async{
   // print('$empID $yearMonth');
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.dashboardMtdGeneratedVolumeSiteList+empID+'&yearMonth='+yearMonth;
    //  print(url);
      var response = await httpClient!.get(Uri.parse(url),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey, version) as Map<String, String>?);
   //   print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
     //   print("---$data");
        if(data["resp_code"] == "DM1005"){
          //Get.back();
      //    print("User Inactive");
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          SitesListModel dashboardMtdGeneratedVolumeSiteList;
          dashboardMtdGeneratedVolumeSiteList = SitesListModel.fromJson(data);
          return dashboardMtdGeneratedVolumeSiteList;
        }
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Volume Site List View ${_.toString()}');
    }

  }

  Future getDashboardMtdConvertedVolumeList(String empID, String yearMonth, String? accessKey, String userSecurityKey, ) async{
   // print('$empID $yearMonth');
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.dashboardMtdConvertedVolumeList+empID+'&yearMonth='+yearMonth;
    //  print(url);
      var response = await httpClient!.get(Uri.parse(url),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey, version) as Map<String, String>?);
    //  print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          DashboardMtdConvertedVolumeList dashboardMtdConvertedVolumeList;
          dashboardMtdConvertedVolumeList =
              DashboardMtdConvertedVolumeList.fromJson(data);
          return dashboardMtdConvertedVolumeList;
        }
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Volume MTD Converted ${_.toString()}');
    }

  }

  Future getYearlyViewDetails(String empID,  String? accessKey, String? userSecurityKey, )async{
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.dashboardYearlyView+empID;
     // print(url);
      var response = await httpClient!.get(Uri.parse(url),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey, version) as Map<String, String>?);
     // print('Response body is : ${json.decode(response.body)}');
    //  print('URL : ${response.request}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          DashboardYearlyViewModel dashboardYearlyViewModel;
          dashboardYearlyViewModel = DashboardYearlyViewModel.fromJson(data);
          return dashboardYearlyViewModel;
        }
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Yearly View ${_.toString()}');
    }
  }
}
