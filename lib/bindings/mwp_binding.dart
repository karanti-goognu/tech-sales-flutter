import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_calendar_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/provider/mwp_provider.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/repository/mwp_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddCalenderEventBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCalendarEventController>(() {
      return AddCalendarEventController(
          repository:
          MyRepositoryApp(apiClient: MyApiClient(httpClient: http.Client())));
    });
  }
}
