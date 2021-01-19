import 'dart:io';

import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/RequestorDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SaveServiceRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/provider/sr_provider.dart';

class SrRepository{

  final MyApiClient apiClient;
  SrRepository({this.apiClient});

  Future<AccessKeyModel> getAccessKey(){
    return apiClient.getAccessKey();
  }

  Future<SrComplaintModel> getSrFormData(String accessKey, String userSecretKey) async{
    return apiClient.getSrComplaintData(accessKey, userSecretKey);
  }

  Future<RequestorDetailsModel> getRequestorDetails(String accessKey, String userSecretKey, String empID, String requesterType) async{
    return apiClient.getRequestorDetails(accessKey, userSecretKey, empID, requesterType);
  }

  Future<ServiceRequestComplaintListModel> getSrListData(String accessKey, String userSecretKey,String empID) async{
    return apiClient.getSrListData(accessKey, userSecretKey, empID);
  }

  Future<ServiceRequestComplaintListModel> getSrListDataWithFilters(String accessKey, String userSecretKey,String empID, String resolutionStatusId,String severity, String typeOfReqId) async{
    return apiClient.getSrListDataWithFilters(accessKey, userSecretKey, empID, resolutionStatusId, severity, typeOfReqId);
  }

  Future<ServiceRequestComplaintListModel> getSiteListData(String accessKey, String userSecretKey,String empID, String siteID) async{
    return apiClient.getSiteListData(accessKey, userSecretKey, empID, siteID);
  }

  Future<Map> saveServiceRequest(List<File> imageList,String accessKey, String userSecretKey, SaveServiceRequest saveRequestModel) async{
    return apiClient.saveServiceRequest(imageList, accessKey, userSecretKey,  saveRequestModel);
  }

  Future<Map> updateServiceRequest(List<File> imageList,String accessKey, String userSecretKey, UpdateSRModel updateRequestModel) async{
    return apiClient.updateServiceRequest(imageList, accessKey, userSecretKey,  updateRequestModel);
  }

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getSiteAreaDetails(String accessKey, String userSecretKey,String empID, String siteID) {
    return apiClient.getSiteAreaDetails(accessKey, userSecretKey,empID, siteID);
  }

  Future<ComplaintViewModel> getComplaintViewData(String accessKey, String userSecretKey,String empID, String id) async{
    return apiClient.getComplaintViewData(accessKey, userSecretKey, empID, id);
  }
}