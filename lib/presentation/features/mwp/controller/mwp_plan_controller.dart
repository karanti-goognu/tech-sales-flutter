import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class MWPPlanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepository repository;

  MWPPlanController({@required this.repository}) : assert(repository != null);

  final _loginResponse = LoginModel().obs;
  final _totalConersionVol = 0.obs;
  final _newILPMembers = 0.obs;
  final _dspSlab = 0.obs;
  final _siteConVol = 0.obs;
  final _siteConNo = 0.obs;
  final _siteVisitsTotal = 0.obs;
  final _siteVisitsUnique = 0.obs;
  final _influencerVisit = 0.obs;
  final _masonMeet = 0.obs;
  final _counterMeet = 0.obs;
  final _contractorMeet = 0.obs;
  final _miniContractorMeet = 0.obs;
  final _consumerMeet = 0.obs;

  get loginResponse => this._loginResponse.value;

  set loginResponse(value) => this._loginResponse.value = value;

  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  openSplashScreen() {
    Get.toNamed(Routes.INITIAL);
  }

  get totalConersionVol => _totalConersionVol;

  set totalConersionVol(value) => _totalConersionVol.value = value;

  get newILPMembers => _newILPMembers.value;

  set newILPMembers(value) => _newILPMembers.value = value;

  get dspSlab => _dspSlab.value;

  set dspSlab(value) => _dspSlab.value = value;

  get siteConVol => _siteConVol.value;

  set siteConVol(value) => _siteConVol.value = value;

  get siteConNo => _siteConNo.value;

  set siteConNo(value) => _siteConNo.value = value;

  get siteVisitsTotal => _siteVisitsTotal.value;

  set siteVisitsTotal(value) => _siteVisitsTotal.value = value;

  get siteVisitsUnique => _siteVisitsUnique.value;

  set siteVisitsUnique(value) => _siteVisitsUnique.value = value;

  get influencerVisit => _influencerVisit.value;

  set influencerVisit(value) => _influencerVisit.value = value;

  get masonMeet => _masonMeet.value;

  set masonMeet(value) => _masonMeet.value = value;

  get counterMeet => _counterMeet.value;

  set counterMeet(value) => _counterMeet.value = value;

  get contractorMeet => _contractorMeet.value;

  set contractorMeet(value) => _contractorMeet.value = value;

  get miniContractorMeet => _miniContractorMeet;

  set miniContractorMeet(value) => _miniContractorMeet.value = value;

  get consumerMeet => _consumerMeet.value;

  set consumerMeet(value) => _consumerMeet.value = value;
}
