import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ViewOldLeadsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLeadsController>(() {
      return AddLeadsController(
          repository: MyRepositoryLeads(
              apiClient: MyApiClientLeads(httpClient: http.Client())));
    });
  }
}
