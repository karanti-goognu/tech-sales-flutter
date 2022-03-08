import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SiteVisitHistoryEntityDBHelper extends ChangeNotifier{
  static final SiteVisitHistoryEntityDBHelper _instance = SiteVisitHistoryEntityDBHelper._();
  static Database _database;

  SiteVisitHistoryEntityDBHelper._();

  factory SiteVisitHistoryEntityDBHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'database.db');


    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE siteVisitHistory (id INTEGER PRIMARY KEY AUTOINCREMENT, siteVisitHistoryEntity TEXT)');
        });
    return database;
  }


  Future<int> addSiteVisitInDraft(SiteVisitHistoryEntityForDB siteVisitHistoryEntityForDB) async {
    var client = await db;
    return client.insert('siteVisitHistory', siteVisitHistoryEntityForDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SiteVisitHistoryEntityForDB> fetchSiteVisitHistoryEntityInDraft(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('siteVisitHistory', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return SiteVisitHistoryEntityForDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateSiteVisitInDraft(SiteVisitHistoryEntityForDB siteVisitHistoryEntityForDB) async {
    var client = await db;
    return client.update('siteVisitHistory', siteVisitHistoryEntityForDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [siteVisitHistoryEntityForDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeSiteVisitInDraft(int id) async {
    var client = await db;
    return client.delete('siteVisitHistory', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<SiteVisitHistoryEntityForDB>> fetchAll() async {
    var client = await db;
    var res = await client.query('siteVisitHistory');

    if (res.isNotEmpty) {
      var siteVisitHistoryEntityForDB = res.map((siteFloorEntityForDB) => SiteVisitHistoryEntityForDB.fromDb(siteFloorEntityForDB)).toList();
      return siteVisitHistoryEntityForDB;
    }
    return [];
  }


}

class SiteVisitHistoryEntityForDB {
  // @required
  final int id;
  @required
  final String siteVisitHistoryEntity;

  SiteVisitHistoryEntityForDB(this.id, this.siteVisitHistoryEntity);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['siteVisitHistoryEntity'] = siteVisitHistoryEntity;
    return map;
  }

  SiteVisitHistoryEntityForDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        siteVisitHistoryEntity = map['siteVisitHistoryEntity'];
}

