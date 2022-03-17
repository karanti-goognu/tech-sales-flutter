


import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/model/TsoAppTutorialListModel.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/repository/TutorialRepository.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';

class TutorialListController extends GetxController{

  @override
  void onInit() {
    super.onInit();
  }

  final TutorialRepository repository;
  TutorialListController({required this.repository}) : assert(repository != null);

  final Rx<TsoAppTutorialListModel?> _tutorialListData = TsoAppTutorialListModel().obs;
  get tutorialListData => _tutorialListData.value;
  set tutorialListData(value) =>
      _tutorialListData.value = value;

  Future<AccessKeyModel?> getAccessKey(){
    return repository.getAccessKey();

  }

  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }


  Future<TsoAppTutorialListModel?> getAppTutorialListData(String? accessKey) async {
    String? userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      tutorialListData = await repository.getAppTutorialListData(accessKey,userSecurityKey);
    });
    return tutorialListData;
  }
}