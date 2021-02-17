import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SiteListDBHelper extends ChangeNotifier{
  static final SiteListDBHelper _instance = SiteListDBHelper._();
  static Database _database;

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

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'database.db');


    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE siteList (id INTEGER PRIMARY KEY AUTOINCREMENT, siteListModel TEXT)');
        });
    return database;
  }


  Future<int> addSiteEntityInDraftList(SiteListModelForDB siteListModelforDB) async {
    var client = await db;
    print(siteListModelforDB.siteListModel);
    return client.insert('siteList', siteListModelforDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SiteListModelForDB> fetchSiteEntityInDraftList(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('siteList', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      print("Here:: ");
      print(maps.first);
      return SiteListModelForDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateSiteEntityInDraftList(SiteListModelForDB siteListModelforDB) async {
    print(siteListModelforDB.id);
    var client = await db;
    return client.update('siteList', siteListModelforDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [siteListModelforDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeSiteEntityInDraftList(int id) async {
    var client = await db;
    return client.delete('siteList', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async{
    var client = await db;
    client.delete("siteList");
  }


  Future<List<SiteListModelForDB>> fetchAll() async {
    var client = await db;
    var res = await client.query('siteList');

    if (res.isNotEmpty) {
      var draftLeads = res.map((leadMap) => SiteListModelForDB.fromDb(leadMap)).toList();
      return draftLeads;
    }
    return [];
  }


}

class SiteListModelForDB {
  // @required
  final int id;
  @required
  final String siteListModel;

  SiteListModelForDB(this.id, this.siteListModel);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['siteListModel'] = siteListModel;
    return map;
  }

  SiteListModelForDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        siteListModel = map['siteListModel'];
}

