import 'package:flutter_tech_sales/presentation/features/events_gifts/data/provider/gifts_provider.dart';

class GiftsRepository {
  final MyApiClientEvent? apiClient;

  GiftsRepository({this.apiClient});

  Future<String?> getAccessKey() {
    return apiClient!.getAccessKey();
  }
  Future getGiftStockData(String referenceID,String? accessKey, String? userSecurityKey) async{
    return apiClient!.getGiftStockData(referenceID,accessKey,userSecurityKey);
  }
  Future getViewLogsData(String? accessKey, String? userSecurityKey, String empID, String monthYear )async{
    return apiClient!.getViewLogsData(accessKey,userSecurityKey,empID,monthYear );
  }
  Future addGiftStockData(String? referenceID, String? userSecurityKey, String? accessKey,String? comment, String? giftTypeId, String? giftTypeText,String? giftInHandQty,String? giftInHandQtyNew ) async{
    return apiClient!.addGiftStockData(referenceID, userSecurityKey, accessKey, comment,giftTypeId,giftTypeText, giftInHandQty,giftInHandQtyNew);
  }



}

