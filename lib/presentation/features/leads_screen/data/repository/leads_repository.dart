
import 'dart:io';

import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:meta/meta.dart';

class MyRepositoryLeads {
  final MyApiClientLeads apiClient;

  MyRepositoryLeads({@required this.apiClient}) : assert(apiClient != null);

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getLeadsData(String accessKey,String securityKey,String url) {
    return apiClient.getLeadsData(accessKey,securityKey,url);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId,String mobileNumber) {
    return apiClient.getSecretKey(empId,mobileNumber);
  }


  getAddLeadsData(String accessKey , String userSecurityKey){
  //  print("dhawan : "+userSecurityKey);
    return apiClient.getAddLeadsData(accessKey,userSecurityKey);
  }

  getInflDetailsData(accessKey, String userSecurityKey, phoneNumber) {
    return apiClient.getInflDetailsData(accessKey,userSecurityKey,phoneNumber);
  }

  saveLeadsData(accessKey, String userSecurityKey, SaveLeadRequestModel saveLeadRequestModel, List<File> imageList) {

    return apiClient.saveLeadsData(accessKey,userSecurityKey,saveLeadRequestModel ,imageList);
  }

  getLeadData(String accessKey, String userSecurityKey, int leadId) {
    return apiClient.getLeadData(accessKey,userSecurityKey,leadId);

  }
}
