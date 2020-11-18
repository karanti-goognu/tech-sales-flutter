import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/provider/splash_provider.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/repository/splash_repository.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LeadsFilterBinding implements Bindings {
  @override
  void dependencies() {
    // print("Dhawan123456789");
    Get.lazyPut<LeadsFilterController>(() {
      return LeadsFilterController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });

    Get.lazyPut<SplashController>(() {
      return SplashController(
          repository: MyRepositorySplash(
              apiClient: MyApiClientSplash(httpClient: http.Client())));
    });
  }
}
