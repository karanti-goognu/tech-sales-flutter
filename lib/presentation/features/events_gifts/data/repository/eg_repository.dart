

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
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/provider/eg_provider.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';

class EgRepository {
  final MyApiClientEvent? apiClient;

  EgRepository({this.apiClient});

  Future getAccessKey() {
    return apiClient!.getAccessKey();
  }

  Future<AllEventsModel?> eventSearch(String? accessKey, String? userSecurityKey,
      String empID, String searchText) {
    return apiClient!.eventSearch(accessKey, userSecurityKey, empID, searchText);
  }

  Future<AddEventModel?> getEventTypeData(
      String? accessKey, String? userSecretKey, String empID) async {
    return apiClient!.getEventTypeData(accessKey, userSecretKey, empID);
  }

  Future<InfluencerViewModel?> getInfluenceType(
      String accessKey, String userSecretKey, String mobileNumber) async {
    return apiClient!.getInfluenceType(accessKey, userSecretKey, mobileNumber);
  }

  Future<AllEventsModel?> getAllEvents(
      String? accessKey, String? userSecretKey, String url) async {
    return apiClient!.getAllEventData(accessKey, userSecretKey, url);
  }

  Future<ApprovedEventsModel?> getApprovedEvents(
      String? accessKey, String? userSecretKey, String empID) async {
    return apiClient!.getApprovedEventData(accessKey, userSecretKey, empID);
  }

  Future<DetailEventModel?> getdetailEvents(
      String? accessKey, String? userSecretKey, String empID, int? eventID) async {
    return apiClient!.getDetailEventData(
        accessKey, userSecretKey, empID, eventID);
  }

  Future<SaveEventResponse?> saveEventForm(String? accessKey,
      String? userSecretKey, SaveEventFormModel saveEventFormModel) async {
    return apiClient!.saveEventRequest(
        accessKey, userSecretKey, saveEventFormModel);
  }

  Future<DeleteEventModel?> deleteEvent(
      String? accessKey, String? userSecretKey, String empID, int? eventID) async {
    return apiClient!.deleteEvent(accessKey, userSecretKey, empID, eventID);
  }

  Future<StartEventResponse?> startEvent(String? accessKey, String? userSecretKey,
      StartEventModel startEventModel) async {
    return apiClient!.startEvent(accessKey, userSecretKey, startEventModel);
  }

  Future<DealerInfModel?> getDealerInfList(
      String? accessKey, String? userSecretKey, String empID, int? eventID) async {
    return apiClient!.getDealerInfList(accessKey, userSecretKey, empID, eventID);
  }

  Future<EndEventModel?> getEndEventDetail(String? accessKey,
      String? userSecretKey, String empId, String eventId) async {
    return apiClient!.getEndEventDetail(
        accessKey, userSecretKey, empId, eventId);
  }

  Future<EventResponse?> submitEndEventDetail(String? accessKey,
      String? userSecretKey, String? empId, int eventId,
      String eventComment,String eventDate,double eventEndLat,double eventEndLong) async {
    return apiClient!.submitEndEventDetail(
        accessKey, userSecretKey, empId, eventId,eventComment,eventDate,eventEndLat,eventEndLong);
  }


  Future<UpdateDealerInfResponse?> updateDealerInf(String? accessKey,
      String? userSecretKey, UpdateDealerInfModel updateDealerInfModel) async {
    return apiClient!.updateDealerInf(
        accessKey, userSecretKey, updateDealerInfModel);
  }


  Future<SaveNewInfluencerResponse?> saveNewInfluencer(String? accessKey, String? userSecretKey, SaveNewInfluencerModel saveNewInfluencerModel) async {
    return apiClient!.saveNewInfluencer(
        accessKey, userSecretKey, saveNewInfluencerModel);
  }

  Future<InfluencerDetailModel?> getInfData(
      String? accessKey, String? userSecretKey, String contact) async {
    return apiClient!.getInfdata(accessKey, userSecretKey, contact);

  }


  ///////////
  // Future<InfDetailModel> getInfData1(
  //     String accessKey, String userSecretKey, String contact) async {
  //   return apiClient.getInfdata1(accessKey, userSecretKey, contact);
  //
  // }
}
