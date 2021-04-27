import 'dart:convert';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';

class MyApiClientEvent {

  final http.Client httpClient;

  MyApiClientEvent({@required this.httpClient});

  Future<AccessKeyModel> getAccessKey() async {
    try {
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
  }

  Future getGiftStockData(String empID)async{
    try{
      var url=UrlConstants.getGiftStock +empID;
      print(url);
      var response = await httpClient.get(url,headers: requestHeaders);
      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        GetGiftStockModel getGiftStockModel;
        getGiftStockModel = GetGiftStockModel.fromJson(data);
        return getGiftStockModel;
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Yearly View ${_.toString()}');
    }


  }
}