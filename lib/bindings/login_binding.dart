import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/provider/login_provider.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() {
      return LoginController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client())));
    });
  }
}
