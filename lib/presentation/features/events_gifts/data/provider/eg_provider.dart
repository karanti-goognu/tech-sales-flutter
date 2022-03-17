

import 'dart:convert';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EndEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/SaveNewInfluencerModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/SaveNewInfluencerResponse.dart';
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
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyApiClientEvent {
  String? version;
  final http.Client httpClient;

  MyApiClientEvent({required this.httpClient});

  Future getAccessKey() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
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



  Future<AllEventsModel?> eventSearch(String? accessKey, String? userSecurityKey, String empID, String searchText) async {
    AllEventsModel? eventSearchModel;
    try {
      version = VersionClass.getVersion();
      String url = UrlConstants.eventSearch+empID+"&searchText=$searchText";
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        eventSearchModel = AllEventsModel.fromJson(data);
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
    return eventSearchModel;
  }

  Future<AddEventModel?> getEventTypeData(String? accessKey, String? userSecretKey,
      String empID) async {
    AddEventModel? addEventModel;
    try {
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getAddEvent + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        addEventModel = AddEventModel.fromJson(json.decode(response.body));

       // print(response.body);
      }
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return addEventModel;
  }

  Future<InfluencerViewModel?> getInfluenceType(String accessKey, String userSecretKey, String mobileNo) async{
    InfluencerViewModel? influencerViewModel;
    try {
      version = VersionClass.getVersion();
      var response = await http.get(
          Uri.parse(UrlConstants.getInfluencer + mobileNo),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      influencerViewModel =
          InfluencerViewModel.fromJson(json.decode(response.body));
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return influencerViewModel;
  }


  Future<AllEventsModel?> getAllEventData(String? accessKey, String? userSecretKey, String url) async {
    AllEventsModel? allEventsModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(
          Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.back();
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        allEventsModel = AllEventsModel.fromJson(json.decode(response.body));
      }
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    Get.back();
    return allEventsModel;
  }

  Future<ApprovedEventsModel?> getApprovedEventData(String? accessKey,
      String? userSecretKey, String empID) async {
    ApprovedEventsModel? approvedEventsModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(
          Uri.parse(UrlConstants.getApproveEvents + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.back();
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      else
        approvedEventsModel = ApprovedEventsModel.fromJson(json.decode(response.body));
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    Get.back();
    return approvedEventsModel;
  }

  Future<DetailEventModel?>getDetailEventData(String? accessKey,
      String? userSecretKey, String empID, int? eventId) async {
    DetailEventModel? detailEventModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(
          Uri.parse(UrlConstants.getDetailEvent + empID + "&eventId=$eventId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey, version));
      if (response.statusCode == 200) {
        Get.back();
        var data = json.decode(response.body);
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          detailEventModel = DetailEventModel.fromJson(json.decode(response.body));
        }
      } else {
        print('error');
      }} catch (e) {
      print("Exception at EG Repo $e");
    }
    return detailEventModel;
  }


  Future<SaveEventResponse?>saveEventRequest(String? accessKey, String? userSecretKey, SaveEventFormModel saveEventFormModel) async {
    SaveEventResponse? saveEventResponse;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.saveEvent),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(saveEventFormModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      else {
        saveEventResponse = SaveEventResponse.fromJson(json.decode(response.body));
      } } else {
        print('error');
      }
    } catch(e){
      print("Exception at EG Repo $e");
    }
    return saveEventResponse;
  }


  Future<DeleteEventModel?> deleteEvent(String? accessKey,
      String? userSecretKey, String empID, int? eventId) async {
    DeleteEventModel? deleteEventModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(
          Uri.parse(UrlConstants.deleteEvent + empID + "&eventId=$eventId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
      if (data["resp_code"] == "DM1005") {
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      else {
        deleteEventModel =
            DeleteEventModel.fromJson(json.decode(response.body));
      }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return deleteEventModel;
  }



  Future<StartEventResponse?>startEvent(String? accessKey, String? userSecretKey, StartEventModel startEventModel) async {
    StartEventResponse? startEventResponse;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.startEvent),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(startEventModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          startEventResponse =
              StartEventResponse.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return startEventResponse;
  }

  Future<EndEventModel?> getEndEventDetail(String? accessKey,String? userSecretKey, String empId, String eventId) async{
    EndEventModel? endEventModel;
    try{
      version = VersionClass.getVersion();
      var url = UrlConstants.endEvent +empId + "&eventId=$eventId";
      var response = await http.get(Uri.parse(url), headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) );
      var data = json.decode(response.body);
      if (data["resp_code"] == "DM1005") {
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      else {
        endEventModel = EndEventModel.fromJson(json.decode(response.body));
      }
    }catch(e){
      print("Exception at EG Repo $e");
    }
    return endEventModel;
  }

  Future<EventResponse?> submitEndEventDetail(String? accessKey,String? userSecretKey, String? empId, int eventId,
      String eventComment,String eventDate,double eventEndLat,double eventEndLong) async{
    EventResponse? endEventModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    version = VersionClass.getVersion();
    EndEventDetailModel endEventDetailModel = new EndEventDetailModel(eventComment, eventDate, eventEndLat, eventEndLong, eventId, empId);
    try{
      var body = {
          "eventComment": "$eventComment",
          "eventDate": eventDate,
          "eventEndLat": eventEndLat,
          "eventEndLong": eventEndLong,
          "eventId": eventId,
          "referenceId": empId
      };
      var response = await http.post(Uri.parse(UrlConstants.submitEndEvent),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(endEventDetailModel)
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
      endEventModel = EventResponse.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }catch(e){
      print("Exception at EG Repo $e");
    }
    return endEventModel;
  }



  Future<DealerInfModel?> getDealerInfList(String? accessKey,
      String? userSecretKey, String empID, int? eventId) async {
    DealerInfModel? dealerInfModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(
          Uri.parse(UrlConstants.getDealerInfList + empID + "&eventId=$eventId"),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else
      dealerInfModel = DealerInfModel.fromJson(json.decode(response.body));
        } else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }
    return dealerInfModel;
  }


  Future<UpdateDealerInfResponse?>updateDealerInf(String? accessKey, String? userSecretKey, UpdateDealerInfModel updateDealerInfModel) async {
    UpdateDealerInfResponse? updateDealerInfResponse;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.saveEventDealersInfluencers),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) ,
        body: json.encode(updateDealerInfModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {

      updateDealerInfResponse = UpdateDealerInfResponse.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch(e){
      print("Exception at EG Repo $e");
    }
    return updateDealerInfResponse;
  }

 Future<InfluencerDetailModel?> getInfdata(String? accessKey,
    String? userSecretKey, String contact) async {
   InfluencerDetailModel? infDetailModel;
  Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
  try {
    version = VersionClass.getVersion();
    var response = await http.get(Uri.parse(UrlConstants.getInfluencerDetail + "$contact"),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version));
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      Get.back();
      if (data["resp_code"] == "DM1005") {
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      else {
        infDetailModel = InfluencerDetailModel.fromJson(json.decode(response.body));
      }} else {
      print('error');
    }
  }
  catch (e) {
    print("Exception at EG Repo $e");
  }
  
  return infDetailModel;
}


Future<SaveNewInfluencerResponse?>saveNewInfluencer(String? accessKey, String? userSecretKey, SaveNewInfluencerModel saveNewInfluencerModel) async {
  SaveNewInfluencerResponse? saveNewInfluencerResponse;
  Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
  try{
    version = VersionClass.getVersion();
    var response = await http.post(Uri.parse(UrlConstants.saveInfluencer),
      headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
      body: json.encode(saveNewInfluencerModel),
    );
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      Get.back();
      if (data["resp_code"] == "DM1005") {
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }
      else {
    saveNewInfluencerResponse = SaveNewInfluencerResponse.fromJson(json.decode(response.body));
      }} else {
      print('error');
    }
  }
  catch(e){
    print("Exception at EG Repo $e");
  }
  return saveNewInfluencerResponse;
}







/////////////
//   Future<InfDetailModel> getInfdata1(String accessKey,
//       String userSecretKey, String contact) async {
//     InfDetailModel infDetailModel;
//     Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
//     try {
//       version = VersionClass.getVersion();
//       var response = await http.get(Uri.parse(UrlConstants.getInfDetails + "$contact"),
//           headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version));
//       var data = json.decode(response.body);
//       if (response.statusCode == 200) {
//         Get.back();
//         print("======$data");
//         if (data["resp_code"] == "DM1005") {
//           Get.dialog(CustomDialogs().appUserInactiveDialog(
//               data["resp_msg"]), barrierDismissible: false);
//         }
//         else {
//           infDetailModel = InfDetailModel.fromJson(json.decode(response.body));
//           // print('URL ${UrlConstants.getInfDetails + "$contact"}');
//         }} else {
//         print('error');
//       }
//     }
//     catch (e) {
//       print("Exception at EG Repo $e");
//     }
//
//     return infDetailModel;
//   }

}

