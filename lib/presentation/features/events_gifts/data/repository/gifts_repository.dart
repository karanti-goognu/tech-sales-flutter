import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/provider/gifts_provider.dart';

class GiftsRepository {
  final MyApiClientEvent apiClient;

  GiftsRepository({this.apiClient});

  Future<AccessKeyModel> getAccessKey() {
    return apiClient.getAccessKey();
  }
  Future<GetGiftStockModel> getGiftStockData(String referenceID) async{
    return apiClient.getGiftStockData(referenceID);
  }
}