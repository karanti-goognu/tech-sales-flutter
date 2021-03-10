import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/provider/dashboard_provider.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() {
      return DashboardController(
          repository: DashboardRepository(
              apiClient: MyApiClientDashboard(httpClient: http.Client()))
              );
    });
  }
}
