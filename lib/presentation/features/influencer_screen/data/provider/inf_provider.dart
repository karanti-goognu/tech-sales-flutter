import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyApiClientInf {
  String? version;
  final http.Client httpClient;

  MyApiClientInf({required this.httpClient});

  Future getAccessKey() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // version= packageInfo.version;
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version) as Map<String, String>?);
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

  Future<InfluencerTypeModel?> getInfTypeData(String? accessKey, String? userSecretKey,
      String empID) async {
    InfluencerTypeModel? influencerTypeModel;
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(UrlConstants.addIlpInfluencer + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version) as Map<String, String>?);
      var data = json.decode(response.body);
     // print("URL-------${UrlConstants.addIlpInfluencer + empID}");
     // print("-------$data");
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        influencerTypeModel = InfluencerTypeModel.fromJson(json.decode(response.body));
      //  print(response.body);
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return influencerTypeModel;
  }

  Future<StateDistrictListModel?> getDistList(String? accessKey, String? userSecretKey,
      String empID) async {
    StateDistrictListModel? stateDistrictListModel;
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(UrlConstants.stateDistrictList + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version) as Map<String, String>?);
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        stateDistrictListModel = StateDistrictListModel.fromJson(json.decode(response.body));
       // print(response.body);
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return stateDistrictListModel;
  }


  Future<InfluencerDetailModel?> getInfdata(String? accessKey,
      String? userSecretKey, String contact) async {
    InfluencerDetailModel? infDetailModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getInfluencerDetail + "$contact"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version) as Map<String, String>?);
     // print("======${UrlConstants.getInfluencerDetail + "$contact"}");
      var data = json.decode(response.body);
      //print("======$data");
      if (response.statusCode == 200) {
        Get.back();
       // print("======$data");

        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          infDetailModel = InfluencerDetailModel.fromJson(json.decode(response.body));
         //  print('URL ${UrlConstants.getInfluencerDetail + "$contact"}');
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }

    return infDetailModel;
  }


  Future<InfluencerResponseModel?>saveInfluencerRequest(String? accessKey, String? userSecretKey, InfluencerRequestModel influencerRequestModel, bool status) async {
    InfluencerResponseModel? influencerResponseModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.saveIlpInfluencer + "$status"),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) as Map<String, String>?,
        body: json.encode(influencerRequestModel),
      );
     // print("__---${response.request}");
      var data = json.decode(response.body);
     // print("__---$data");
      if (response.statusCode == 200) {
        Get.back();
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          influencerResponseModel =
              InfluencerResponseModel.fromJson(json.decode(response.body));
          // print('URL : ${response.request}');
          // print('RESP: ${response.body}');
          // print('RESPONSE : ${json.encode(influencerRequestModel)}');
        } } else {
        print('error');
      }
    } catch(e){
      print("Exception at INF Repo $e");
    }
    return influencerResponseModel;
  }


  Future<InfluencerListModel?> getInfluencerList(String? accessKey, String? userSecretKey,
      String url) async {
    InfluencerListModel? influencerListModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version) as Map<String, String>?);
      var data = json.decode(response.body);
      Get.back();
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        influencerListModel = InfluencerListModel.fromJson(json.decode(response.body));
        // print('URL : ${response.request}');
        // print('RESP: ${response.body}');
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return influencerListModel;
  }



  Future<InfluencerDetailDataModel?> getInfDetaildata(String? accessKey,
      String? userSecretKey, String membershipId) async {
    InfluencerDetailDataModel? influencerDetailDataModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getInfluencerDetailsByMembership + "$membershipId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version) as Map<String, String>?);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
       // print("======$data");
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          influencerDetailDataModel = InfluencerDetailDataModel.fromJson(json.decode(response.body));
        //  print('URL ${UrlConstants.getInfluencerDetailsByMembership + "$membershipId"}');
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }

    return influencerDetailDataModel;
  }

  Future<InfluencerListModel> infSearch(String? accessKey, String? userSecurityKey, String? empID, String searchText) async {
    try {
      version = VersionClass.getVersion();
      //String url = UrlConstants.searchInfluencerList+empID+"&searchText=$searchText";
      String url = UrlConstants.searchInfluencerList+searchText+'&referenceID=$empID';
     // print(url);
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version) as Map<String, String>?);
   //   print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        InfluencerListModel infSearchModel = InfluencerListModel.fromJson(data);
        return infSearchModel;
      } else
        print('error');
    } catch (_) {
      print('exception at INF repo ${_.toString()}');
    }
  }

  Future<InfluencerResponseModel?>saveNewInfluencer(String? accessKey, String? userSecretKey, InfluencerRequestModel influencerRequestModel, bool status) async {
    InfluencerResponseModel? influencerResponseModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.saveIlpInfluencer + "$status"),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) as Map<String, String>?,
        body: json.encode(influencerRequestModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
      //  print("======$data");
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          influencerResponseModel = InfluencerResponseModel.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return influencerResponseModel;
  }
}