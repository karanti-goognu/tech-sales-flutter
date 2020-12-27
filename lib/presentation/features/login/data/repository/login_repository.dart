import 'package:flutter_tech_sales/presentation/features/login/data/provider/login_provider.dart';
import 'package:meta/meta.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  checkLoginStatus(String empId, String mobileNumber, String accessKey) {
    return apiClient.checkLoginStatus(empId, mobileNumber, accessKey);
  }

  retryOtp(
      String empId, String mobileNumber, String accessKey, String otpTokenId) {
    return apiClient.retryOtp(empId, mobileNumber, accessKey, otpTokenId);
  }

  validateOtp(
      String empId, String mobileNumber, String accessKey, String otpCode) {
    return apiClient.validateOtp(empId, mobileNumber, accessKey, otpCode);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }
}
