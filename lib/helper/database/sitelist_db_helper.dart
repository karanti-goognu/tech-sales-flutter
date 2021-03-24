import 'package:flutter_tech_sales/helper/brand_name_db_config.dart';
import 'package:flutter_tech_sales/helper/database_helper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SiteRefreshDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/utils/constants/db_constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';




class SitesDBProvider extends Model {

  List<SitesModal> _list = [];
  List<SitesModal> get siteListing => _list;
  Future<Database> _database = DatabaseHelper().database;


  List<SitephotosEntity> _listPhoto = [];
  List<SitephotosEntity> get siteListPhotos => _listPhoto;

  List<SiteCommentsEntity> _listComment = [];
  List<SiteCommentsEntity> get siteListComment => _listComment;




  List<SiteFloorsEntity> siteFloorsEntity = [];
  List<SiteFloorsEntity> get siteFloorList => siteFloorsEntity;

  List<SiteBrandEntity> siteBrandEntity = [];
  List<SiteBrandEntity> get siteBrandList => siteBrandEntity;

  List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
  List<ConstructionStageEntity> constructionStageEntity = new List();
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity = new List();
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity = new List();
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity = new List();
  List<SiteStageEntity> siteStageEntity = new List();
  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<CounterListModel> counterListModel = new List();

  // SiteList DML
  createSiteEntity(SitesModal sitesEntity) async {
   var db = await _database;
   var result = db.insert("${DbConstants.TABLE_SITE_LIST}", sitesEntity.toJson());
   notifyListeners();
   this.fetchAllSites();
  }

  fetchAllSites() async {
   _list = [];
   var db = await _database;
   var res = await db.query("${DbConstants.TABLE_SITE_LIST}");
   _list = res.isNotEmpty ? res.map((c) => SitesModal.fromJson(c)).toList() : [];
   notifyListeners();
   fetchAllSites1();
 }

  Future<List<SitesModal>> fetchAllSites1() async {
    return siteListing;
  }


  filterSiteEntityList(String appendQuery,String whereArgs) async {
    _list = [];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_SITE_LIST} WHERE ${appendQuery}', [whereArgs]);
    _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
    notifyListeners();
    fetchAllSites1();
  }

  searchSiteList(String appendQuery) async{
     _list = [];
     var db = await _database;
     var res = await db.rawQuery("SELECT * FROM ${DbConstants.TABLE_SITE_LIST} WHERE ${DbConstants.COL_SITE_ID} LIKE '%${appendQuery}%' OR  ${DbConstants.COL_OWNER_CONTACT_NUMBER} LIKE '%${appendQuery}%' OR  ${DbConstants.COL_SITE_PIN_CODE} LIKE '%${appendQuery}'");
     _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
     notifyListeners();
     fetchAllSites1();
  }


  Future<int> updateSitesEntity(SitesEntity sitesEntity) async {
    var db = await _database;
    return await db.update("${DbConstants.TABLE_SITE_LIST}", sitesEntity.toJson(), where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitesEntity.siteId]);
  }

  Future<int> deleteSitesEntity(SitesEntity sitesEntity) async {
    var db = await _database;
    return await db.delete("${DbConstants.TABLE_SITE_LIST}", where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitesEntity.siteId]);
  }

  Future<void> clearTable() async{
    var db = await _database;
    db.delete("${DbConstants.TABLE_SITE_LIST}");
  }


  // SitePhoto DML

  createSitePhotoEntity(SitephotosEntity sitePhotosEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}", sitePhotosEntity.toJson());
    print("SiteRefresh--->"+result.toString());
    notifyListeners();
    this.fetchSiteAllPhotos();
  }

  fetchSiteAllPhotos() async {
    _listPhoto= [];
    var db = await _database;
    var res = await db.query("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}");
    _listPhoto = res.isNotEmpty ? res.map((c) => SitephotosEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  Future<List<SitephotosEntity>> fetchAllPhotos() async {
    return siteListPhotos;
  }

  filterSiteAPhoto(String appendQuery,String whereArgs) async {
    _listPhoto = [];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_SITE_PHOTOS_ENTITY} WHERE ${appendQuery}', [whereArgs]);
    _listPhoto = res.isNotEmpty ? res.map((c) => SitephotosEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  Future<int> updateSitesPhoto(SitephotosEntity sitePhotosEntity) async {
    var db = await _database;
    return await db.update("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}", sitePhotosEntity.toJson(), where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitePhotosEntity.siteId]);
  }

  Future<int> deleteSitesPhoto(SitephotosEntity sitesEntity) async {
    var db = await _database;
    return await db.delete("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}", where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitesEntity.siteId]);
  }

  Future<void> clearPhotoTable() async{
    var db = await _database;
    db.delete("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}");
  }

  // end here


// SiteComment DML
  createSiteCommentEntity(SiteCommentsEntity sitePhotosEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_COMMENT_ENTITY}", sitePhotosEntity.toJson());
    notifyListeners();
    this.fetchSiteAllComment();

  }

  fetchSiteAllComment() async {
    _listComment= [];
    var db = await _database;
    var res = await db.query("${DbConstants.TABLE_SITE_COMMENT_ENTITY}");
    _listComment = res.isNotEmpty ? res.map((c) => SiteCommentsEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  Future<List<SiteCommentsEntity>> fetchAllComm() async {
    return siteListComment;
  }

  filterSiteComment(String appendQuery,String whereArgs) async {
    _listComment = [];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_SITE_COMMENT_ENTITY} WHERE ${appendQuery}', [whereArgs]);
    _listComment = res.isNotEmpty ? res.map((c) => SiteCommentsEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  Future<int> updateSitesComment(SiteCommentsEntity sitePhotosEntity) async {
    var db = await _database;
    return await db.update("${DbConstants.TABLE_SITE_COMMENT_ENTITY}", sitePhotosEntity.toJson(), where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitePhotosEntity.siteId]);
  }

  Future<int> deleteSitesComment(SiteCommentsEntity sitesEntity) async {
    var db = await _database;
    return await db.delete("${DbConstants.TABLE_SITE_COMMENT_ENTITY}", where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitesEntity.siteId]);
  }

  Future<void> clearCommentTable() async{
    var db = await _database;
    db.delete("${DbConstants.TABLE_SITE_COMMENT_ENTITY}");
  }

// end here


  createSiteFloorsEntity(SiteFloorsEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_FLOOR_ENTITY}", sitesEntity.toJson());
    print("siteFloorsEntity .....   ${result.toString()}");

    notifyListeners();
    this.fetchSiteFloor();

  }

  createSiteVisitHistoryEntity(SiteVisitHistoryEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY}", sitesEntity.toJson());
    notifyListeners();

  }

  createSiteStageEntity(SiteStageEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_STAGE_ENTITY}", sitesEntity.toJson());
    notifyListeners();

  }


  Future<List<SiteStageEntity>> querySiteStateValue(int keyId) async {
    siteStageEntity=[];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_SITE_STAGE_ENTITY} WHERE ${DbConstants.COL_ID}=?', [keyId]);
    siteStageEntity = res.isNotEmpty ? res.map((c) => SiteStageEntity.fromJson(c)).toList() : [];
    return siteStageEntity;
  }

  Future<List<SiteOpportunityStatusEntity>> fetchSiteOpportunityById(int keyId) async {
    siteOpportunityStatusEntity=[];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_Site_OPPORTUNITY_STATUS_ENTITY} WHERE ${DbConstants.COL_ID}=?', [keyId]);
    siteOpportunityStatusEntity = res.isNotEmpty ? res.map((c) => SiteOpportunityStatusEntity.fromJson(c)).toList() : [];
    return siteOpportunityStatusEntity;
  }

  Future<List<SiteProbabilityWinningEntity>> fetchSiteProbabilityWinningEntity(int keyId) async {
    siteProbabilityWinningEntity=[];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_SITE_PROBABILITY_WINNING_ENTITY} WHERE ${DbConstants.COL_ID}=?', [keyId]);
    siteProbabilityWinningEntity = res.isNotEmpty ? res.map((c) => SiteProbabilityWinningEntity.fromJson(c)).toList() : [];
    return siteProbabilityWinningEntity;
  }



  createConstructionStageEntity(ConstructionStageEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_CONSTRUCTION_STAGE_ENTITY}", sitesEntity.toJson());
    notifyListeners();

  }

  createSiteProbabilityWinningEntity(SiteProbabilityWinningEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_PROBABILITY_WINNING_ENTITY}", sitesEntity.toJson());
    notifyListeners();
  }

  createSiteCompetitionStatusEntity(SiteCompetitionStatusEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_COMPETITION_STATUS_ENTITY}", sitesEntity.toJson());
    notifyListeners();
  }


  createSiteBrandEntity(SiteBrandEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_BRAND_NAME}", sitesEntity.toJson());
    notifyListeners();
  }

  createSiteNextStageEntity(SiteNextStageEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_NEXT_STAGE_ENTITY}", sitesEntity.toJson());
    notifyListeners();
  }

  createSiteOpportunityStatusEntity(SiteOpportunityStatusEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_Site_OPPORTUNITY_STATUS_ENTITY}", sitesEntity.toJson());
    notifyListeners();

  }

  createCounterListModel(CounterListModel sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_COUNTER_LIST_DEALERS}", sitesEntity.toJson());
    notifyListeners();

  }

  createSiteInfluencerEntity(SiteInfluencerEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_INFLUENCER}", sitesEntity.toJson());
    notifyListeners();

  }

  createInfluencerTypeEntity(InfluencerTypeEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_INFLUENCER_TYPE}", sitesEntity.toJson());
    notifyListeners();

  }

  createInfluencerCategoryEntity(InfluencerCategoryEntity sitesEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_INFLUENCER_CATEGORY}", sitesEntity.toJson());
    notifyListeners();

  }


  Future<void> clearRefreshTable() async{
    var db = await _database;
    db.delete("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_LIST}");
    db.delete("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_COMMENT_ENTITY}");
    db.delete("${DbConstants.TABLE_DRAFT_LEAD}");
    db.delete("${DbConstants.TABLE_BRAND_NAME}");
    db.delete("${DbConstants.TABLE_COUNTER_LIST_DEALERS}");
    db.delete("${DbConstants.TABLE_SITE_FLOOR_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_STAGE_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_CONSTRUCTION_STAGE_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_PROBABILITY_WINNING_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_COMPETITION_STATUS_ENTITY}");
    db.delete("${DbConstants.TABLE_Site_OPPORTUNITY_STATUS_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY}");
    db.delete("${DbConstants.TABLE_SITE_NEXT_STAGE_ENTITY}");
  }


  DatabaseHelper _databaseHelper=new DatabaseHelper();

  /*get Construction table data*/
  Future<List<ConstructionStageEntity>> fetchConstructionStageEntityData() async {
    var db = await _database;
    List<ConstructionStageEntity> constructionStageEntity=new List<ConstructionStageEntity>();
    await db.query(DbConstants.TABLE_SITE_CONSTRUCTION_STAGE_ENTITY).then((value) {
      value.forEach((element) {
        constructionStageEntity.add(ConstructionStageEntity.fromJson(element));
      });
    }
    );

 return constructionStageEntity;
  }


  /*get floors table data*/
  Future<List<SiteFloorsEntity>> fetchFloorsData() async {
    List<SiteFloorsEntity> siteFloorsEntity=new List<SiteFloorsEntity>();
    var db = await _database;


   await db.query(DbConstants.TABLE_SITE_FLOOR_ENTITY).then((value) {
     print("siteFloorsEntity,,, ${value.length}");
     value.forEach((element) {
        siteFloorsEntity.add(SiteFloorsEntity.fromJson(element));
        print("siteFloorsEntity ${siteFloorsEntity.length}");

      });
    });


    return siteFloorsEntity;
  }

  /*get brand table data*/
  Future<List<BrandModelforDB>> fetchBrandData() async {
    List<BrandModelforDB> brandEntity=new List<BrandModelforDB>();
    var db = await _database;
   // var res = await db.rawQuery('SELECT DISTINCT brandName FROM brandName');
    await db.rawQuery("SELECT DISTINCT "+DbConstants.COL_BRAND_NAME /*+", "+ DbConstants.COL_ID*/ +" FROM " +DbConstants.TABLE_BRAND_NAME).then((value) {
      value.forEach((element) {
        brandEntity.add(BrandModelforDB.fromDb(element));
      });
    }
    );

    return brandEntity;
  }


  /*get floors table data*/
  Future<List<SiteVisitHistoryEntity>> fetchVisitHistoryData() async {
    List<SiteVisitHistoryEntity> dataEntity=new List<SiteVisitHistoryEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteVisitHistoryEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }

  /*get winn table data*/
  Future<List<SiteProbabilityWinningEntity>> fetchProWinningData() async {
    List<SiteProbabilityWinningEntity> dataEntity=new List<SiteProbabilityWinningEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_PROBABILITY_WINNING_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteProbabilityWinningEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }

  fetchSiteFloor() async {
    siteFloorsEntity= [];
    var db = await _database;
    var res = await db.query("${DbConstants.TABLE_SITE_FLOOR_ENTITY}");
    siteFloorsEntity = res.isNotEmpty ? res.map((c) => SiteFloorsEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  Future<List<SiteFloorsEntity>> fetchAllSiteFloor() async {
    return siteFloorList;
  }





  Future<List<SiteCompetitionStatusEntity>> fetchCompetitionStatusData() async {
    List<SiteCompetitionStatusEntity> dataEntity=new List<SiteCompetitionStatusEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_COMPETITION_STATUS_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteCompetitionStatusEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }

  Future<List<SiteOpportunityStatusEntity>> fetchOpportunityStatusData() async {
    List<SiteOpportunityStatusEntity> dataEntity=new List<SiteOpportunityStatusEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_Site_OPPORTUNITY_STATUS_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteOpportunityStatusEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }

  Future<List<SiteCommentsEntity>> fetchCommentEntityData() async {
    List<SiteCommentsEntity> dataEntity=new List<SiteCommentsEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_COMMENT_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteCommentsEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }


  Future<List<SitephotosEntity>> fetchPhotoData() async {
    List<SitephotosEntity> dataEntity=new List<SitephotosEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_PHOTOS_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SitephotosEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }



  Future<List<InfluencerTypeEntity>> fetchInfluencerTypeData() async {
    List<InfluencerTypeEntity> dataEntity=new List<InfluencerTypeEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_INFLUENCER_TYPE).then((value) {
      value.forEach((element) {
        dataEntity.add(InfluencerTypeEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }


  Future<List<InfluencerCategoryEntity>> fetchInfluencerCategoryData() async {
    List<InfluencerCategoryEntity> dataEntity=new List<InfluencerCategoryEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_INFLUENCER_CATEGORY).then((value) {
      value.forEach((element) {
        dataEntity.add(InfluencerCategoryEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }

  Future<List<InfluencerEntity>> fetchInfluencerData() async {
    List<InfluencerEntity> dataEntity=new List<InfluencerEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_INFLUENCER).then((value) {
      value.forEach((element) {
        dataEntity.add(InfluencerEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }


  Future<List<SiteInfluencerEntity>> fetchSiteInfluencerEntityData() async {
    List<SiteInfluencerEntity> dataEntity=new List<SiteInfluencerEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_INFLUENCER_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteInfluencerEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }


  Future<List<SiteStageEntity>> fetchSiteStageEntityData() async {
    List<SiteStageEntity> dataEntity=new List<SiteStageEntity>();
    var db = await _database;
    await db.query(DbConstants.TABLE_SITE_STAGE_ENTITY).then((value) {
      value.forEach((element) {
        dataEntity.add(SiteStageEntity.fromJson(element));
      });
    }
    );

    return dataEntity;
  }

  Future<List<CounterListModel>> fetchCounterDealersData() async {
    List<CounterListModel> dataEntity=new List<CounterListModel>();
    var db = await _database;
    await db.query(DbConstants.TABLE_COUNTER_LIST_DEALERS).then((value) {
      value.forEach((element) {
        dataEntity.add(CounterListModel.fromJson(element));
      });
    }
    );

    return dataEntity;
  }


  Future<List<DealerForDb>> fetchDealerData() async {
    List<DealerForDb> dataEntity=new List<DealerForDb>();
    var db = await _database;
    var res = await db.rawQuery('SELECT DISTINCT soldToParty, soldToPartyName FROM counterListDealers');
    if (res.isNotEmpty) {
      dataEntity = res.map((dealerMap) => DealerForDb.fromDb(dealerMap)).toList();
      print("res FROM DB   $res");
     }

    return dataEntity;
  }


  /*update site list table data*/






}

