import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/influencerViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/provider/eg_provider.dart';

class EgRepository{
  final MyApiClientEvent apiClient;
  EgRepository({this.apiClient});

  Future<AccessKeyModel> getAccessKey(){
    return apiClient.getAccessKey();
  }

  Future<AddEventModel> getEventTypeData(String accessKey, String userSecretKey, String empID) async{
    return apiClient.getEventTypeData(accessKey, userSecretKey, empID);
  }

  Future<InfluencerViewModel> getInfluenceType(String accessKey, String userSecretKey,String mobileNumber) async{
    return apiClient.getInfluenceType(accessKey, userSecretKey, mobileNumber);
  }

  Future<AllEventsModel> getAllEvents(String accessKey, String userSecretKey,String empID) async{
    return apiClient.getAllEventData(accessKey, userSecretKey, empID);
  }

  Future<ApprovedEventsModel> getApprovedEvents(String accessKey, String userSecretKey,String empID) async{
    return apiClient.getApprovedEventData(accessKey, userSecretKey, empID);
  }

  Future<DetailEventModel> getdetailEvents(String accessKey, String userSecretKey,String empID, int eventID) async{
    return apiClient.getDetailEventData(accessKey, userSecretKey, empID, eventID);
  }

}