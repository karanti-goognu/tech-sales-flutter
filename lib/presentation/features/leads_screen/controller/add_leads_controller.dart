import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/TotalPotentialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/repository/leads_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
class AddLeadsController extends GetxController {

  List<File> imageList ;
  List<ListLeadImage> selectedImageNameList;
  @override
  void onInit() {
    super.onInit();
    imageList = [];
    selectedImageNameList = [];
  }

  updateImageList(File value, int imageStatus) {
    if(value!=null) {
      imageList.add(value);
      String imageName=value.path.split("/").last;
      selectedImageNameList.add(ListLeadImage(photoName: imageName,imageFilePath: value,
          imageStatus: imageStatus));
      update();
    }
  }

  updateImageAfterDelete(int index) {
    if(index!=null && index>=0) {
      imageList.removeAt(index);
      selectedImageNameList.removeAt(index);
      update();
    }
  }




  @override
  void onClose(){
    imageList.clear();
    super.dispose();
  }

  final MyRepositoryLeads repository;

  AddLeadsController({@required this.repository}) : assert(repository != null);
  final _phoneNumber = "8860080067".obs;

  get phoneNumber => this._phoneNumber.value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  final _accessKeyResponse = AccessKeyModel().obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  final _inflDetailResponse = InfluencerDetail().obs;

  get inflDetailResponse => this._inflDetailResponse.value;

  set inflDetailResponse(value) => this._inflDetailResponse.value = value;

  final _addLeadsInitialDataResponse = AddLeadInitialModel().obs;

  get addLeadsInitialDataResponse => this._addLeadsInitialDataResponse.value;

  set addLeadsInitialDataResponse(value) =>
      this._addLeadsInitialDataResponse.value = value;

  getAddLeadsData(String accessKey) async {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey = "";
    String empID = "";
    AddLeadInitialModel addLeadInitialModel = new AddLeadInitialModel();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      addLeadInitialModel =
          await repository.getAddLeadsData(accessKey, userSecurityKey);
    });
    return addLeadInitialModel;
    //print("access" + this.accessKeyResponse.accessKey);
  }

  getInflDetailsData(String accessKey) async {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey = "";
    InfluencerDetail influencerDetail = new InfluencerDetail();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);

      influencerDetail = await repository.getInflDetailsData(
          accessKey, userSecurityKey, this.phoneNumber);
    });
    // print("access" + this. accessKeyResponse.accessKey);
    return influencerDetail;
  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  getAccessKeyOnly() {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    return repository.getAccessKey();
    //   return this.accessKeyResponse;
  }

  getAccessKeyAndSaveLead(SaveLeadRequestModel saveLeadRequestModel,
      List<File> imageList, BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      // Get.back();

      this.accessKeyResponse = data;
//print(this.accessKeyResponse.accessKey);
      saveLeadsData(saveLeadRequestModel, imageList, context);
    });
  }

  saveLeadsData(SaveLeadRequestModel saveLeadRequestModel, List<File> imageList,
      BuildContext context) async {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print('User Security Key :: $userSecurityKey');

      await repository.saveLeadsData(this.accessKeyResponse.accessKey,
          userSecurityKey, saveLeadRequestModel, imageList, context);
    });
  }

   getLeadData(String accessKey, int leadId) async {
     String userSecurityKey = "";
    String empID = "";
    ViewLeadDataResponse viewLeadDataResponse = new ViewLeadDataResponse();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      viewLeadDataResponse = await repository.getLeadData(accessKey, userSecurityKey, leadId, empID);
     });
    return viewLeadDataResponse;
  }

  Future<ViewLeadDataResponse>getLeadDataNew(int leadId) async {
    ViewLeadDataResponse viewLeadDataResponse;
    String userSecurityKey = "";
    String empID = "";
    String accessKey = await repository.getAccessKeyNew();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      viewLeadDataResponse = await repository.getLeadDataNew(accessKey, userSecurityKey, leadId, empID);
    });
    return viewLeadDataResponse;
  }

  void updateLeadData(var updateRequestModel, List<File> imageList,
      BuildContext context, int leadId,int from) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      this.accessKeyResponse = data;
      updateLeadDataInBackend(updateRequestModel, imageList, context, leadId,from);
    });
  }

  Future<void> updateLeadDataInBackend(var updateRequestModel,
      List<File> imageList, BuildContext context, int leadId,int from) async {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      if(this.accessKeyResponse!=null)
      await repository.updateLeadsData(this.accessKeyResponse.accessKey,
          userSecurityKey, updateRequestModel, imageList, context, leadId,from);
    });
  }

  Future<TotalPotentialModel> getTotalSitePotential(var updateRequestModel) async {
    TotalPotentialModel _totalPotentialModel;
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      if(this.accessKeyResponse!=null)
      _totalPotentialModel = await repository.getTotalPotental(this.accessKeyResponse.accessKey, userSecurityKey, updateRequestModel);
    });
    return _totalPotentialModel;
  }

  Future<InfluencerDetailModel> getInfNewData(String accessKey) async {
    InfluencerDetailModel _infDetailModel;
    InfluencerModel _influencerModel;
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
    //Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // String accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      _infDetailModel = await repository.getInflNewDetailsData(accessKey, userSecurityKey, this.phoneNumber);
      _influencerModel = _infDetailModel.influencerModel;
    });
    return _infDetailModel;
  }



  /// convert image url to file
  Future<File> getFileFromUrl(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
