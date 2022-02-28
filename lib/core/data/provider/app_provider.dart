import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/core/data/models/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/CalendarDataByDay.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/CalendarPlanModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerListResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/MeetResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveVisitRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/TargetVsActualModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/UpdateMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/UpdateVisitModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/VisitModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/saveVisitResponse.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class MyApiClientApp {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String version;
  MyApiClientApp({@required this.httpClient});

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

  getSecretKey(String empId, String mobile) async {
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': StringConstants.appVersion,
        'reference-id': empId,
        'mobile-number': mobile,
      };

      var response = await httpClient.get(Uri.parse(UrlConstants.getSecretKey),
          headers: requestHeadersEmpIdAndNo);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SecretKeyModel secretKeyModel = SecretKeyModel.fromJson(data);
        return secretKeyModel;
      } else {
      //  print('Error in else');
      }
    } catch (_) {
     // print('exception ${_.toString()}');
    }
  }

  saveMWPData(String accessKey, String userSecurityKey, String url,
      SaveMWPModel saveMWPModel) async {
    try {
      version = VersionClass.getVersion();
      var body = jsonEncode(saveMWPModel);
      var response = await httpClient.post(Uri.parse(UrlConstants.saveMWPData),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version),
          body: body,
          // encoding: Encoding.getByName("utf-8")
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Response body is : ${(data)}');
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          SaveMWPResponse saveMWPResponse = SaveMWPResponse.fromJson(data);

          return saveMWPResponse;
        }
      } else {
      //  print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  saveVisitRequest(String accessKey, String userSecurityKey, String url,
      SaveVisitRequest saveVisitRequest) async {
    try {
      version = VersionClass.getVersion();
      var body = jsonEncode(saveVisitRequest);
      var response = await httpClient.post(Uri.parse(UrlConstants.saveVisit),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version),
          body: body,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          SaveVisitResponse saveVisitResponse = SaveVisitResponse.fromJson(
              data);
          //print('Access key Object is :: $accessKeyModel');
          return saveVisitResponse;
        }
      } else {
      //  print('Error in else');
      }
    } catch (_) {
     // print('exception ${_.toString()}');
    }
  }

  saveMeetRequest(String accessKey, String userSecurityKey, String url,
      SaveMeetRequest saveMeetRequest) async {
    try {
      version = VersionClass.getVersion();
      var body = jsonEncode(saveMeetRequest);
     print('body is  :: $body');
      var response = await httpClient.post(Uri.parse(UrlConstants.saveVisit),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version),
          body: body,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          SaveVisitResponse saveVisitResponse = SaveVisitResponse.fromJson(
              data);
          //print('Access key Object is :: $accessKeyModel');
          return saveVisitResponse;
        }
      } else {
      //  print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  updateVisitPlan(String accessKey, String userSecurityKey, String url,
      UpdateVisitResponseModel updateVisitRequest) async {
    try {
      version = VersionClass.getVersion();
      var body = jsonEncode(updateVisitRequest);
      // print(url);
      // print('body is  :: $body');
      var response = await httpClient.post(Uri.parse(url), headers: requestHeadersWithAccessKeyAndSecretKey( accessKey, userSecurityKey,version),
          body: body,
          encoding: Encoding.getByName("utf-8"));
    //  print(response.body);
     //  print('Response for update visit body is : ${json.decode(response.body)}');
      print("Request: ${json.encode(updateVisitRequest)}");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          SaveVisitResponse saveVisitResponse = SaveVisitResponse.fromJson(
              data);
          //   print(saveVisitResponse);
          //print('Access key Object is :: $accessKeyModel');
          return saveVisitResponse;
        }
      } else {
      //  print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  updateMeetPlan(String accessKey, String userSecurityKey, String url,
      UpdateMeetRequest saveMeetRequest) async {
    try {
      version = VersionClass.getVersion();
      var body = jsonEncode(saveMeetRequest);
    //  print('body is  :: $body');
      var response = await httpClient.post(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version),
          body: body,
          encoding: Encoding.getByName("utf-8"));
     // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SaveVisitResponse saveVisitResponse = SaveVisitResponse.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return saveVisitResponse;
      } else {
      //  print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  getMWPData(String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
      // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
         print('ho');
         print(data['mwpplanModel']);
         print("view-mwp     $data");
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          return GetMWPResponse.fromJson(data);
        }
      } else {
        print('Error in else');
      }
    } catch (_) {
     print('exception ${_.toString()}');
    }
  }

  getDealerList(String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
    //  print('Response body is : ${json.decode(response.body)}');
//       if (response.statusCode == 200) {
         var data = json.decode(response.body);
//         if(data["resp_code"] == "DM1005"){
//           Get.dialog(CustomDialogs().appUserInactiveDialog(
//               data["resp_msg"]), barrierDismissible: false);
//         }
// else {
          return DealerListResponse.fromJson(data);
       // }
     // } else {
      //  print('Error in else');
     // }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  getVisitData(String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
    //  print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return VisitResponseModel.fromJson(data);
      } else {
       // print('Error in else');
      }
    } catch (_) {
     // print('exception ${_.toString()}');
    }
  }

  getMeetData(String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
     // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return MeetResponseModelView.fromJson(data);
      } else {
       // print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  Future<CalendarPlanModel> getCalendarPlan(String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
      // print('Response body for calendar plan is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        return CalendarPlanModel.fromJson(data);
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getCalenderPlanByDay(
      String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
      // print('Response body for calendar plan is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        return CalendarDataByDay.fromJson(data);
      } else {
      //  print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }

  getTargetSsActualPlan(
      String accessKey, String userSecurityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version));
      // print('Response body for Target Vs Actual is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        return TargetVsActualModel.fromJson(data);
      } else {
        // print('Error in else');
      }
    } catch (_) {
    //  print('exception ${_.toString()}');
    }
  }
}
