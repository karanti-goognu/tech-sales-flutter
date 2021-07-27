import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/provider/inf_provider.dart';

class InfRepository {
  final MyApiClientEvent apiClient;

  InfRepository({this.apiClient});

  Future getAccessKey() {
    return apiClient.getAccessKey();
  }


  Future<InfluencerTypeModel> getInfTypeData(String accessKey, String userSecretKey,
      String empID) async {
    return apiClient.getInfTypeData(accessKey, userSecretKey, empID);
  }

  Future<StateDistrictListModel> getDistList(String accessKey, String userSecretKey,
      String empID) async {
    return apiClient.getDistList(accessKey, userSecretKey, empID);
  }

  Future<InfluencerDetailModel> getInfData(
      String accessKey, String userSecretKey, String contact) async {
    return apiClient.getInfdata(accessKey, userSecretKey, contact);

  }
}