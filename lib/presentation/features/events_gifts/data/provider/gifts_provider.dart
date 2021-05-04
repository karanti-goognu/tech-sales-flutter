import 'dart:convert';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/LogsModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';

class MyApiClientEvent {

  final http.Client httpClient;

  MyApiClientEvent({@required this.httpClient});

  Future<String> getAccessKey() async {
    try {
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        return accessKeyModel.accessKey;
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
  }

  Future getGiftStockData(String empID,String accessKey, String userSecurityKey)async{
    try{
      var url=UrlConstants.getGiftStock +empID;
      print(url);
      var response = await httpClient.get(url,headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
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

  Future getViewLogsData(String accessKey, String userSecurityKey, String empID, String monthYear )async{
    try{
      var url=UrlConstants.getViewLogs +'EMP0009889' + "&monthYear="+monthYear;
      print(url);
      var response = await httpClient.get(url,headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
      print('Response body is :- ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        LogsModel logsModel;
        logsModel = LogsModel.fromJson(data);
        print("Logs model : $logsModel ${logsModel.giftStockModelList}");

        return logsModel;
      } else
        print('error');

    }catch(_){
      print('Exception at Gifts Repo : Logs ${_.toString()}');
    }


  }

  Future addGiftStockData(String empID, String userSecurityKey, String accessKey, String comment, String giftTypeId, String giftTypeText, String giftInHandQty,String giftInHandQtyNew)async{
    try{
      var url=UrlConstants.addGiftStock ;
      print(empID);
      var response = await httpClient.post(url,
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey),

          body: jsonEncode({
            "comment": comment,
            "giftAddDate": null,
            "giftInHandQty": giftInHandQty,
            "giftInHandQtyNew": giftInHandQtyNew,
            "giftTypeId": giftTypeId,
            "giftTypeText": giftTypeText,
            "referenceID": empID
          })
      );

      print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data;
      } else
        print('error');

    }catch(_){
      print('Exception at Gifts Repo : ${_.toString()}');
    }


  }



}