import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';

import 'package:async/async.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class MyApiClient {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  MyApiClient({@required this.httpClient});

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

  getFilterData(String accessKey) async {
    try {
      var response = await httpClient.get(UrlConstants.getFilterData,
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

  getAddLeadsData(String accessKey, String userSecurityKey) async {

    try {
      print(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var response = await httpClient.get(UrlConstants.addLeadsData,
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {

         var data = json.decode(response.body);
         AddLeadInitialModel addLeadInitialModel = AddLeadInitialModel.fromJson(data);
         return addLeadInitialModel;
         print(addLeadInitialModel.siteSubTypeEntity[0]);
        // return  addLeadInitialModel;
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

  getInflDetailsData(accessKey, String userSecurityKey, phoneNumber,) async {
    try {
    //  print(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      var bodyEncrypted = {
        "inflContact": phoneNumber
      };
      // print('Request body is  : ${json.encode(bodyEncrypted)}');
      // print('Request header is  : ${requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey)}');


      final response = await get(Uri.parse(UrlConstants.getInflData+"/$phoneNumber"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey),

      );
      print('Response body is  : ${json.decode(response.body)}');
     // print('Response body is  : ${json.decode(response.body)}');

      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        InfluencerDetail influencerDetailModel = InfluencerDetail.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');\
      //  print(influencerDetailModel.inflName);
        return influencerDetailModel;
      } else
        print('error');
    } catch (_) {

      print('exception ${_.toString()}');
    }

  }

  saveLeadsData(accessKey, String userSecurityKey, SaveLeadRequestModel saveLeadRequestModel, List<File> imageList) async {

    // http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.saveLeadsData));
    // request.headers.addAll(requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey));


    // for (var file in imageList) {
    //   String fileName = file.path.split("/").last;
    //   var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    //
    //   // get file length
    //
    //   var length = await file.length(); //imageFile is your image file
    //
    //   // multipart that takes file
    //   var multipartFileSign = new http.MultipartFile('photo', stream, length, filename: fileName,contentType: new MediaType('image', 'jpeg'));
    //
    //   request.files.add(multipartFileSign);
    // }

var fieldsDetail = {
  'leadSegmane': saveLeadRequestModel.leadSegmane??'abc',
  'siteSubTypeId': saveLeadRequestModel.siteSubTypeId??'abc',
  'assignedTo': saveLeadRequestModel.assignedTo??'abc',
  'leadStatusId': saveLeadRequestModel.leadStatusId??'abc',
  'leadStage': saveLeadRequestModel.leadStage??'abc',
  'contactName': saveLeadRequestModel.contactName??'abc',
  'contactNumber': saveLeadRequestModel.contactNumber??'abc',
  'geotagType': saveLeadRequestModel.geotagType??'abc',
  'leadLatitude': saveLeadRequestModel.leadLatitude??'abc',
  'leadLongitude': saveLeadRequestModel.leadLongitude??'abc',
  'leadAddress': saveLeadRequestModel.leadAddress??'abc',
  'leadPincode': saveLeadRequestModel.leadPincode??'abc',
  'leadStateName': saveLeadRequestModel.leadStateName??'abc',
  'leadDistrictName': saveLeadRequestModel.leadDistrictName??'abc',
  'leadTalukName': saveLeadRequestModel.leadTalukName??'abc',
  'leadSalesPotentialMt': saveLeadRequestModel.leadSalesPotentialMt??'abc',
  'leadReraNumber': saveLeadRequestModel.leadReraNumber??'abc',
  'assignDate': saveLeadRequestModel.assignDate??'abc',
  'isStatus': saveLeadRequestModel.isStatus??'abc',
 // 'photos': saveLeadRequestModel.photos.toString()??'abc',
  'comments': json.encode(saveLeadRequestModel.comments)??'abc',
 'influencerList': json.encode(saveLeadRequestModel.influencerList)??'abc'
};

var fieldsDetail1 = {
  'leadSegmane': "abc",
  'siteSubTypeId': 3,
  'assignedTo': "EMP0001234",
  'leadStatusId': 10,
  'leadStage': 11,
  'contactName': "Sumit",
  'contactNumber': saveLeadRequestModel.contactNumber??'abc',
  'geotagType': "Y",
  'leadLatitude': saveLeadRequestModel.leadLatitude??'abc',
  'leadLongitude': saveLeadRequestModel.leadLongitude??'abc',
  'leadAddress': saveLeadRequestModel.leadAddress??'abc',
  'leadPincode': saveLeadRequestModel.leadPincode??'abc',
  'leadStateName': saveLeadRequestModel.leadStateName??'abc',
  'leadDistrictName': saveLeadRequestModel.leadDistrictName??'abc',
  'leadTalukName': saveLeadRequestModel.leadTalukName??'abc',
  'leadSalesPotentialMt': saveLeadRequestModel.leadSalesPotentialMt??'abc',
  'leadReraNumber': saveLeadRequestModel.leadReraNumber??'abc',
  'assignDate': saveLeadRequestModel.assignDate??'abc',
  'isStatus': saveLeadRequestModel.isStatus??'abc',
  // 'photos': saveLeadRequestModel.photos.toString()??'abc',
  'comments': json.encode(saveLeadRequestModel.comments)??'abc',
  'influencerList': json.encode(saveLeadRequestModel.influencerList)??'abc'
};

  // request.fields.addAll(fieldsDetail);

//print(saveLeadRequestModel.comments[0].commentedBy);
//     print("Request headers :: " + request.headers.toString());
//     print("Request Body/Fields :: " + request.fields.toString());
   // print("Files:: " + request.files.toString());
    try {
      debugPrint('request without encryption: $fieldsDetail');
      final response = await post(Uri.parse(UrlConstants.saveLeadsData),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecurityKey),
          body: json.encode(fieldsDetail1),
          encoding: Encoding.getByName("utf-8"));
      print('response is :  ${response.body}');
      // var response = await request.send();
      // print("Response Code ::" + response.statusCode.toString());
      // print("Response  ::" + response.toString());
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });

  } catch (_) {

  print('exception ${_.toString()}');
  }






  }
}
