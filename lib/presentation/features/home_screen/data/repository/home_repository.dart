import 'package:flutter_tech_sales/presentation/features/home_screen/data/provider/home_provider.dart';
import 'package:meta/meta.dart';

class MyRepositoryHome {
  final MyApiClientHome apiClient;

  MyRepositoryHome({@required this.apiClient}) : assert(apiClient != null);

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getCheckInDetails(
      String url,
      String accessKey,
      String secretKey,
      String referenceId,
      String journeyDate,
      String journeyStartTime,
      String journeyStartLat,
      String journeyStartLong,
      String journeyEndTime,
      String journeyEndLat,
      String journeyEndLong) {
    return apiClient.getCheckInDetails(
        url,
        accessKey,
        secretKey,
        referenceId,
        journeyDate,
        journeyStartTime,
        journeyStartLat,
        journeyStartLong,
        journeyEndTime,
        journeyEndLat,
        journeyEndLong);
  }
    getHomeDashboardDetails(String empId) {
    return apiClient.getHomePageDashboardDetails(empId);
  }
}
