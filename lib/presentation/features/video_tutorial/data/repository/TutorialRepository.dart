import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/model/TsoAppTutorialListModel.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/provider/tutorial_provider.dart';

class TutorialRepository{

  final MyApiClient apiClient;
  TutorialRepository({this.apiClient});

  Future<AccessKeyModel> getAccessKey(){
    return apiClient.getAccessKey();
  }

  Future<TsoAppTutorialListModel> getAppTutorialListData(String accessKey, String userSecretKey) async{
    return apiClient.getAppTutorialListData(accessKey, userSecretKey);
  }
}