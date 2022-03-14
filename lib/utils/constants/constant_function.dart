import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';

class GlobalMethods{
  GlobalMethods._();


  static brandValue(List<SiteBrandEntity> siteBrandEntity,int brandId) {
    for (int i = 0; i < siteBrandEntity.length; i++) {
      if (siteBrandEntity[i].id == brandId) {
        return siteBrandEntity[i].brandName;
      }
    }
  }
 static brandProductValue(List<SiteBrandEntity> siteBrandEntity,int brandId) {
    for (int i = 0; i < siteBrandEntity.length; i++) {
      if (siteBrandEntity[i].id == brandId) {
        return siteBrandEntity[i].productName;
      }
    }
  }

 static dealerValue( List<CounterListModel>counterListModel,String soldToParty) {
    for (int i = 0; i < counterListModel.length; i++) {
      if (counterListModel[i].soldToParty == soldToParty) {
        return counterListModel[i].soldToPartyName;
      }
    }
  }

 static subDealerValue(List<CounterListModel>counterListModel ,String shipToParty) {
    for (int i = 0; i < counterListModel.length; i++) {
      if (counterListModel[i].shipToParty == shipToParty) {
        return counterListModel[i].shipToPartyName;
      }
    }
  }

 static String selectedFloorText(List<SiteFloorsEntity> siteFloorsEntity,int floorId) {
    String floorText = "";
    if (siteFloorsEntity != null && siteFloorsEntity.length > 0) {
      for (int i = 0; i < siteFloorsEntity.length; i++) {
        if (siteFloorsEntity[i].id == floorId) {
          floorText = siteFloorsEntity[i].siteFloorTxt;
        }
      }
    }
    return floorText;
  }

 static constructionStageDesc(List<ConstructionStageEntity>constructionStageEntity,int constructionStageId) {
   for (int i = 0; i < constructionStageEntity.length; i++) {
     if (constructionStageEntity[i].id == constructionStageId) {
       return constructionStageEntity[i].constructionStageText;
     }
   }
 }
}