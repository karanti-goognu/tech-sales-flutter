import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SiteStageEntityDBHelper extends ChangeNotifier{
  static final SiteStageEntityDBHelper _instance = SiteStageEntityDBHelper._();
  static Database _database;

  SiteStageEntityDBHelper._();

  factory SiteStageEntityDBHelper() {
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
          await db.execute('CREATE TABLE siteStage (id INTEGER PRIMARY KEY AUTOINCREMENT, siteStageEntity TEXT)');
        });
    return database;
  }


  Future<int> addSiteStageEntityInDraft(SiteStageEntityForDB siteStageEntityForDB) async {
    var client = await db;
    print(siteStageEntityForDB.siteStageEntity);
    return client.insert('siteStage', siteStageEntityForDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SiteStageEntityForDB> fetchSiteStageEntityInDraft(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('siteStage', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      print("Here:: ");
      print(maps.first);
      return SiteStageEntityForDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateSiteStageEntityInDraft(SiteStageEntityForDB siteStageEntityForDB) async {
    print(siteStageEntityForDB.id);
    var client = await db;
    return client.update('siteStage', siteStageEntityForDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [siteStageEntityForDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeSiteStageEntityInDraft(int id) async {
    var client = await db;
    return client.delete('siteStage', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<SiteStageEntityForDB>> fetchAll() async {
    var client = await db;
    var res = await client.query('siteStage');

    if (res.isNotEmpty) {
      var siteStageEntityForDB = res.map((siteStageEntityForDB) => SiteStageEntityForDB.fromDb(siteStageEntityForDB)).toList();
      return siteStageEntityForDB;
    }
    return [];
  }


}

class SiteStageEntityForDB {
  // @required
  final int id;
  @required
  final String siteStageEntity;

  SiteStageEntityForDB(this.id, this.siteStageEntity);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['siteStageEntity'] = siteStageEntity;
    return map;
  }

  SiteStageEntityForDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        siteStageEntity = map['siteStageEntity'];
}

