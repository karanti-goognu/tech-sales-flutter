import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/model/TargetVSActualModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';

class MyApiClient {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String version;

  MyApiClient({@required this.httpClient});

  Future<AccessKeyModel> getAccessKey() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version= packageInfo.version;
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders(version));
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

  Future<TargetVsActualModel> getTargetVsActualData(String accessKey, String userSecretKey,String empID) async{
    TargetVsActualModel actualModel;
    try{
      print(accessKey);
      print(userSecretKey);
      var response = await http.get(Uri.parse(UrlConstants.getTargetVsActualData+empID),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version ));
          actualModel = TargetVsActualModel.fromJson(json.decode(response.body));
          // print(response.body);
    }
    catch(e){
    print("Exception at MWP Repo $e");
    }
    return actualModel;
  }




}
