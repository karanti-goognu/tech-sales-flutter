import 'dart:io';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/provider/dashboard_provider.dart';

class DashboardRepository {
  final MyApiClientDashboard apiClient;

  DashboardRepository({required this.apiClient});

  Future getAccessKey() {
    return apiClient.getAccessKey();
  }

 Future shareReport(File image, String? userSecurityKey, String? accessKey, String empID){
   return apiClient.shareReport(image, userSecurityKey, accessKey, empID);
 }

 Future getMonthViewDetails(String empID, String yearMonth, String? accessKey, String userSecurityKey){
    return apiClient.getMonthViewDetails(empID,yearMonth,accessKey, userSecurityKey, );
 }

 Future getDashboardMtdGeneratedVolumeSiteList(String empID, String yearMonth, String? accessKey, String userSecurityKey){
    return apiClient.getDashboardMtdGeneratedVolumeSiteList(empID,yearMonth,accessKey, userSecurityKey, );
  }

  Future getDashboardMtdConvertedVolumeList(String empID, String yearMonth, String? accessKey, String userSecurityKey){
    return apiClient.getDashboardMtdConvertedVolumeList(empID,yearMonth,accessKey, userSecurityKey, );
  }

  Future getYearlyViewDetails(String empID, String? accessKey, String? userSecurityKey){
    return apiClient.getYearlyViewDetails(empID,accessKey, userSecurityKey, );
  }



}
