import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/leadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/RetryOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/enums/lead_stage.dart';
import 'package:flutter_tech_sales/utils/enums/lead_status.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class LeadsFilterController extends GetxController {
  @override
  void onInit() {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    super.onInit();
  }

  final MyRepository repository;

  LeadsFilterController({@required this.repository})
      : assert(repository != null);

  final _accessKeyResponse = AccessKeyModel().obs;

  final _phoneNumber = "8860080067".obs;

  final _selectedPosition = 0.obs;

  final _selectedLeadStage = LeadStage.NonVerified.obs;

  final _selectedLeadStatus = LeadStatus.Active.obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get selectedPosition => this._selectedPosition.value;

  get selectedLeadStage => this._selectedLeadStage.value;

  get selectedLeadStatus => this._selectedLeadStatus.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set selectedPosition(value) => this._selectedPosition.value = value;

  set selectedLeadStage(value) => this._selectedLeadStage.value = value;

  set selectedLeadStatus(value) => this._selectedLeadStatus.value = value;

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }
}
