import 'package:flutter_tech_sales/presentation/features/service_requests/controller/get_sr_complaint_data_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/save_service_request_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/sr_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/provider/sr_provider.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SRBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SrFormDataController>(() {
      return SrFormDataController(
        repository: SrRepository(
          apiClient: MyApiClientSR(
            httpClient: http.Client(),
          ),
        ),
      );
    });
    Get.lazyPut<SRListController>(() {
      return SRListController(
        repository: SrRepository(
          apiClient: MyApiClientSR(
            httpClient: http.Client(),
          ),
        ),
      );
    });
    Get.lazyPut<SaveServiceRequestController>(() {
      return SaveServiceRequestController(
        repository: SrRepository(
          apiClient: MyApiClientSR(
            httpClient: http.Client(),
          ),
        ),
      );
    });
    Get.lazyPut<UpdateServiceRequestController>(() {
      return UpdateServiceRequestController(
        repository: SrRepository(
          apiClient: MyApiClientSR(
            httpClient: http.Client(),
          )
          ),
      );
    });
  }
}
