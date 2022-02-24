import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ConstructionStageEntityDBHelper extends ChangeNotifier{
  static final ConstructionStageEntityDBHelper _instance = ConstructionStageEntityDBHelper._();
  static Database? _database;

  ConstructionStageEntityDBHelper._();

  factory ConstructionStageEntityDBHelper() {
    return _instance;
  }

  Future<Database?> get db async {
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
          await db.execute('CREATE TABLE constructStage (id INTEGER PRIMARY KEY AUTOINCREMENT, constructStageEntity TEXT)');
        });
    return database;
  }


  Future<int> addConstructAstageInDraft(ConstructStageEntityForDB constructStageEntityForDB) async {
    var client = await (db as FutureOr<Database>);
    print(constructStageEntityForDB.constructStageEntity);
    return client.insert('constructStage', constructStageEntityForDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<ConstructStageEntityForDB?> fetchConstructStageForDBInDraft(int id) async {
    var client = await (db as FutureOr<Database>);
    final Future<List<Map<String, dynamic>>> futureMaps =
    client.query('constructStage', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      print("Here:: ");
      print(maps.first);
      return ConstructStageEntityForDB.fromDb(maps.first);
    }
    return null;
  }

  Future<int> updateConstructStageForDBInDraft(ConstructStageEntityForDB constructStageEntityForDB) async {
    print(constructStageEntityForDB.id);
    var client = await (db as FutureOr<Database>);
    return client.update('constructStage', constructStageEntityForDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [constructStageEntityForDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeConstructStageInDraft(int id) async {
    var client = await (db as FutureOr<Database>);
    return client.delete('constructStage', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ConstructStageEntityForDB>> fetchAll() async {
    var client = await (db as FutureOr<Database>);
    var res = await client.query('constructStage');

    if (res.isNotEmpty) {
      var constructStageEntityForDB = res.map((constructStageEntityForDB) => ConstructStageEntityForDB.fromDb(constructStageEntityForDB)).toList();
      return constructStageEntityForDB;
    }
    return [];
  }


}

class ConstructStageEntityForDB {
  // @required
  final int? id;
  @required
  final String? constructStageEntity;

  ConstructStageEntityForDB(this.id, this.constructStageEntity);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['constructStageEntity'] = constructStageEntity;
    return map;
  }

  ConstructStageEntityForDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        constructStageEntity = map['constructStageEntity'];
}

