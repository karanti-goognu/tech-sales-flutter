
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:meta/meta.dart';

class MyRepositoryLeads {
  final MyApiClientLeads apiClient;

  MyRepositoryLeads({@required this.apiClient}) : assert(apiClient != null);

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getAddLeadsData(String accessKey , String userSecurityKey){
    print("cdsncjsnc"+userSecurityKey);
    return apiClient.getAddLeadsData(accessKey,userSecurityKey);
  }

  getInflDetailsData(accessKey, String userSecurityKey, phoneNumber) {
    return apiClient.getInflDetailsData(accessKey,userSecurityKey,phoneNumber);
  }
}
