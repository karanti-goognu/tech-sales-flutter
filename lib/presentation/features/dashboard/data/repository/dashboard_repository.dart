import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/provider/dashboard_provider.dart';

class DashboardRepository {
  final MyApiClientDashboard apiClient;

  DashboardRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getAccessKey() {
    return apiClient.getAccessKey();
  }

 Future shareReport(File image, String userSecurityKey, String accessKey, String empID){
   return apiClient.shareReport(image, userSecurityKey, accessKey, empID);
 }

 Future getMonthViewDetails(String empID, String yearMonth){
    return apiClient.getMonthViewDetails(empID,yearMonth);
 }


}
