import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SiteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiteController>(() {
      return SiteController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });
    Get.lazyPut<LeadsFilterController>(() {
      return LeadsFilterController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });
  }
}
