import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/gifts_controlller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/provider/gifts_provider.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/gifts_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GiftsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiftController>(() {
      return GiftController(
        repository: GiftsRepository(
          apiClient: MyApiClientEvent(
            httpClient: http.Client(),
          ),
        ),
      );
    });
  }
}