
import 'dart:convert';

import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventResponse.dart';
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

class MyApiClientEvent {

  final http.Client httpClient;

  MyApiClientEvent({@required this.httpClient});

  Future getAccessKey() async {
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



  Future<AllEventsModel> eventSearch(String accessKey, String userSecurityKey, String empID, String searchText) async {
    try {
      String url = UrlConstants.eventSearch+empID+"&searchText=$searchText";
      print(url);
      var response = await httpClient.get(url,
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey));
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
              accessKey, userSecretKey));
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
              accessKey, userSecretKey));
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
              accessKey, userSecretKey));
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
              accessKey, userSecretKey));
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
              accessKey, userSecretKey));
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
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey),
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
              accessKey, userSecretKey));
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
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey),
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
              accessKey, userSecretKey));
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
}



