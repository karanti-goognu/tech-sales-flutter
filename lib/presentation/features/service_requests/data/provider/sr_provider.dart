import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/RequestorDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SiteAreaDetailsModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApiClient {
  final http.Client httpClient;

  MyApiClient({@required this.httpClient});

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
      print('exception at SR repo ${_.toString()}');
    }
  }

  Future<SrComplaintModel> getSrComplaintData(String accessKey, String userSecretKey) async{
    SrComplaintModel complaintModel;
    try{
      // print(accessKey);
      // print(userSecretKey);


      var response = await http.get(Uri.parse(UrlConstants.getServiceRequestFormData),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      complaintModel = SrComplaintModel.fromJson(json.decode(response.body));
      // print(response.body);
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return complaintModel;
  }

  Future<RequestorDetailsModel> getRequestorDetails(String accessKey, String userSecretKey, String empID, String requesterType ) async{
    RequestorDetailsModel requestorDetailsModel;
    try{
      var response = await http.get(Uri.parse(UrlConstants.getRequestorDetails+empID+'&requesterType='+requesterType),
          headers: requestHeadersWithAccessKeyAndSecretKeywithoutContentType(accessKey,userSecretKey));
      requestorDetailsModel = RequestorDetailsModel.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return requestorDetailsModel;
  }


  Future<ServiceRequestComplaintListModel> getSrListData(String accessKey, String userSecretKey,String empID) async{
    ServiceRequestComplaintListModel serviceRequestComplaintListModel;
    try{
      //+'&offset=30'
      var response = await http.get(Uri.parse(UrlConstants.getComplaintListData+empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      serviceRequestComplaintListModel = ServiceRequestComplaintListModel.fromJson(json.decode(response.body));
      // print(response.body);
    }
    catch(e){
      print("Exception at SR Repo - SR List View $e");
    }
    return serviceRequestComplaintListModel;
  }

  Future<ServiceRequestComplaintListModel> getSrListDataWithFilters(String accessKey, String userSecretKey,String empID,String resolutionStatusId,String severity, String typeOfReqId) async{
    ServiceRequestComplaintListModel serviceRequestComplaintListModel;
    try{
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
      // print(url);
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      serviceRequestComplaintListModel = ServiceRequestComplaintListModel.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return serviceRequestComplaintListModel;
  }

  Future<ServiceRequestComplaintListModel> getSiteListData(String accessKey, String userSecretKey,String empID, String siteID) async{
    ServiceRequestComplaintListModel serviceRequestComplaintListModel;
    try{
      var url=UrlConstants.getComplaintListData+empID+'&siteId='+siteID;
      // print(url);
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
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
      http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.addServiceRequest));
      request.headers.addAll(
          requestHeadersWithAccessKeyAndSecretKeywithoutContentType(accessKey, userSecretKey));
      request.fields['uploadImageWithSRCompalintModal'] = json.encode(saveServiceRequest) ;
      print("Request Body/Fields :: " + request.fields.toString());
      for (var file in imageList) {
        String fileName = file.path.split("/").last;
        var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
        // get file length

        var length = await file.length(); //imageFile is your image file
        // multipart that takes file
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
      http.MultipartRequest request = new http.MultipartRequest('POST', Uri.parse(UrlConstants.updateServiceRequest));
      request.headers.addAll(requestHeadersWithAccessKeyAndSecretKeywithoutContentType(accessKey, userSecretKey));
      request.fields['uploadImageWithSRCompalintUpdateModal'] = json.encode(updateServiceRequest) ;
      // print("Request Body/Fields :: " + request.fields.toString());
      // print("Headers"+ request.headers.toString());
      for (var file in imageList) {
        String fileName = file.path.split("/").last;
        var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
        // get file length
        var length = await file.length(); //imageFile is your image file
        // multipart that takes file

        var multipartFileSign =
        new http.MultipartFile('file', stream, length, filename: fileName);
        request.files.add(multipartFileSign);
      }

      await request.send().then((value) async {
        response = await http.Response.fromStream(value);
        // print(response.body);
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
      var url=UrlConstants.srComplaintView+empID+'&id='+id;
      // print(userSecretKey);
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      var data = json.decode(response.body);
      // print(data);
      complaintViewModel =  ComplaintViewModel.fromJson(data);
    }
    catch(e){
      print("Exception at SR Repo $e");
    }
    return complaintViewModel;

  }



    getFilterData(String accessKey) async {
    try {
      String userSecurityKey = "empty";
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      });
      if (userSecurityKey == "empty") {
        var response = await httpClient.get(UrlConstants.getFilterData,
            headers: requestHeadersWithAccessKeyAndSecretKey(
                accessKey, userSecurityKey));
        // print('Response body is : ${json.decode(response.body)}');
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
          //print('Access key Object is :: $accessKeyModel');
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
    try {
      var url=UrlConstants.getSiteAreaDetails+empID+'&siteId='+siteID;
      // print(url);
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      print(response.body);
      siteAreaDetailsModel = SiteAreaModel.fromJson(json.decode(response.body));
      return siteAreaDetailsModel;
    } catch (_) {
      print('exception at SR repo ${_.toString()}');
    }

  }
}

