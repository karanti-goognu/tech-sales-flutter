import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/database_helper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/db_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';




class SitesDBProvider extends Model {

  List<SitesEntity> _list = [];
  List<SitesEntity> get siteListing => _list;
  Future<Database> _database = DatabaseHelper().database;

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

}

