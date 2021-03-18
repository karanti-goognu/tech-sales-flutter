import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPResponse.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moengage_inbox.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  NotificationController({@required this.repository}) : assert(repository != null);

  final _counterNotification = 0.obs;

  get counterNotification => _counterNotification.value;

  set counterNotification(value) => _counterNotification.value = value;

  readMessageCount() async {
    MoEngageInbox _moEngageInbox = MoEngageInbox();
    int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
    this.counterNotification = unReadMessageCount;
    print("Count-->"+unReadMessageCount.toString());
    return unReadMessageCount;

  }



}
