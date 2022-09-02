import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SiteCompetitionStatusEntityDBHelper extends ChangeNotifier{
  static final SiteCompetitionStatusEntityDBHelper _instance = SiteCompetitionStatusEntityDBHelper._();
  static Database? _database;

  SiteCompetitionStatusEntityDBHelper._();

  factory SiteCompetitionStatusEntityDBHelper() {
    return _instance;
  }

  Future<Database?> get db async {
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
          /// When creating the db, create the table
          await db.execute('CREATE TABLE siteCompetitionStatus (id INTEGER PRIMARY KEY AUTOINCREMENT, siteCompetitionStatusEntity TEXT)');
        });
    return database;
  }


  Future<int> addSiteCompetitionStatusInDraft(SiteCompetitionStatusEntityForDB siteCompetitionStatusEntityForDB) async {
    var client = await (db as FutureOr<Database>);
    print(siteCompetitionStatusEntityForDB.siteCompetitionStatusEntity);
    return client.insert('siteCompetitionStatus', siteCompetitionStatusEntityForDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SiteCompetitionStatusEntityForDB?> fetchCompetitionStatusInDraft(int id) async {
    var client = await (db as FutureOr<Database>);
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('siteCompetitionStatus', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return SiteCompetitionStatusEntityForDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateCompetitionStatusInDraft(SiteCompetitionStatusEntityForDB siteCompetitionStatusEntityForDB) async {
    print(siteCompetitionStatusEntityForDB.id);
    var client = await (db as FutureOr<Database>);
    return client.update('siteCompetitionStatus', siteCompetitionStatusEntityForDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [siteCompetitionStatusEntityForDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeCompetitionStatusInDraft(int id) async {
    var client = await (db as FutureOr<Database>);
    return client.delete('siteCompetitionStatus', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<SiteCompetitionStatusEntityForDB>> fetchAll() async {
    var client = await (db as FutureOr<Database>);
    var res = await client.query('siteCompetitionStatus');

    if (res.isNotEmpty) {
      var siteFloorEntityForDB = res.map((siteFloorEntityForDB) => SiteCompetitionStatusEntityForDB.fromDb(siteFloorEntityForDB)).toList();
      return siteFloorEntityForDB;
    }
    return [];
  }


}

class SiteCompetitionStatusEntityForDB {
  // @required
  final int? id;
  @required
  final String? siteCompetitionStatusEntity;

  SiteCompetitionStatusEntityForDB(this.id, this.siteCompetitionStatusEntity);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['siteCompetitionStatusEntity'] = siteCompetitionStatusEntity;
    return map;
  }

  SiteCompetitionStatusEntityForDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        siteCompetitionStatusEntity = map['siteCompetitionStatusEntity'];
}

