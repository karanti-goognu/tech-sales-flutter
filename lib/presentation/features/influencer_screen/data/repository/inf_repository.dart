import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/provider/inf_provider.dart';

class InfRepository {
  final MyApiClientEvent apiClient;

  InfRepository({this.apiClient});

  Future getAccessKey() {
    return apiClient.getAccessKey();
  }


  Future<InfluencerTypeModel> getInfData(String accessKey, String userSecretKey,
      String empID) async {
    return apiClient.getInfData(accessKey, userSecretKey, empID);
  }

  Future<StateDistrictListModel> getDistList(String accessKey, String userSecretKey,
      String empID) async {
    return apiClient.getDistList(accessKey, userSecretKey, empID);
  }
}