
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/provider/splash_provider.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/repository/splash_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() {
      return SplashController(
          repository:
              MyRepositorySplash(apiClient: MyApiClientSplash(httpClient: http.Client())));
    });
  }
}
