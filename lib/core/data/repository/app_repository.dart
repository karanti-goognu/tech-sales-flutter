import 'package:flutter_tech_sales/core/data/provider/app_provider.dart';
import 'package:meta/meta.dart';

class MyRepositoryApp {
  final MyApiClientApp apiClient;

  MyRepositoryApp({@required this.apiClient}) : assert(apiClient != null);

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId, String mobileNumber) {
    return apiClient.getSecretKey(empId, mobileNumber);
  }

  getTargetVsActualData(String url) {
    return apiClient.getTargetVsActualData(url);
  }
}
