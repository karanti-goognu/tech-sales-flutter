import 'package:flutter_tech_sales/presentation/features/splash/data/provider/splash_provider.dart';

class MyRepositorySplash {
  final MyApiClientSplash apiClient;

  MyRepositorySplash({required this.apiClient});

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getRefreshData(String url, String accessKey, String securityKey) {
    return apiClient.getRefreshData(url, accessKey, securityKey);
  }

  getSecretKey(String empId, String mobileNumber) {
    return apiClient.getSecretKey(empId, mobileNumber);
  }
}
