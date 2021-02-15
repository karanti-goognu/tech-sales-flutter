import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/core/data/provider/app_provider.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/calendar_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/Repository/sites_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/provider/sites_provider.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() {
      return AppController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });
    Get.lazyPut<AddEventController>(() {
      return AddEventController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });
    Get.lazyPut<MWPPlanController>(() {
      return MWPPlanController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });

    Get.lazyPut<CalendarEventController>(() {
      return CalendarEventController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });

    Get.lazyPut<SiteController>(() {
      return SiteController(
          repository: MyRepositorySites(
              apiClient: MyApiClientSites(httpClient: http.Client())));
    });

  }
}
