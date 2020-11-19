import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApiClientLeads {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

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

  saveLeadsData(accessKey, String userSecurityKey,
      SaveLeadRequestModel saveLeadRequestModel, List<File> imageList) async {
    http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.saveLeadsData));
    request.headers.addAll(requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey));

    for (var file in imageList) {
      String fileName = file.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      // get file length

      var length = await file.length(); //imageFile is your image file

      // multipart that takes file
      var multipartFileSign = new http.MultipartFile('photo', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    }

    // var fieldsDetail = {
    //   'leadSegmane': saveLeadRequestModel.leadSegmane ?? 'abc',
    //   'siteSubTypeId': saveLeadRequestModel.siteSubTypeId ?? 'abc',
    //   'assignedTo': saveLeadRequestModel.assignedTo ?? 'abc',
    //   'leadStatusId': saveLeadRequestModel.leadStatusId ?? 'abc',
    //   'leadStage': saveLeadRequestModel.leadStage ?? 'abc',
    //   'contactName': saveLeadRequestModel.contactName ?? 'abc',
    //   'contactNumber': saveLeadRequestModel.contactNumber ?? 'abc',
    //   'geotagType': saveLeadRequestModel.geotagType ?? 'abc',
    //   'leadLatitude': saveLeadRequestModel.leadLatitude ?? 'abc',
    //   'leadLongitude': saveLeadRequestModel.leadLongitude ?? 'abc',
    //   'leadAddress': saveLeadRequestModel.leadAddress ?? 'abc',
    //   'leadPincode': saveLeadRequestModel.leadPincode ?? 'abc',
    //   'leadStateName': saveLeadRequestModel.leadStateName ?? 'abc',
    //   'leadDistrictName': saveLeadRequestModel.leadDistrictName ?? 'abc',
    //   'leadTalukName': saveLeadRequestModel.leadTalukName ?? 'abc',
    //   'leadSalesPotentialMt':
    //       saveLeadRequestModel.leadSalesPotentialMt ?? 'abc',
    //   'leadReraNumber': saveLeadRequestModel.leadReraNumber ?? 'abc',
    //   'assignDate': saveLeadRequestModel.assignDate ?? 'abc',
    //   'isStatus': saveLeadRequestModel.isStatus ?? 'abc',
    //   // 'photos': saveLeadRequestModel.photos.toString()??'abc',
    //   'comments': json.encode(saveLeadRequestModel.comments) ?? 'abc',
    //   'influencerList':
    //       json.encode(saveLeadRequestModel.influencerList) ?? 'abc'
    // };


    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(
          StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(
          StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(
          StringConstants.employeeName) ?? "empty";


      var uploadImageWithLeadModel = {
        'leadSegmane': "abc",
        'siteSubTypeId': int.parse(saveLeadRequestModel.siteSubTypeId),
        'assignedTo': empId,
        'leadStatusId': 1,
        'leadStage': 2,
        'contactName': saveLeadRequestModel.contactName,
        'contactNumber': saveLeadRequestModel.contactNumber ?? 'abc',
        'geotagType': "Y",
        'leadLatitude': saveLeadRequestModel.leadLatitude ?? 'abc',
        'leadLongitude': saveLeadRequestModel.leadLongitude ?? 'abc',
        'leadAddress': saveLeadRequestModel.leadAddress ?? 'abc',
        'leadPincode': saveLeadRequestModel.leadPincode ?? 'abc',
        'leadStateName': saveLeadRequestModel.leadStateName ?? 'abc',
        'leadDistrictName': saveLeadRequestModel.leadDistrictName ?? 'abc',
        'leadTalukName': saveLeadRequestModel.leadTalukName ?? 'abc',
        'leadSalesPotentialMt':
        saveLeadRequestModel.leadSalesPotentialMt ?? 'abc',
        'leadReraNumber': saveLeadRequestModel.leadReraNumber ?? 'abc',
        'assignDate': saveLeadRequestModel.assignDate ?? 'abc',
        'isStatus': saveLeadRequestModel.isStatus ?? 'abc',
        // 'photos': saveLeadRequestModel.photos.toString()??'abc',
        'createdBy':empId,
        'leadIsDuplicate':"N",
        'listLeadcomments': json.encode(saveLeadRequestModel.comments) ?? 'abc',
        'leadInfluencerEntity':
        json.encode(saveLeadRequestModel.influencerList) ?? 'abc'
      };

       request.fields['uploadImageWithLeadModel'] = json.encode(uploadImageWithLeadModel);

//print(saveLeadRequestModel.comments[0].commentedBy);
    print("Request headers :: " + request.headers.toString());
     print("Request Body/Fields :: " + request.fields.toString());
      // print("Files:: " + request.files.toString());
      try {
    //    debugPrint('request without encryption: $uploadImageWithLeadModel');
        // final response = await post(Uri.parse(UrlConstants.saveLeadsData),
        //     headers: requestHeadersWithAccessKeyAndSecretKey(
        //         accessKey, userSecurityKey),
        //     body: json.encode(uploadImageWithLeadModel),
        //     encoding: Encoding.getByName("utf-8"));
        // var streamedresponse = await request.send();
        // var response = await http.Response.fromStream(streamedresponse);
        // //var data = json.decode(response.body);
        // print(response.statusCode);
         request.send().then((result) async {

          http.Response.fromStream(result)
              .then((response) {

            if (response.statusCode == 200)
            {
              print("Uploaded! ");
              print('response.body '+ response.body);
              Get.back();
                Get.dialog(CustomDialogs().showDialog("Response Status : "+response.statusCode.toString()));
            }
          else{
              Get.back();
              Get.dialog(CustomDialogs().showDialog("Response Status : "+response.statusCode.toString()));
            }
            return response.body;

          });
        }).catchError((err) => print('error : '+err.toString()))
            .whenComplete(()
        {});
        // if (response.statusCode == 200) {
         //  var data = json.decode(response.body);
        //   //var validateOtpResponse;
        //   Get.back();
        //   Get.dialog(CustomDialogs().showDialog(data['resp-msg'] +" and Lead Id is : " + data['lead-Id']));



        // }
        // if(response.body.resp-code ==200 ){
        //   Get.dialog(CustomDialogs().errorDialog(validateOtpResponse.respMsg));
        // }

        // var response = await request.send();
        // print("Response Code ::" + response.statusCode.toString());
        // print("Response  ::" + response.toString());
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        // });

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
      print("URL is :: " + UrlConstants.getLeadData+"$leadId");
      final response = await get(
        Uri.parse(UrlConstants.getLeadData+"$leadId"),
        headers:
        requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey),
      );
      print('Response body is  : ${json.decode(response.body)}');
      // print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {
        // var data = json.decode(response.body);
        // InfluencerDetail influencerDetailModel =
        // InfluencerDetail.fromJson(data);
        // //print('Access key Object is :: $accessKeyModel');\
        // //  print(influencerDetailModel.inflName);
        // return influencerDetailModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }


  }
}
