import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DraftLeadDBHelper extends ChangeNotifier{
  static final DraftLeadDBHelper _instance = DraftLeadDBHelper._();
  static Database? _database;



  DraftLeadDBHelper._();

  factory DraftLeadDBHelper() {
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
          await db.execute('CREATE TABLE brandName (id INTEGER , brandName TEXT , productName TEXT)');
          await db.execute('CREATE TABLE draftLead (id INTEGER PRIMARY KEY AUTOINCREMENT, leadModel TEXT)');
        });
    return database;
  }


  Future<int> addLeadInDraft(DraftLeadModelforDB draftLeadModelforDB) async {
    var client = await (db as FutureOr<Database>);
    print(draftLeadModelforDB.leadModel);
    return client.insert('draftLead', draftLeadModelforDB.toMapForDb(),
       conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<DraftLeadModelforDB?> fetchLeadInDraft(int id) async {
    var client = await (db as FutureOr<Database>);
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query('draftLead', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      print("Here:: ");
      print(maps.first);
      return DraftLeadModelforDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateLeadInDraft(DraftLeadModelforDB draftLeadModelforDB) async {
    print(draftLeadModelforDB.id);
    var client = await (db as FutureOr<Database>);
    return client.update('draftLead', draftLeadModelforDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [draftLeadModelforDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Future<int>> removeLeadInDraft(int? id) async {
    print('Draft id $id');
    var client = await (db as FutureOr<Database>);
    return client.delete('draftLead', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DraftLeadModelforDB>> fetchAll() async {
    var client = await (db as FutureOr<Database>);
    var res = await client.query('draftLead');

    if (res.isNotEmpty) {
      var draftLeads = res.map((leadMap) => DraftLeadModelforDB.fromDb(leadMap)).toList();
      return draftLeads;
    }
    return [];
  }


}

class DraftLeadModelforDB {
  // @required
  final int? id;
  @required
  final String? leadModel;

  DraftLeadModelforDB(this.id, this.leadModel);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['leadModel'] = leadModel;
    return map;
  }

  DraftLeadModelforDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        leadModel = map['leadModel'];
}
