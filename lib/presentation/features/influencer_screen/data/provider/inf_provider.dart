import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/UpdateInfluencerRequest.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteVisitRequestModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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


class MyApiClientInf {
  String? version;
  final http.Client httpClient;

  MyApiClientInf({required this.httpClient});

  Future getAccessKey() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version) );
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
              accessKey, userSecretKey,version) );
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs.appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        influencerTypeModel = InfluencerTypeModel.fromJson(json.decode(response.body));
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
              accessKey, userSecretKey,version) );
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs.appUserInactiveDialog(
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
      print(UrlConstants.getInfluencerDetail + "$contact");
      var response = await http.get(Uri.parse(UrlConstants.getInfluencerDetail + "$contact"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version) );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          infDetailModel = InfluencerDetailModel.fromJson(json.decode(response.body));
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
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) ,
        body: json.encode(influencerRequestModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          influencerResponseModel = InfluencerResponseModel.fromJson(json.decode(response.body));
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
              accessKey, userSecretKey,version) );
      var data = json.decode(response.body);
      Get.back();
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs.appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        influencerListModel = InfluencerListModel.fromJson(json.decode(response.body));

      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return influencerListModel;
  }



  Future<InfluencerDetailDataModel> getInfDetaildata(String? accessKey,
      String? userSecretKey, String membershipId) async {
    late InfluencerDetailDataModel influencerDetailDataModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      print(UrlConstants.getInfluencerDetailsByMembership + "$membershipId");
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getInfluencerDetailsByMembership + "$membershipId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          influencerDetailDataModel = InfluencerDetailDataModel.fromJson(data);
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }

    return influencerDetailDataModel;
  }

  Future<InfluencerListModel?> infSearch(String? accessKey, String? userSecurityKey, String? empID, String searchText) async {
    InfluencerListModel? infSearchModel;
    try {
      version = VersionClass.getVersion();
      String url = UrlConstants.searchInfluencerList+searchText+'&referenceID=$empID';
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
         infSearchModel = InfluencerListModel.fromJson(data);
      } else
        print('error');
    } catch (_) {
      print('exception at INF repo ${_.toString()}');
    }
    return infSearchModel;
  }

  Future<InfluencerResponseModel?>saveNewInfluencer(String? accessKey, String? userSecretKey, InfluencerRequestModel influencerRequestModel, bool status) async {
    InfluencerResponseModel? influencerResponseModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.saveIlpInfluencer + "$status"),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(influencerRequestModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
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



  Future<SiteVisitResponseModel> influencerVisitSave(String? accessKey, String? userSecretKey, UpdateInfluencerRequest updateInflRequest) async {
    late SiteVisitResponseModel siteVisitResponseModel;
    try{
      version = VersionClass.getVersion();
      print(UrlConstants.saveUpdateInfluencerVisit);
      print(json.encode(updateInflRequest));
      var response = await http.post(
        Uri.parse(UrlConstants.saveUpdateInfluencerVisit),
        headers: requestHeadersWithAccessKeyAndSecretKey(
            accessKey, userSecretKey, version),
        body: json.encode(updateInflRequest),
      );
      var data = json.decode(response.body);
      print(response.body);
      siteVisitResponseModel= SiteVisitResponseModel.fromJson(data);
      if (response.statusCode == 200) {
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        Get.dialog(CustomDialogs.showMessage(siteVisitResponseModel.respMsg!));
      } else {
        print('error');
      }
    } catch (e) {
      print("Exception at site Repo $e");
    }
    return siteVisitResponseModel;
  }


}