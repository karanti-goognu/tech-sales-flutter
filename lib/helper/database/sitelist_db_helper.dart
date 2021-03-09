import 'package:flutter_tech_sales/helper/database_helper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/UpdateDataRequest.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/db_constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';




class SitesDBProvider extends Model {

  List<SitesEntity> _list = [];
  List<SitesEntity> get siteListing => _list;
  Future<Database> _database = DatabaseHelper().database;


  List<SitePhotosEntity> _listPhoto = [];
  List<SitePhotosEntity> get siteListPhotos => _listPhoto;

  List<SiteCommentsEntity> _listComment = [];
  List<SiteCommentsEntity> get siteListComment => _listComment;


  List<SiteFloorsEntity> siteFloorsEntity = new List();

  List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
  List<ConstructionStageEntity> constructionStageEntity = new List();
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity = new List();
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity = new List();
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity = new List();
  List<SiteBrandEntity> siteBrandEntity = new List();
  List<SiteStageEntity> siteStageEntity = new List();
  List<SiteNextStageEntity> siteNextStageEntity = new List();
  List<CounterListModel> counterListModel = new List();

  // SiteList DML
  createSiteEntity(SitesEntity sitesEntity) async {
   var db = await _database;
   var result = db.insert("${DbConstants.TABLE_SITE_LIST}", sitesEntity.toJson());
   notifyListeners();
   fetchAllSites1();
  }

  fetchAllSites() async {
   _list = [];
   var db = await _database;
   var res = await db.query("${DbConstants.TABLE_SITE_LIST}");
   _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
   notifyListeners();
   fetchAllSites1();
 }

  Future<List<SitesEntity>> fetchAllSites1() async {
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

  createSitePhotoEntity(SitePhotosEntity sitePhotosEntity) async {
    var db = await _database;
    var result = db.insert("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}", sitePhotosEntity.toJson());
    notifyListeners();
  }

  fetchSiteAllPhotos() async {
    _listPhoto= [];
    var db = await _database;
    var res = await db.query("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}");
    _listPhoto = res.isNotEmpty ? res.map((c) => SitePhotosEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  filterSiteAPhoto(String appendQuery,String whereArgs) async {
    _listPhoto = [];
    var db = await _database;
    var res = await db.rawQuery('SELECT * FROM ${DbConstants.TABLE_SITE_PHOTOS_ENTITY} WHERE ${appendQuery}', [whereArgs]);
    _listPhoto = res.isNotEmpty ? res.map((c) => SitePhotosEntity.fromJson(c)).toList() : [];
    notifyListeners();
    fetchAllSites();
  }

  Future<int> updateSitesPhoto(SitePhotosEntity sitePhotosEntity) async {
    var db = await _database;
    return await db.update("${DbConstants.TABLE_SITE_PHOTOS_ENTITY}", sitePhotosEntity.toJson(), where: "${DbConstants.COL_SITE_ID}= ?", whereArgs: [sitePhotosEntity.siteId]);
  }

  Future<int> deleteSitesPhoto(SitePhotosEntity sitesEntity) async {
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
  }

  fetchSiteAllComment() async {
    _listComment= [];
    var db = await _database;
    var res = await db.query("${DbConstants.TABLE_SITE_COMMENT_ENTITY}");
    _listComment = res.isNotEmpty ? res.map((c) => SiteCommentsEntity.fromJson(c)).toList() : [];
    notifyListeners();
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
    notifyListeners();

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





}

