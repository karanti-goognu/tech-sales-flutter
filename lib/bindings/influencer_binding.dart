import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/provider/inf_provider.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/repository/inf_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InfBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfController>(() {
      return InfController(
        repository: InfRepository(
          apiClient: MyApiClientInf(
            httpClient: http.Client(),
          ),
        ),
      );
    });
  }
}