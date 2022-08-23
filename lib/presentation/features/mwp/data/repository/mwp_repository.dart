

import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/model/TargetVSActualModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/provider/mwp_provider.dart';

class MyRepositoryApp{

  final MyApiClient? apiClient;
  MyRepositoryApp({this.apiClient});

 Future<TargetVsActualModel?> getTargetVsActualData(String accessKey, String? userSecretKey,String empID) async{
   return apiClient!.getTargetVsActualData(accessKey, userSecretKey,empID);
 }

 Future<AccessKeyModel?> getAccessKey(){
   return apiClient!.getAccessKey();
 }
}