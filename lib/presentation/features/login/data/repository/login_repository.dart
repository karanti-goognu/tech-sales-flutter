
import 'package:flutter_tech_sales/presentation/features/login/data/provider/login_provider.dart';
import 'package:meta/meta.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  checkLoginStatus(String empId,String mobileNumber,String accessKey) {
    return apiClient.checkLoginStatus(empId,mobileNumber,accessKey);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }
}
