import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/provider/inf_provider.dart';

class InfRepository {
  final MyApiClientInf? apiClient;

  InfRepository({this.apiClient});

  Future getAccessKey() {
    return apiClient!.getAccessKey();
  }


  Future<InfluencerTypeModel?> getInfTypeData(String? accessKey, String? userSecretKey,
      String empID) async {
    return apiClient!.getInfTypeData(accessKey, userSecretKey, empID);
  }

  Future<StateDistrictListModel?> getDistList(String? accessKey, String? userSecretKey,
      String empID) async {
    return apiClient!.getDistList(accessKey, userSecretKey, empID);
  }

  Future<InfluencerDetailModel?> getInfData(
      String? accessKey, String? userSecretKey, String contact) async {
    return apiClient!.getInfdata(accessKey, userSecretKey, contact);
  }

  Future<InfluencerResponseModel?> saveInfluencerForm(String? accessKey,
      String? userSecretKey, InfluencerRequestModel influencerRequestModel, bool status) async {
    return apiClient!.saveInfluencerRequest(
        accessKey, userSecretKey, influencerRequestModel, status);
  }

  Future<InfluencerListModel?> getInfluencerList(String? accessKey, String? userSecretKey,
      String url) async {
    return apiClient!.getInfluencerList(accessKey, userSecretKey, url);
  }

  Future<InfluencerDetailDataModel?> getInfDetailData(
      String? accessKey, String? userSecretKey, String membershipId) async {
    return apiClient!.getInfDetaildata(accessKey, userSecretKey, membershipId);
  }

  Future<InfluencerListModel> infSearch(String? accessKey, String? userSecurityKey,
      String? empID, String searchText) {
    return apiClient!.infSearch(accessKey, userSecurityKey, empID, searchText);
  }

  Future<InfluencerResponseModel?> saveNewInfluencer(String? accessKey, String? userSecretKey, InfluencerRequestModel influencerRequestModel, bool status) async {
    return apiClient!.saveNewInfluencer(
        accessKey, userSecretKey, influencerRequestModel, status);
  }
}