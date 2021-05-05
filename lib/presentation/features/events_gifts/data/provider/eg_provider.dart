import 'dart:convert';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/InfDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/UpdateDealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/UpdateDealerInfResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/deleteEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/influencerViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventResponse.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MyApiClientEvent {
String version;
  final http.Client httpClient;

  MyApiClientEvent({@required this.httpClient});

  Future getAccessKey() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version= packageInfo.version;
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



  Future<AllEventsModel> eventSearch(String accessKey, String userSecurityKey, String empID, String searchText) async {
    try {
      String url = UrlConstants.eventSearch+empID+"&searchText=$searchText";
      print(url);
      var response = await httpClient.get(url,
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));
       print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AllEventsModel eventSearchModel = AllEventsModel.fromJson(data);
        return eventSearchModel;
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
  }

  Future<AddEventModel> getEventTypeData(String accessKey, String userSecretKey,
      String empID) async {
    AddEventModel addEventModel;
    try {
      // print(accessKey);
      // print(userSecretKey);
      print('DDDD: ${UrlConstants.getAddEvent}');

      var response = await http.get(Uri.parse(UrlConstants.getAddEvent + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      addEventModel = AddEventModel.fromJson(json.decode(response.body));
      // print(response.body);
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return addEventModel;
  }

  Future<InfluencerViewModel> getInfluenceType(String accessKey, String userSecretKey, String mobileNo) async{
    InfluencerViewModel influencerViewModel;
    try {
      var response = await http.get(
          Uri.parse(UrlConstants.getInfluencer + mobileNo),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      influencerViewModel =
          InfluencerViewModel.fromJson(json.decode(response.body));
      // print(response.body);
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return influencerViewModel;
  }


  Future<AllEventsModel> getAllEventData(String accessKey, String userSecretKey, String url) async {
    AllEventsModel allEventsModel;
    try {
      var response = await http.get(
          Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      allEventsModel = AllEventsModel.fromJson(json.decode(response.body));
       print(response.body);
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return allEventsModel;
  }

  Future<ApprovedEventsModel> getApprovedEventData(String accessKey,
      String userSecretKey, String empID) async {
    ApprovedEventsModel approvedEventsModel;
    try {
      var response = await http.get(
          Uri.parse(UrlConstants.getApproveEvents + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      approvedEventsModel =
          ApprovedEventsModel.fromJson(json.decode(response.body));
      // print(response.body);
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return approvedEventsModel;
  }

  Future<DetailEventModel> getDetailEventData(String accessKey,
      String userSecretKey, String empID, int eventId) async {
    DetailEventModel detailEventModel;
    try {
      var response = await http.get(
          Uri.parse(UrlConstants.getDetailEvent + empID + "&eventId=$eventId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      detailEventModel = DetailEventModel.fromJson(json.decode(response.body));
      print('RESP : ${response.body}');
      print(
          'UURL ${UrlConstants.getDetailEvent + empID + "&eventId=$eventId"}');
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return detailEventModel;
  }


  Future<SaveEventResponse>saveEventRequest(String accessKey, String userSecretKey, SaveEventFormModel saveEventFormModel) async {
    SaveEventResponse saveEventResponse;
    try{
      var response = await http.post(Uri.parse(UrlConstants.saveEvent),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
          body: json.encode(saveEventFormModel),
      );
      print('URL : ${response.request}');
      print('RESP: ${response.body}');
      print('RESPONSE : ${json.encode(saveEventFormModel)}');

      saveEventResponse = SaveEventResponse.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return saveEventResponse;
  }


  Future<DeleteEventModel> deleteEvent(String accessKey,
      String userSecretKey, String empID, int eventId) async {
    DeleteEventModel deleteEventModel;
    try {
      var response = await http.get(
          Uri.parse(UrlConstants.deleteEvent + empID + "&eventId=$eventId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      deleteEventModel = DeleteEventModel.fromJson(json.decode(response.body));
      print('RESP : ${response.body}');
      print(
          'UURL ${UrlConstants.getDetailEvent + empID + "&eventId=$eventId"}');
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return deleteEventModel;
  }

  Future<StartEventResponse>startEvent(String accessKey, String userSecretKey, StartEventModel startEventModel) async {
    StartEventResponse startEventResponse;
    try{
      var response = await http.post(Uri.parse(UrlConstants.startEvent),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(startEventModel),
      );
      print('URL : ${response.request}');
      print('RESP: ${response.body}');
      print('RESPONSE : ${json.encode(startEventModel)}');

      startEventResponse = StartEventResponse.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return startEventResponse;
  }


  Future<DealerInfModel> getDealerInfList(String accessKey,
      String userSecretKey, String empID, int eventId) async {
    DealerInfModel dealerInfModel;
    try {
      var response = await http.get(
          Uri.parse(UrlConstants.getDealerInfList + empID + "&eventId=$eventId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      dealerInfModel = DealerInfModel.fromJson(json.decode(response.body));
      print('RESP : ${response.body}');
      print(
          'UURL ${UrlConstants.getDetailEvent + empID + "&eventId=$eventId"}');
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return dealerInfModel;
  }


  Future<UpdateDealerInfResponse>updateDealerInf(String accessKey, String userSecretKey, UpdateDealerInfModel updateDealerInfModel) async {
    UpdateDealerInfResponse updateDealerInfResponse;
    try{
      var response = await http.post(Uri.parse(UrlConstants.saveEventDealersInfluencers),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(updateDealerInfModel),
      );
      print('URL : ${response.request}');
      print('RESP: ${response.body}');
      print('RESPONSE : ${json.encode(updateDealerInfModel)}');

      updateDealerInfResponse = UpdateDealerInfResponse.fromJson(json.decode(response.body));
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return updateDealerInfResponse;
  }


 Future<InfDetailModel> getInfdata(String accessKey,
    String userSecretKey, String contact) async {
  InfDetailModel infDetailModel;
  print("print-->"+contact);
  try {
    var response = await http.get(Uri.parse(UrlConstants.getInfDetails + "$contact"),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version));

    print("print-->"+json.decode(response.body).toString());

    var respCode = json.decode(response.body);

    if(respCode["respCode"]=="DM1002"){
      print("respCode DM1002");
    }else{
      print("respCode NUM404");
    }

    infDetailModel = InfDetailModel.fromJson(json.decode(response.body));
    print('RESP : ${response.body}');
    print(
        'UURL:::: ${UrlConstants.getInfDetails + "$contact"}');
  }
  catch (e) {
    print("Exception at EG Repo $e");
  }
  
  return infDetailModel;
}

}



