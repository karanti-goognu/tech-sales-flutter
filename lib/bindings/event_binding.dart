import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/approved_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/detail_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/event_type_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/provider/eg_provider.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EGBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventTypeController>(() {
      return EventTypeController(
        repository: EgRepository(
          apiClient: MyApiClientEvent(
            httpClient: http.Client(),
          ),
        ),
      );
    });

    Get.lazyPut<AllEventController>(() {
      return AllEventController(
        repository: EgRepository(
          apiClient: MyApiClientEvent(
            httpClient: http.Client(),
          ),
        ),
      );
    });

    Get.lazyPut<EventsFilterController>(() {
      return EventsFilterController(
        repository: EgRepository(
          apiClient: MyApiClientEvent(
            httpClient: http.Client(),
          ),
        ),
      );
    });

    Get.lazyPut<DetailEventController>(() {
      return DetailEventController(
        repository: EgRepository(
          apiClient: MyApiClientEvent(
            httpClient: http.Client(),
          ),
        ),
      );
    });
  }
}
