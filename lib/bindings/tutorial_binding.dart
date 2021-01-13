
import 'package:flutter_tech_sales/presentation/features/video_tutorial/controller/tutorial_list_controller.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/provider/tutorial_provider.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/repository/TutorialRepository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class TutorialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TutorialListController>(() {
      return TutorialListController(
        repository: TutorialRepository(
          apiClient: MyApiClient(
            httpClient: http.Client(),
          ),
        ),
      );
    });
  }


}