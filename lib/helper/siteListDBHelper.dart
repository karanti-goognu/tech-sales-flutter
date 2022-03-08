import 'package:flutter/cupertino.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SiteListDBHelper extends ChangeNotifier{
  static final SiteListDBHelper _instance = SiteListDBHelper._();
  static Database _database;

  List<SitesEntity> _list = [];

  List<SitesEntity> get siteListing => _list;

  SiteListDBHelper._();

  factory SiteListDBHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      print("mko 1");
      return _database;
    }
    print("mko 2");
    _database = await init();
    return _database;
  }

  Future<Database> init1() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'database.db');


    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          /// When creating the db, create the table
          await db.execute('CREATE TABLE siteList (id INTEGER PRIMARY KEY AUTOINCREMENT, siteListModel TEXT)');
        });
    return database;
  }

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'database.db');

    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE siteList (id INTEGER PRIMARY KEY AUTOINCREMENT, siteId INTEGER, leadId INTEGER, siteSegment TEXT, assignedTo TEXT, siteStatusId INTEGER, siteOppertunityId INTEGER, siteStageId INTEGER, contactName TEXT, contactNumber TEXT, siteCreationDate TEXT, siteGeotag TEXT, siteGeotagLat TEXT, siteGeotagLong TEXT, sitePincode TEXT, siteState TEXT, siteDistrict TEXT, siteTaluk TEXT, siteScore DOUBLE, sitePotentialMt TEXT, reraNumber TEXT, dealerId TEXT, siteBuiltArea TEXT, noOfFloors INTEGER, productDemo TEXT, productOralBriefing TEXT, soCode TEXT, plotNumber TEXT, inactiveReasonText TEXT, nextVisitDate TEXT, closureReasonText TEXT, createdBy TEXT,  createdOn INTEGER, updatedBy TEXT, updatedOn INTEGER)');
        });
    return database;
  }



  Future<List<SitesEntity>> filterSiteEntityList(String appendQuery,String whereArgs) async {
    var client = await db;
    var res = await client.rawQuery('SELECT * FROM siteList WHERE ${appendQuery}', [whereArgs]);
    print("sadsad  "+res.toString());
    _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
    return _list;
  }

  Future<void> insertSiteEntityInTable(SitesEntity sitesEntity) async {
    var client = await db;
    var result = await client.rawInsert("INSERT Into siteList (siteId, leadId, siteSegment, assignedTo, siteStatusId, siteOppertunityId, siteStageId, contactName, contactNumber, siteCreationDate, siteGeotag, siteGeotagLat, siteGeotagLong, sitePincode, siteState, siteDistrict, siteTaluk, siteScore, sitePotentialMt, reraNumber, dealerId, siteBuiltArea, noOfFloors, productDemo, productOralBriefing, soCode, plotNumber, inactiveReasonText, nextVisitDate, closureReasonText, createdBy,  createdOn, updatedBy, updatedOn)"
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [sitesEntity.siteId, sitesEntity.leadId, sitesEntity.siteSegment, sitesEntity.assignedTo, sitesEntity.siteStatusId, sitesEntity.siteOppertunityId, sitesEntity.siteStageId, sitesEntity.contactName, sitesEntity.contactNumber, sitesEntity.siteCreationDate, sitesEntity.siteGeotag, sitesEntity.siteGeotagLat, sitesEntity.siteGeotagLong, sitesEntity.sitePincode, sitesEntity.siteState, sitesEntity.siteDistrict, sitesEntity.siteTaluk, sitesEntity.siteScore, sitesEntity.sitePotentialMt, sitesEntity.reraNumber, sitesEntity.dealerId, sitesEntity.siteBuiltArea, sitesEntity.noOfFloors, sitesEntity.productDemo, sitesEntity.productOralBriefing, sitesEntity.soCode, sitesEntity.plotNumber, sitesEntity.inactiveReasonText, sitesEntity.nextVisitDate, sitesEntity.closureReasonText, sitesEntity.createdBy,  sitesEntity.createdOn, sitesEntity.updatedBy, sitesEntity.updatedOn]
    );
    return result;
  }

  Future<List<SitesEntity>> fetchAllSites() async {
    final db1 = await db;
    var res = await db1.query("siteList");
    _list = res.isNotEmpty ? res.map((c) => SitesEntity.fromJson(c)).toList() : [];
    return _list;
  }

  Future<List<SitesEntity>> fetchAllSites1() async {
    return _list;
  }





  Future<void> clearTable() async{
    var client = await db;
    client.delete("siteList");
  }




}


