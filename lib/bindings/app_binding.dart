import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/core/data/provider/app_provider.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() {
      return AppController(
        repository: MyRepositoryApp(
          apiClient: MyApiClientApp(
            httpClient: http.Client(),
          ),
        ),
      );
    });
    Get.lazyPut<AddEventController>(() {
      return AddEventController(
        repository: MyRepositoryApp(
          apiClient: MyApiClientApp(
            httpClient: http.Client(),
          ),
        ),
      );
    });
  }
}
