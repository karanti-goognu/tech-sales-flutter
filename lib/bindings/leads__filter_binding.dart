import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/leads_filter_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LeadsFilterBinding implements Bindings {
  @override
  void dependencies() {
   // print("Dhawan123456789");
    Get.lazyPut<LeadsFilterController>(() {
      return LeadsFilterController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client())));
    });
  }
}
