import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;

class MyApiClientDashboard {
  final http.Client httpClient;

  MyApiClientDashboard({this.httpClient});

  getAccessKey() async {
    try {
      // print("dsacsdcc" + requestHeaders.toString());
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
      http.MultipartRequest request = new http.MultipartRequest(
          'POST', Uri.parse(UrlConstants.shareReport));
          print(UrlConstants.shareReport);
      request.headers.addAll(
          requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      String fileName = image.path.split("/").last;
      var stream =  
          new http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var multipartFileSign =
          new http.MultipartFile('file', stream, length, filename: fileName);
      request.files.add(multipartFileSign);
      request.fields['shareReportWithFileModel '] =
          json.encode({"shareWith": "S"});
      request.send().then((value) => print(value.statusCode));
      print("Request headers :: " + request.headers.toString());
      print("Request Body/Fields :: " + request.fields.toString());
      print("Files:: " + request.files.toString());
    } catch (_) {
      print('exception at Dashboard Repo : ShareReport method ${_.toString()}');
    }
  }
}
