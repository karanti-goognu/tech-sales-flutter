import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/core/data/provider/app_provider.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/Repository/sites_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/provider/sites_provider.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadsFilterController>(() {
      return LeadsFilterController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });

    Get.lazyPut<SiteController>(() {
      return SiteController(
          repository: MyRepositorySites(
              apiClient: MyApiClientSites(httpClient: http.Client())));
    });

    Get.lazyPut<AppController>(() {
      return AppController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });
  }
}
