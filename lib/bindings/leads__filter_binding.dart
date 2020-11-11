//import 'file:///C:/Users/hp/StudioProjects/tech-sales-flutter/lib/presentation/features/leads_filter/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_filter/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/provider/login_provider.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LeadsFilterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadsFilterController>(() {
      return LeadsFilterController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client())));
    });
  }
}
