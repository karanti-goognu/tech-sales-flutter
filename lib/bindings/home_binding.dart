import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/core/data/provider/app_provider.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/controller/home_controller.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/provider/home_provider.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/repository/home_repository.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/provider/login_provider.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/calendar_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/Repository/sites_repository.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/provider/sites_provider.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/provider/splash_provider.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:http/http.dart' as http;

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        repository: MyRepositoryHome(
            apiClient: MyApiClientHome(httpClient: http.Client()))));
    Get.lazyPut<LoginController>(() => LoginController(
        repository:
            MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

    Get.lazyPut<LeadsFilterController>(() {
      return LeadsFilterController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });
    Get.lazyPut<AddLeadsController>(() {
      return AddLeadsController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });

    Get.lazyPut<SplashController>(() {
      return SplashController(
          repository: MyRepositorySplash(
              apiClient: MyApiClientSplash(httpClient: http.Client())));
    });

    Get.lazyPut<AppController>(() {
      return AppController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });

    Get.lazyPut<SiteController>(() {
      return SiteController(
          repository: MyRepositorySites(
              apiClient: MyApiClientSites(httpClient: http.Client())));
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
    Get.lazyPut<AddEventController>(() {
      return AddEventController(
          repository: MyRepositoryApp(
              apiClient: MyApiClientApp(httpClient: http.Client())));
    });
  }
}
