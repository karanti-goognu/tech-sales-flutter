import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/provider/dashboard_provider.dart';

class DashboardRepository {
  final MyApiClientDashboard apiClient;

  DashboardRepository({@required this.apiClient}) : assert(apiClient != null);

  Future getAccessKey() {
    return apiClient.getAccessKey();
  }


}
