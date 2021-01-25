import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/provider/sites_provider.dart';
import 'package:meta/meta.dart';

class MyRepositorySites {
  final MyApiClientSites apiClient;

  MyRepositorySites({@required this.apiClient}) : assert(apiClient != null);

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getSitesData(String accessKey, String securityKey, String url) {
    return apiClient.getSitesData(accessKey, securityKey, url);
  }

  getSearchData(String accessKey, String securityKey, String url) {
    return apiClient.getSearchData(accessKey, securityKey, url);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId, String mobileNumber) {
    return apiClient.getSecretKey(empId, mobileNumber);
  }

  getSitedetailsData(String accessKey, String userSecurityKey, int siteId) {
    return apiClient.getSiteDetailsData(accessKey, userSecurityKey, siteId);
  }

  updateSiteData(accessKey, String userSecurityKey, updateDataRequest, List<File> list, BuildContext context, int siteId) {
    return apiClient.updateSiteData(accessKey,userSecurityKey,updateDataRequest ,list,context,siteId);

  }

// getSitedetailsData(String accessKey, String userSecurityKey, int siteId) {
//   return apiClient.getSiteDetailsData(accessKey,userSecurityKey,siteId);
// }

//getSiteData(String accessKey, String userSecurityKey, int leadId) {}

}
