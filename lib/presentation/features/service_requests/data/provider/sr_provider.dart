import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/RequestorDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SiteAreaDetailsModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApiClientSR {
  final http.Client httpClient;
  String version;
  MyApiClientSR({@required this.httpClient});

  Future<AccessKeyModel> getAccessKey() async {
    AccessKeyModel accessKeyModel;
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
      print('exception at SR repo ${_.toString()}');
    }
    return accessKeyModel;
  }

  Future<SrComplaintModel> getSrComplaintData(String accessKey, String userSecretKey,String empId) async{
    SrComplaintModel complaintModel;
    try{
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getServiceRequestFormDataNew+'?referenceID='+empId),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey, version));
     var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        complaintModel = SrComplaintModel.fromJson(json.decode(response.body));
      }
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return complaintModel;
  }

  Future<RequestorDetailsModel> getRequestorDetails(String accessKey, String userSecretKey, String empID, String requesterType,String siteId ) async{
    RequestorDetailsModel requestorDetailsModel;
    try{
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getRequestorDetails+empID+'&requesterType='+requesterType+'&siteId='+siteId),
          headers: headersWithAccessAndSecretWithoutContent(accessKey,userSecretKey, version));
      requestorDetailsModel = RequestorDetailsModel.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return requestorDetailsModel;
  }


  Future<ServiceRequestComplaintListModel> getSrListData(String accessKey, String userSecretKey,String empID, int offset) async{
    ServiceRequestComplaintListModel serviceRequestComplaintListModel;
    try{
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getComplaintListData+empID+'&offset=$offset&limit=10'),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey, version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        serviceRequestComplaintListModel = ServiceRequestComplaintListModel.fromJson(json.decode(response.body));
      }
    }
    catch(e){
      print("Exception at SR Repo - SR List View $e");
    }
    return serviceRequestComplaintListModel;
  }

  Future<ServiceRequestComplaintListModel> getSrListDataWithFilters(String accessKey, String userSecretKey,String empID,String resolutionStatusId,String severity, String typeOfReqId) async{
    ServiceRequestComplaintListModel serviceRequestComplaintListModel;
    try{
      version = VersionClass.getVersion();
      String url =UrlConstants.getComplaintListData+empID;
      if (resolutionStatusId.isNotEmpty){
        url=url+'&resolutionStatusId=$resolutionStatusId';
      }
      if (severity.isNotEmpty){
        url=url+'&severity=$severity';
      }

      if (typeOfReqId.isNotEmpty){
        url=url+'&typeOfReqId=$typeOfReqId';
      }
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey, version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        serviceRequestComplaintListModel =
            ServiceRequestComplaintListModel.fromJson(
                json.decode(response.body));
      }
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return serviceRequestComplaintListModel;
  }

  Future<ServiceRequestComplaintListModel> getSiteListData(String accessKey, String userSecretKey,String empID, String siteID) async{
    ServiceRequestComplaintListModel serviceRequestComplaintListModel;
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.getComplaintListData+empID+'&siteId='+siteID;
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey, version));
      serviceRequestComplaintListModel = ServiceRequestComplaintListModel.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return serviceRequestComplaintListModel;
  }

  Future<Map> saveServiceRequest(List<File> imageList,String accessKey, String userSecretKey, SaveServiceRequest saveServiceRequest) async{
    http.Response response;
    try{
      version = VersionClass.getVersion();
      http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.addServiceRequest));
      request.headers.addAll(
          headersWithAccessAndSecretWithoutContent(accessKey, userSecretKey, version));
      request.fields['uploadImageWithSRCompalintModal'] = json.encode(saveServiceRequest) ;
      for (var file in imageList) {
        String fileName = file.path.split("/").last;
        var stream = new http.ByteStream(file.openRead());
        stream.cast();
        var length = await file.length();
        var multipartFileSign = new http.MultipartFile('file', stream, length, filename: fileName);
        request.files.add(multipartFileSign);
      }
      await request.send().then((value) async {
        response = await http.Response.fromStream(value);
        return json.decode(response.body);
      });
    }
    catch(e){
      print("Exception at SR Repo $e");
      return null;
    }
  return json.decode(response.body);
  }

  Future<Map> updateServiceRequest(List<File> imageList,String accessKey, String userSecretKey, UpdateSRModel updateServiceRequest) async{
    http.Response response;
    try{
      version = VersionClass.getVersion();
      http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.updateServiceRequest));
      request.headers.addAll(headersWithAccessAndSecretWithoutContent(accessKey, userSecretKey, version));
      request.fields['uploadImageWithSRCompalintUpdateModal'] = json.encode(updateServiceRequest) ;
      for (var file in imageList) {
        String fileName = file.path.split("/").last;
        var stream = new http.ByteStream(file.openRead());
        stream.cast();
        var length = await file.length();
        var multipartFileSign =
        new http.MultipartFile('file', stream, length, filename: fileName);
        request.files.add(multipartFileSign);
      }

      await request.send().then((value) async {
        response = await http.Response.fromStream(value);
        return json.decode(response.body);
      });
    }
    catch(e){
      print("Exception at SR Repo $e");
      return null;
    }
    return json.decode(response.body);
  }


  Future<ComplaintViewModel> getComplaintViewData(String accessKey, String userSecretKey,String empID, String id) async{
    ComplaintViewModel complaintViewModel;
    try{
      version = VersionClass.getVersion();
      var url=UrlConstants.srComplaintView+empID+'&id='+id;
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey, version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      complaintViewModel =  ComplaintViewModel.fromJson(data);
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return complaintViewModel;

  }



    getFilterData(String accessKey) async {
    try {
      version = VersionClass.getVersion();
      String userSecurityKey = "empty";
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      });
      if (userSecurityKey == "empty") {
        var response = await httpClient.get(Uri.parse(UrlConstants.getFilterData),
            headers: requestHeadersWithAccessKeyAndSecretKey(
                accessKey, userSecurityKey, version));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
          return accessKeyModel;
        } else
          print('error');
      } else {
        print('user security key is empty');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getSiteAreaDetails(String accessKey,  String userSecretKey,String empID, String siteID) async{
    SiteAreaModel siteAreaDetailsModel;
    version = VersionClass.getVersion();
    try {
      var url=UrlConstants.getSiteAreaDetails+empID+'&siteId='+siteID;
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey, version));
      siteAreaDetailsModel = SiteAreaModel.fromJson(json.decode(response.body));
      return siteAreaDetailsModel;
    } catch (_) {
      print('exception at SR repo ${_.toString()}');
    }

  }
}

