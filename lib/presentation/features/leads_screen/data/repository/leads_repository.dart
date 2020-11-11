
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:meta/meta.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }
}
