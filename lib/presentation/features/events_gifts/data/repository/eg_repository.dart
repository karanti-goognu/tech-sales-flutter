import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
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

}