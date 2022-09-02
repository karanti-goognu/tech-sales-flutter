import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/LogsModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/saveVisitResponse.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';

class MyApiClientEvent {

  final http.Client httpClient;
String? version;
  MyApiClientEvent({required this.httpClient});

  Future<String?> getAccessKey() async {
    late AccessKeyModel accessKeyModel;
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        accessKeyModel = AccessKeyModel.fromJson(data);
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
    return accessKeyModel.accessKey;
  }

  Future getGiftStockData(String empID,String? accessKey, String? userSecurityKey)async{
    try{
      var url=UrlConstants.getGiftStock +empID;
      version = VersionClass.getVersion();
      Future.delayed(Duration.zero, (){Get.dialog(Center(child: CircularProgressIndicator()),barrierDismissible: false);});
      var response = await httpClient.get(Uri.parse(url),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));
      Get.back();
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          GetGiftStockModel getGiftStockModel;
          getGiftStockModel = GetGiftStockModel.fromJson(data);
          return getGiftStockModel;
        }
      } else
        print('error');

    }catch(_){
      print('Exception at Dashboard Repo : Yearly View ${_.toString()}');
    }


  }

  Future getViewLogsData(String? accessKey, String? userSecurityKey, String empID, String monthYear )async{
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.getViewLogs +empID+ "&monthYear="+monthYear;
      var response = await httpClient.get(Uri.parse(url),headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          LogsModel logsModel;
          logsModel = LogsModel.fromJson(data);
          return logsModel;
        }
      } else
        print('error');

    }catch(_){
      print('Exception at Gifts Repo : Logs ${_.toString()}');
    }


  }

  Future addGiftStockData(String? empID, String? userSecurityKey, String? accessKey, String? comment, String? giftTypeId, String? giftTypeText, String? giftInHandQty,String? giftInHandQtyNew)async{
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.addGiftStock ;
      var response = await httpClient.post(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version) ,
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
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else {
          SaveVisitResponse addGiftResponse;
          addGiftResponse = SaveVisitResponse.fromJson(data);
          return addGiftResponse;
        }
      } else
        print('error');

    }catch(_){
      print('Exception at Gifts Repo : ${_.toString()}');
    }


  }



}