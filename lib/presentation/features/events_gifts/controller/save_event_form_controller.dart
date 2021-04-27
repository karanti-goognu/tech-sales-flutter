import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final EgRepository repository;

  SaveEventController({@required this.repository})
      : assert(repository != null);
  final _saveEventData = SaveEventFormViewModel().obs;
  get saveEventData => _saveEventData.value;
  set saveEventData(value) => _saveEventData.value = value;

  Future<AccessKeyModel> getAccessKey() {
    // print(repository.getAccessKey().then((value) => value.accessKey));
    return repository.getAccessKey();
  }

}