import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApiClientEvent {
  String version;
  final http.Client httpClient;

  MyApiClientEvent({@required this.httpClient});

  Future getAccessKey() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // version= packageInfo.version;
      version = VersionClass.getVersion();
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders(version));
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

  Future<InfluencerTypeModel> getInfTypeData(String accessKey, String userSecretKey,
      String empID) async {
    InfluencerTypeModel influencerTypeModel;
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(UrlConstants.addIlpInfluencer + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        influencerTypeModel = InfluencerTypeModel.fromJson(json.decode(response.body));
        print(response.body);
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return influencerTypeModel;
  }

  Future<StateDistrictListModel> getDistList(String accessKey, String userSecretKey,
      String empID) async {
    StateDistrictListModel stateDistrictListModel;
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(UrlConstants.stateDistrictList + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        stateDistrictListModel = StateDistrictListModel.fromJson(json.decode(response.body));
        print(response.body);
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return stateDistrictListModel;
  }


  Future<InfluencerDetailModel> getInfdata(String accessKey,
      String userSecretKey, String contact) async {
    InfluencerDetailModel infDetailModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getInfDetails + "$contact"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        print("======$data");
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          infDetailModel = InfluencerDetailModel.fromJson(json.decode(response.body));
          // print('URL ${UrlConstants.getInfDetails + "$contact"}');
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }

    return infDetailModel;
  }
}