import 'dart:io';

import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';




class DataBaseProvider extends Model {

  String cartMsg = "";
  bool success = false;
  Database _db;
  List<SitesEntity> _list = [];

  List<SitesEntity> get siteListing => _list;



  DataBaseProvider() {
    /// Create DB Instance & Create Table
    initDatabase();
  }

  deleteDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'database.db');

  }

  initDatabase() async {
    Database database;
    if(database!=null){
      _db=database;
    }else {
      var databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'database.db');
      await openDatabase(dbPath, version: 1, onCreate: (Database db, int version) async {
            /// When creating the db, create the table
            this._db = db;
            this.createTable();
      });
    }
  }


  createTable() async {

    try {
      var qry = 'CREATE TABLE IF NOT EXISTS siteList (id INTEGER PRIMARY KEY AUTOINCREMENT, siteId INTEGER, leadId INTEGER, siteSegment TEXT, assignedTo TEXT, siteStatusId INTEGER, siteOppertunityId INTEGER, siteStageId INTEGER, contactName TEXT, contactNumber TEXT, siteCreationDate TEXT, siteGeotag TEXT, siteGeotagLat TEXT, siteGeotagLong TEXT, sitePincode TEXT, siteState TEXT, siteDistrict TEXT, siteTaluk TEXT, siteScore DOUBLE, sitePotentialMt TEXT, reraNumber TEXT, dealerId TEXT, siteBuiltArea TEXT, noOfFloors INTEGER, productDemo TEXT, productOralBriefing TEXT, soCode TEXT, plotNumber TEXT, inactiveReasonText TEXT, nextVisitDate TEXT, closureReasonText TEXT, createdBy TEXT,  createdOn INTEGER, updatedBy TEXT, updatedOn INTEGER)';
      await this._db.execute(qry);
      await _db.execute('CREATE TABLE draftLead (id INTEGER PRIMARY KEY AUTOINCREMENT, leadModel TEXT)');
      await _db.execute('CREATE TABLE brandName (id INTEGER , brandName TEXT , productName TEXT)');
      await _db.execute('CREATE TABLE counterListDealers (id TEXT, dealerName TEXT)');
    } catch (e) {
      TsoLogger.printLog(e);
    }
  }


    filterSiteEntityList(String appendQuery,String whereArgs) async {
    var res = await _db.rawQuery('SELECT * FROM siteList WHERE $appendQuery', [whereArgs]);
    _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
    notifyListeners();
  }

  Future<void> insertSiteEntityInTable(SitesEntity sitesEntity) async {
    var result = await _db.rawInsert("INSERT Into siteList (siteId, leadId, siteSegment, assignedTo, siteStatusId, siteOppertunityId, siteStageId, contactName, contactNumber, siteCreationDate, siteGeotag, siteGeotagLat, siteGeotagLong, sitePincode, siteState, siteDistrict, siteTaluk, siteScore, sitePotentialMt, reraNumber, dealerId, siteBuiltArea, noOfFloors, productDemo, productOralBriefing, soCode, plotNumber, inactiveReasonText, nextVisitDate, closureReasonText, createdBy,  createdOn, updatedBy, updatedOn)"
        " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [sitesEntity.siteId, sitesEntity.leadId, sitesEntity.siteSegment, sitesEntity.assignedTo, sitesEntity.siteStatusId, sitesEntity.siteOppertunityId, sitesEntity.siteStageId, sitesEntity.contactName, sitesEntity.contactNumber, sitesEntity.siteCreationDate, sitesEntity.siteGeotag, sitesEntity.siteGeotagLat, sitesEntity.siteGeotagLong, sitesEntity.sitePincode, sitesEntity.siteState, sitesEntity.siteDistrict, sitesEntity.siteTaluk, sitesEntity.siteScore, sitesEntity.sitePotentialMt, sitesEntity.reraNumber, sitesEntity.dealerId, sitesEntity.siteBuiltArea, sitesEntity.noOfFloors, sitesEntity.productDemo, sitesEntity.productOralBriefing, sitesEntity.soCode, sitesEntity.plotNumber, sitesEntity.inactiveReasonText, sitesEntity.nextVisitDate, sitesEntity.closureReasonText, sitesEntity.createdBy,  sitesEntity.createdOn, sitesEntity.updatedBy, sitesEntity.updatedOn]
    );
    return result;
  }

  Future<List<SitesEntity>> fetchAllSites() async {

    var res = await _db.query("siteList");
    _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
    return _list;
  }


  Future<void> clearSiteTable() async{
    _db.delete("siteList");
  }



}

