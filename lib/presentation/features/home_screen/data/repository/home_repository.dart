import 'package:flutter_tech_sales/presentation/features/home_screen/data/provider/home_provider.dart';
import 'package:meta/meta.dart';

class MyRepositoryHome {
  final MyApiClientHome apiClient;

  MyRepositoryHome({@required this.apiClient}) : assert(apiClient != null);

  getAccessKey() {
    return apiClient.getAccessKey();
  }
}
