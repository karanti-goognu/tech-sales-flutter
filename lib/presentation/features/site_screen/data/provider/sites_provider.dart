import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;

class MyApiClientSites {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  MyApiClientSites({@required this.httpClient});

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

  getSitesData(String accessKey, String securityKey, String url) async {
    try {
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      final response = await get(Uri.parse(url),
          headers:
              requestHeadersWithAccessKeyAndSecretKey(accessKey, securityKey));
      //var response = await httpClient.post(UrlConstants.loginCheck);
      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
        print('success');
        var data = json.decode(response.body);
        SitesListModel sitesListModel = SitesListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return sitesListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch ${_.toString()}');
    }
  }

  getSearchData(String accessKey, String securityKey, String url) async {
    try {
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      final response = await get(Uri.parse(url),
          headers:
              requestHeadersWithAccessKeyAndSecretKey(accessKey, securityKey));
      //var response = await httpClient.post(UrlConstants.loginCheck);
      print('response is :  ${response.body}');
      if (response.statusCode == 200) {
        print('success');
        var data = json.decode(response.body);
        SitesListModel sitesListModel = SitesListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return sitesListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch ${_.toString()}');
    }
  }

  getSiteDetailsData(String accessKey, String userSecurityKey, int siteId) async {
    try {
      //  print(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var bodyEncrypted = {"SiteId": siteId};
      // print('Request body is  : ${json.encode(bodyEncrypted)}');
      // print('Request header is  : ${requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey)}');

      print("URL is :: " + UrlConstants.getSiteData + "$siteId");
      print("Request Header :: " + json.encode(
          requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey)));
      final response = await get(
        Uri.parse(UrlConstants.getSiteData + "$siteId"),
        headers:
        requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey),
      );
      print('Response body is  : ${json.decode(response.body)}');
      // print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        Get.back();

        var data = json.decode(response.body);
        print(data);
        //print("herssssssse");


        ViewSiteDataResponse viewSiteDataResponse = ViewSiteDataResponse
            .fromJson(data);

        // print(response.);

        if (viewSiteDataResponse.respCode == "ST2010") {
          return viewSiteDataResponse;
        } else if (viewSiteDataResponse.respCode == "ST2011") {
          Get.back();
          Get.dialog(CustomDialogs()
              .showDialog(viewSiteDataResponse.respMsg));
        } else {
          Get.back();
          Get.dialog(
              CustomDialogs().showDialog("Some Error Occured !!! "));
        }


      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  updateSiteData(accessKey, String userSecurityKey, updateDataRequest, List<File> list, BuildContext context, int siteId) async {

    http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.updateSiteData));
    request.headers.addAll(requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey));


    for (var file in list) {
      String fileName = file.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      // get file length

      var length = await file.length(); //imageFile is your image file

      // multipart that takes file
      var multipartFileSign =
      new http.MultipartFile('file', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    }

    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";

      gv.currentId = empId;

      request.fields['uploadImageWithUpdateSiteModel'] =
          json.encode(updateDataRequest);

//print(saveLeadRequestModel.comments[0].commentedBy);
      print("Request headers :: " + request.headers.toString());
      print("Request Body/Fields :: " + request.fields.toString());
      print("Files:: " + request.files.toString());
      try {
        request
            .send()
            .then((result) async {
          http.Response.fromStream(result).then((response) {
            print(response.statusCode);
            print(response.body);

            var data = json.decode(response.body);
        //    print(data);

      //      print(response.body)  ;
            UpdateLeadResponseModel updateLeadResponseModel =
            UpdateLeadResponseModel.fromJson(data);
          //  print(response.body);
            if (updateLeadResponseModel.respCode == "ST2033") {
              Get.back();
              Get.dialog(
                  CustomDialogs().showDialog(updateLeadResponseModel.respMsg));

            } else  {
              Get.dialog(
                  CustomDialogs().showDialog(updateLeadResponseModel.respMsg));
            }

          });
        })
            .catchError((err) => print('error : ' + err.toString()))
            .whenComplete(() {});
      } catch (_) {
        print('exception ${_.toString()}');
      }
    });


  }
}
