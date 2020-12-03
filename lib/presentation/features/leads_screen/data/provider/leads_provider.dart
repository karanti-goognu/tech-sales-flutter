import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/helper/draftLeadDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';

import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';

import 'package:flutter_tech_sales/routes/app_pages.dart';

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

class MyApiClientLeads {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final db = DraftLeadDBHelper();
  MyApiClientLeads({@required this.httpClient});

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

  getLeadsData(String accessKey, String securityKey, String url) async {
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
        LeadsListModel leadsListModel = LeadsListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return leadsListModel;
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
        LeadsListModel leadsListModel = LeadsListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return leadsListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch ${_.toString()}');
    }
  }

  getAddLeadsData(String accessKey, String userSecurityKey) async {
    try {
      print(
          requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var response = await httpClient.get(UrlConstants.addLeadsData,
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey));
      print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AddLeadInitialModel addLeadInitialModel =
            AddLeadInitialModel.fromJson(data);
        print(addLeadInitialModel.siteSubTypeEntity[0]);
        return addLeadInitialModel;
        // print('Initial Add Lead Object is :: $addLeadInitialModel');
        // return addLeadInitialModel;
        // print(addLeadInitialModel.siteSubTypeEntity.length);
        // AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        // //print('Access key Object is :: $accessKeyModel');
        // return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getInflDetailsData(
    accessKey,
    String userSecurityKey,
    phoneNumber,
  ) async {
    try {
      //  print(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var bodyEncrypted = {"inflContact": phoneNumber};
      // print('Request body is  : ${json.encode(bodyEncrypted)}');
      // print('Request header is  : ${requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey)}');

      final response = await get(
        Uri.parse(UrlConstants.getInflData + "/$phoneNumber"),
        headers:
            requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey),
      );
      print('Response body is  : ${json.decode(response.body)}');
      // print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        InfluencerDetail influencerDetailModel =
            InfluencerDetail.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');\
        //  print(influencerDetailModel.inflName);
        return influencerDetailModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  saveLeadsData(
      accessKey,
      String userSecurityKey,
      SaveLeadRequestModel saveLeadRequestModel,
      List<File> imageList,
      BuildContext context) async {
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.saveLeadsData));
    request.headers.addAll(
        requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));

    for (var file in imageList) {
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

      var uploadImageWithLeadModel = {
        'leadSegment': "TRADE",
        'siteSubTypeId': int.parse(saveLeadRequestModel.siteSubTypeId),
        'assignedTo': empId,
        'leadStatusId': 1,
        'leadStage': 1,
        'contactName': saveLeadRequestModel.contactName,
        'contactNumber': saveLeadRequestModel.contactNumber ?? '0',
        'geotagType': saveLeadRequestModel.geotagType ?? 'M',
        'leadLatitude': saveLeadRequestModel.leadLatitude ?? '0',
        'leadLongitude': saveLeadRequestModel.leadLongitude ?? '0',
        'leadAddress': saveLeadRequestModel.leadAddress ?? 'null',
        'leadPincode': saveLeadRequestModel.leadPincode ?? '0',
        'leadStateName': saveLeadRequestModel.leadStateName ?? 'null',
        'leadDistrictName': saveLeadRequestModel.leadDistrictName ?? 'null',
        'leadTalukName': saveLeadRequestModel.leadTalukName ?? 'null',
        'leadSalesPotentialMt':
            saveLeadRequestModel.leadSalesPotentialMt ?? '0',
        'leadReraNumber': saveLeadRequestModel.leadReraNumber ?? '0',
        'isStatus': saveLeadRequestModel.isStatus ?? 'null',
        'createdBy': empId,
        'leadIsDuplicate': "N",
        'listLeadImage': saveLeadRequestModel.listLeadImage ?? 'null',
        'listLeadcomments': saveLeadRequestModel.comments ?? 'null',
        'leadInfluencerEntity': saveLeadRequestModel.influencerList ?? 'null'
      };

      request.fields['uploadImageWithLeadModel'] =
          jsonEncode(uploadImageWithLeadModel);

//print(saveLeadRequestModel.comments[0].commentedBy);
      print("Request headers :: " + request.headers.toString());
      print("Request Body/Fields :: " + request.fields.toString());
      // print("Files:: " + request.files.toString());
      try {
        request
            .send()
            .then((result) async {
              http.Response.fromStream(result).then((response) async {
                var data = json.decode(response.body);
                SaveLeadResponse saveLeadResponse =
                    SaveLeadResponse.fromJson(data);

                print(response.body);

                if (saveLeadResponse.respCode == "LD2008") {
                  Get.back();
                  gv.selectedLeadID = saveLeadResponse.leadId;
                  gv.fromLead = false;
                  Get.dialog(CustomDialogs().showExistingLeadDialog(
                      "We have an existing lead with this contact number. Do you want to",
                      context));
                } else if (saveLeadResponse.respCode == "LD2007") {
                  // if (gv.fromLead) {
                  //   await db.removeLeadInDraft(gv.draftID);
                  //   gv.fromLead = false;
                  // }
                  gv.fromLead = false;
                //  Get.toNamed(Routes.LEADS_SCREEN);
                  Get.back();
                  Get.back();
                  Get.back();
                 Get.toNamed(Routes.LEADS_SCREEN);


                  Get.dialog(CustomDialogs()
                      .showDialogSubmitLead("Lead Added Successfully !!!"));
                } else {
                  gv.fromLead = false;
                  Get.back();
                  Get.dialog(
                      CustomDialogs().showDialog("Some Error Occured !!! "));
                }


                //   if (response.statusCode == 200)
                //   {
                //     print("Uploaded! ");
                //     print('response.body '+ response.body);
                //     Get.back();
                //       Get.dialog(CustomDialogs().showDialog("Response Status : "+response.statusCode.toString()));
                //   }
                // else{
                //     Get.back();
                //     Get.dialog(CustomDialogs().showDialog("Response Status : "+response.statusCode.toString()));
                //   }
                //  return response.body;
              });
            })
            .catchError((err) => print('error : ' + err.toString()))
            .whenComplete(() {});
      } catch (_) {
        print('exception ${_.toString()}');
      }
    });
  }

  getLeadData(String accessKey, String userSecurityKey, int leadId) async {
    try {
      //  print(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var bodyEncrypted = {"leadId": leadId};
      // print('Request body is  : ${json.encode(bodyEncrypted)}');
      // print('Request header is  : ${requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey)}');

      print("URL is :: " + UrlConstants.getLeadData + "$leadId");
      print("Request Header :: " +
          json.encode(requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey)));
      final response = await get(
        Uri.parse(UrlConstants.getLeadData + "$leadId"),
        headers:
            requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey),
      );
      print('Response body is  : ${json.decode(response.body)}');
      // print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        Get.back();

        var data = json.decode(response.body);
        print(data);
        ViewLeadDataResponse viewLeadDataResponse =
            ViewLeadDataResponse.fromJson(data);
        // print(viewLeadDataResponse);
        //print('Access key Object is :: $accessKeyModel');\
        //  print(influencerDetailModel.inflName);
        //print(viewLeadDataResponse.dealerList);
        return viewLeadDataResponse;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  updateLeadsData(accessKey, String userSecurityKey, var updateRequestModel,
      List<File> imageList, BuildContext context, int leadId) async {
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.updateLeadsData));
    request.headers.addAll(
        requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));

    for (var file in imageList) {
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

      request.fields['uploadImageWithUpdateLeadModel'] =
          json.encode(updateRequestModel);

//print(saveLeadRequestModel.comments[0].commentedBy);
      print("Request headers :: " + request.headers.toString());
      print("Request Body/Fields :: " + request.fields.toString());
      // print("Files:: " + request.files.toString());
      try {
        request
            .send()
            .then((result) async {
              http.Response.fromStream(result).then((response) {
                print(response.statusCode);

                var data = json.decode(response.body);
                print(data);
                UpdateLeadResponseModel updateLeadResponseModel =
                    UpdateLeadResponseModel.fromJson(data);

                if (updateLeadResponseModel.respCode == "LD2009") {
                  //Get.back();
                  gv.selectedLeadID = updateLeadResponseModel.leadId;
                  /*  Get.dialog(CustomDialogs()
                      .showDialog(updateLeadResponseModel.respMsg));*/
                 // Get.back();
                //  Get.back();
                  Get.back();
                 // Get.back();
                  Get.offNamed(Routes.LEADS_SCREEN);
                  Get.dialog(CustomDialogs()
                      .showDialogSubmitLead(updateLeadResponseModel.respMsg));
                } else if (updateLeadResponseModel.respCode == "ED2011") {
                  Get.back();
                  Get.dialog(CustomDialogs()
                      .showDialog(updateLeadResponseModel.respMsg));
                } else {
                  Get.back();
                  Get.dialog(
                      CustomDialogs().showDialog("Some Error Occured !!! "));
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
