import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateDatabaseDB extends ChangeNotifier{
  static final CreateDatabaseDB _instance = CreateDatabaseDB._();
  static Database _database;

  CreateDatabaseDB._();

  factory CreateDatabaseDB() {
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
          /// When creating the db, create the table
          await db.execute('CREATE TABLE draftLead (id INTEGER PRIMARY KEY AUTOINCREMENT, leadModel TEXT)');
          await db.execute('CREATE TABLE brandName (id INTEGER , brandName TEXT , productName TEXT)');
          await db.execute('CREATE TABLE counterListDealers (id TEXT, dealerName TEXT)');
          await db.execute('CREATE TABLE constructStage (id INTEGER PRIMARY KEY AUTOINCREMENT, constructStageEntity TEXT)');
          await db.execute('CREATE TABLE siteCompetitionStatus (id INTEGER PRIMARY KEY AUTOINCREMENT, siteCompetitionStatusEntity TEXT)');
          await db.execute('CREATE TABLE siteFloor (id INTEGER PRIMARY KEY AUTOINCREMENT, siteFloorEntity TEXT)');
          await db.execute('CREATE TABLE siteList (id INTEGER PRIMARY KEY AUTOINCREMENT, siteListModel TEXT)');
          await db.execute('CREATE TABLE siteStage (id INTEGER PRIMARY KEY AUTOINCREMENT, siteStageEntity TEXT)');
          await db.execute('CREATE TABLE siteVisitHistory (id INTEGER PRIMARY KEY AUTOINCREMENT, siteVisitHistoryEntity TEXT)');
    });
    return database;
}
}
