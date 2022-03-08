import 'dart:io';

import 'package:flutter_tech_sales/utils/constants/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
   DatabaseHelper._createInstance();
  static Database _database;
  static Future close() async => _database.close();

  Future<Database> get database async {
    if (_database == null) {
      _database = await open();
    }
    return _database;
  }


  factory DatabaseHelper() {

    _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  static Future<String> initDb(String dbName) async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, dbName);
    if (await Directory(p.dirname(path)).exists()) {
    } else {
      try {
        await Directory(p.dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  Future<Database> open() async {
    String path = await initDb(DbConstants.DATA_BASE);
    var database =
    await openDatabase(path, version: 2, onCreate: _createDb, onUpgrade: _onUpgrade);
    return database;
  }
///create database all tables
  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${DbConstants.TABLE_DRAFT_LEAD} ('
        '${DbConstants.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' ${DbConstants.COL_LEAD_MODEL} TEXT)');

    await db.execute('CREATE TABLE ${DbConstants.TABLE_BRAND_NAME} ('
        '${DbConstants.COL_ID} INTEGER , '
        '${DbConstants.COL_BRAND_NAME} TEXT ,'
        ' ${DbConstants.COL_PRODUCT_NAME} TEXT)');

    await db.execute('CREATE TABLE ${DbConstants.TABLE_COUNTER_LIST_DEALERS} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_DEALER_NAME} TEXT)');

   await db.execute('CREATE TABLE ${DbConstants.TABLE_CONSTRUCT_STAGE} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_CONSTRUCT_STAGE_ENTITY} TEXT)');

   await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_COMPETITION_STATUS} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_SITE_COMPETITION_STATUS_ENTITY} TEXT)');

  await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_FLOOR} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_SITE_FLOOR_ENTITY} TEXT)');

 await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_LIST} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_SITE_LIST_MODEL} TEXT)');

 await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_STAGE} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_SITE_STAGE_ENTITY} TEXT)');

 await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_VISIT_HISTORY} ('
        '${DbConstants.COL_ID} TEXT,'
        ' ${DbConstants.COL_SITE_VISIT_HISTORY_ENTITY} TEXT)');

  }


///function for upgrade database tables if database version change
  void _onUpgrade(Database db,int oldVersion,  int newVersion) async {

    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_DRAFT_LEAD}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_BRAND_NAME}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_COUNTER_LIST_DEALERS}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_CONSTRUCT_STAGE}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_COMPETITION_STATUS}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_FLOOR}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_LIST}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_STAGE}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_VISIT_HISTORY}");

    _createDb(db,newVersion);
  }



  }