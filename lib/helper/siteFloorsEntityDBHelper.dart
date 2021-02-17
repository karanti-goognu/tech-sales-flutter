import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SiteFloorsEntityDBHelper extends ChangeNotifier{
  static final SiteFloorsEntityDBHelper _instance = SiteFloorsEntityDBHelper._();
  static Database _database;

  SiteFloorsEntityDBHelper._();

  factory SiteFloorsEntityDBHelper() {
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
          await db.execute('CREATE TABLE siteFloor (id INTEGER PRIMARY KEY AUTOINCREMENT, siteFloorEntity TEXT)');
        });
    return database;
  }


  Future<int> addSiteFloorEntityInDraft(SiteFloorEntityForDB siteFloorEntityForDB) async {
    var client = await db;
    print(siteFloorEntityForDB.siteFloorEntity);
    return client.insert('siteFloor', siteFloorEntityForDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SiteFloorEntityForDB> fetchSiteFloorEntityInDraft(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('siteFloor', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      print("Here:: ");
      print(maps.first);
      return SiteFloorEntityForDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateSiteFloorEntityInDraft(SiteFloorEntityForDB siteFloorEntityForDB) async {
    print(siteFloorEntityForDB.id);
    var client = await db;
    return client.update('siteFloor', siteFloorEntityForDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [siteFloorEntityForDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeSiteFloorEntityInDraft(int id) async {
    var client = await db;
    return client.delete('siteFloor', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<SiteFloorEntityForDB>> fetchAll() async {
    var client = await db;
    var res = await client.query('siteFloor');

    if (res.isNotEmpty) {
      var siteFloorEntityForDB = res.map((siteFloorEntityForDB) => SiteFloorEntityForDB.fromDb(siteFloorEntityForDB)).toList();
      return siteFloorEntityForDB;
    }
    return [];
  }


}

class SiteFloorEntityForDB {
  // @required
  final int id;
  @required
  final String siteFloorEntity;

  SiteFloorEntityForDB(this.id, this.siteFloorEntity);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['siteFloorEntity'] = siteFloorEntity;
    return map;
  }

  SiteFloorEntityForDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        siteFloorEntity = map['siteFloorEntity'];
}

