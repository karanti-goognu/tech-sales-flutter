
import 'dart:convert';

import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyApiClientEvent{

  final http.Client httpClient;

  MyApiClientEvent({@required this.httpClient});

  Future<AccessKeyModel> getAccessKey() async {
    try {
      // print('$requestHeaders');
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
  }

  Future<AddEventModel> getEventTypeData(String accessKey, String userSecretKey, String empID) async{
    AddEventModel addEventModel;
    try{
      // print(accessKey);
      // print(userSecretKey);
     print('DDDD: ${UrlConstants.getAddEvent}');

      var response = await http.get(Uri.parse(UrlConstants.getAddEvent+empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      addEventModel = AddEventModel.fromJson(json.decode(response.body));
      // print(response.body);
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return addEventModel;
  }

}