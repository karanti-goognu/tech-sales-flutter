import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/UpdateInfluencerRequest.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/repository/inf_repository.dart';
import 'package:get/get.dart';

class InflVisitController extends GetxController {
  @override
  void onInit() {
    print("On Init");
    selectedVisitType=null;
    super.onInit();
  }

  @override
  void onClose() {
    print("On Close");
    super.onClose();
  }

  final InfRepository repository;

  InflVisitController({required this.repository});

  InfController inflController = Get.find();

  String visitStatus = "";
  List<String> visitTypeList = [
    'PHYSICAL',
    'VIRTUAL',
  ];
  String? selectedVisitType;

  updateVisit(String? _) {
    selectedVisitType = _;
    update();
  }

  startVisit(String status) {
    visitStatus = status;
    update();
  }

  updateInfluencer(UpdateInfluencerRequest updateInflRequest){
    inflController.influencerVisitSave(updateInflRequest);
  }
}
