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
    await openDatabase(path, version: 4, onCreate: _createDb, onUpgrade: _onUpgrade);
    return database;
  }

//create database all tables
  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${DbConstants.TABLE_DRAFT_LEAD} ('
        '${DbConstants.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' ${DbConstants.COL_LEAD_MODEL} TEXT)');

    await db.execute('CREATE TABLE ${DbConstants.TABLE_BRAND_NAME} ('
        '${DbConstants.COL_ID} INTEGER , '
        '${DbConstants.COL_BRAND_NAME} TEXT ,'
        ' ${DbConstants.COL_PRODUCT_NAME} TEXT)');


    // await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_LIST} ('
    //     '${DbConstants.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT,'
    //     '${DbConstants.COL_SITE_ID} INTEGER,'
    //     '${DbConstants.COL_LEAD_ID} INTEGER,'
    //     '${DbConstants.COL_SITE_SEGMENT} TEXT,'
    //     '${DbConstants.COL_ASSIGNED_TO} TEXT,'
    //     '${DbConstants.COL_SITE_STATUS_ID} INTEGER,'
    //     '${DbConstants.COL_SITE_OPPERTUNITY_ID} INTEGER,'
    //     '${DbConstants.COL_SITE_PROBABILITY_WINNING_ID} INTEGER,'
    //     '${DbConstants.COL_SITE_STAGE_ID} INTEGER,'
    //     '${DbConstants.COL_CONTACT_NAME} TEXT,'
    //     '${DbConstants.COL_CONTACT_NUMBER} TEXT,'
    //     '${DbConstants.COL_SITE_CREATION_DATE} TEXT,'
    //     '${DbConstants.COL_SITE_GEO_TAG} TEXT,'
    //     '${DbConstants.COL_SITE_GEO_TAG_LAT} TEXT,'
    //     '${DbConstants.COL_SITE_GEO_TAG_LONG} TEXT,'
    //     '${DbConstants.COL_SITE_PIN_CODE} TEXT,'
    //     '${DbConstants.COL_SITE_STATE} TEXT,'
    //     '${DbConstants.COL_SITE_DISTRICT} TEXT,'
    //     '${DbConstants.COL_SITE_TALUK} TEXT,'
    //     '${DbConstants.COL_SITE_SCORE} DOUBLE,'
    //     '${DbConstants.COL_SITE_POTENTIAL_MT} TEXT,'
    //     '${DbConstants.COL_RERA_NUMBER} TEXT,'
    //     '${DbConstants.COL_DEALER_ID} TEXT,'
    //     '${DbConstants.COL_SITE_BUILT_AREA} TEXT,'
    //     '${DbConstants.COL_NO_OF_FLOORS} INTEGER,'
    //     '${DbConstants.COL_PRODUCT_DEMO} TEXT,'
    //     '${DbConstants.COL_PRODUCT_ORAL_BRIEFING} TEXT,'
    //     '${DbConstants.COL_SO_CODE} TEXT,'
    //     '${DbConstants.COL_PLOT_NUMBER} TEXT,'
    //     '${DbConstants.COL_INACTIVE_REASON_TEXT} TEXT,'
    //     '${DbConstants.COL_NEXT_VISIT_DATE} TEXT,'
    //     '${DbConstants.COL_CLOSURE_REASON_TEXT} TEXT,'
    //     '${DbConstants.COL_CREATED_BY} TEXT,'
    //     '${DbConstants.COL_CREATED_ON} INTEGER,'
    //     '${DbConstants.COL_UPDATED_BY} TEXT,'
    //     '${DbConstants.COL_UPDATED_ON} INTEGER,'
    //     '${DbConstants.COL_SYNC_STATUS} BOOL)'
    // );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_LIST} ('
        '${DbConstants.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DbConstants.COL_SITE_ID} INTEGER,'
        '${DbConstants.COL_SITE_BUILT_AREA} TEXT,'
        '${DbConstants.COL_PRODUCT_DEMO} TEXT,'
        '${DbConstants.COL_PRODUCT_ORAL_BRIEFING} TEXT,'
        '${DbConstants.COL_PLOT_NUMBER} TEXT,'
        '${DbConstants.COL_SITE_POTENTIAL_MT} TEXT,'
        '${DbConstants.COL_OWNER_CONTACT_NAME} TEXT,'
        '${DbConstants.COL_OWNER_CONTACT_NUMBER} TEXT,'
        '${DbConstants.COL_SITE_ADDRESS} TEXT,'
        '${DbConstants.COL_SITE_STATE} TEXT,'
        '${DbConstants.COL_SITE_DISTRICT} TEXT,'
        '${DbConstants.COL_SITE_TALUK} TEXT,'
        '${DbConstants.COL_SITE_PIN_CODE} TEXT,'
        '${DbConstants.COL_SITE_GEO_TAG_LAT} TEXT,'
        '${DbConstants.COL_SITE_GEO_TAG_LONG} TEXT,'
        '${DbConstants.COL_SITE_GEO_TAG_TYPE} TEXT,'
        '${DbConstants.COL_RERA_NUMBER} TEXT,'
        '${DbConstants.COL_DEALER_ID} TEXT,'
        '${DbConstants.COL_SITE_DEALER_NAME} TEXT,'
        '${DbConstants.COL_SO_ID} TEXT,'
        '${DbConstants.COL_SITE_SO_NAME} TEXT,'
        '${DbConstants.COL_SITE_STAGE_ID} INTEGER,'
        '${DbConstants.COL_INACTIVE_REASON_TEXT} TEXT,'
        '${DbConstants.COL_NEXT_VISIT_DATE} TEXT,'
        '${DbConstants.COL_CLOSURE_REASON_TEXT} TEXT,'
        '${DbConstants.COL_SITE_PROBABILITY_WINNING_ID} INTEGER,'
        '${DbConstants.COL_SITE_COMPETITION_ID} INTEGER,'
        '${DbConstants.COL_SITE_OPPERTUNITY_ID} INTEGER,'
        '${DbConstants.COL_ASSIGNED_TO} TEXT,'
        '${DbConstants.COL_SITE_STATUS_ID} INTEGER,'
        '${DbConstants.COL_SITE_CREATION_DATE} TEXT,'
        '${DbConstants.COL_SITE_CONSTRUCTION_ID} INTEGER,'
        '${DbConstants.COL_NO_OF_FLOORS} INTEGER,'
        '${DbConstants.COL_SITE_SCORE} DOUBLE,'
        '${DbConstants.COL_SITE_SEGMENT} TEXT,'
        '${DbConstants.COL_LEAD_ID} INTEGER,'
        '${DbConstants.COL_CREATED_BY} TEXT,'
        '${DbConstants.COL_CREATED_ON} INTEGER,'
        '${DbConstants.COL_UPDATED_BY} TEXT,'
        '${DbConstants.COL_UPDATED_ON} INTEGER,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );


    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_PHOTOS_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER ,'
        '${DbConstants.COL_SITE_ID} INTEGER,'
        '${DbConstants.COL_SITE_PHOTO_NAME} TEXT,'
        '${DbConstants.COL_SITE_CREATED_BY} TEXT,'
        '${DbConstants.COL_SITE_COMMENT_CREATED_ON} INTEGER,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_COMMENT_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_ID} INTEGER,'
        '${DbConstants.COL_SITE_COMMENT_TEXT} TEXT,'
        '${DbConstants.COL_SITE_COMMENT_CREATOR_NAME} TEXT,'
        '${DbConstants.COL_SITE_COMMENT_CREATED_BY} TEXT,'
        '${DbConstants.COL_SITE_COMMENT_CREATED_ON} INTEGER,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_FLOOR_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_FLOOR_TXT} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_STAGE_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER ,'
        '${DbConstants.COL_SITE_STAGE_DESC} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );


  await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_STATUS_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER ,'
        '${DbConstants.COL_SITE_STATUS_DESC} TEXT,'
      '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_CONSTRUCTION_STAGE_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_CONSTRUCTION_STAGE_TEXT} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_PROBABILITY_WINNING_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_PROBABILITY_STATUS} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );


    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_COMPETITION_STATUS_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_COMPETITION_STATUS} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_Site_OPPORTUNITY_STATUS_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_OPPORTUNITY_STATUS} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_totalBalancePotential} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_floorId} INTEGER,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_stagePotential} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_brandId} INTEGER,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_brandPrice} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_constructionDate} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_siteId} INTEGER,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_supplyDate} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_supplyQty} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_stageStatus} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_CREATED_ON} INTEGER,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_CREATED_BY} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_soldToParty} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_shipToParty} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_soCode} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_isAuthorised} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_receiptNumber} TEXT,'
        '${DbConstants.COL_SITE_VISIT_HISTORY_isExpanded} BOOL,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_NEXT_STAGE_ENTITY} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_NEXT_STAGE_SITE_ID} INTEGER,'
        '${DbConstants.COL_SITE_NEXT_STAGE_construction_Id} INTEGER,'
        '${DbConstants.COL_SITE_NEXT_STAGE_Potential} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_brandId} INTEGER,'
        '${DbConstants.COL_SITE_NEXT_STAGE_brandPrice} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_stageStatus} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_constructionStartDt} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_SupplyDate} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_SupplyQty} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_createdBy} TEXT,'
        '${DbConstants.COL_SITE_NEXT_STAGE_createdOn} INTEGER,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_COUNTER_LIST_DEALERS} ('
        '${DbConstants.COL_ID} INTEGER ,'
        '${DbConstants.COL_COUNTER_LIST_soldToParty} TEXT,'
        '${DbConstants.COL_COUNTER_LIST_soldToPartyName} TEXT,'
        '${DbConstants.COL_COUNTER_LIST_shipToParty} TEXT,'
        '${DbConstants.COL_COUNTER_LIST_shipToPartyName} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_INFLUENCER} ('
        '${DbConstants.COL_ID} INTEGER,'
        '${DbConstants.COL_SITE_ID} INTEGER,'
        '${DbConstants.COL_SITE_INFLUENCER_ID} INTEGER,'
        '${DbConstants.COL_SITE_INFLUENCER_IS_DELETE} TEXT,'
        '${DbConstants.COL_SITE_INFLUENCER_CREATED_BY} TEXT,'
        '${DbConstants.COL_SITE_INFLUENCER_CREATED_ON} INTEGER,'
        '${DbConstants.COL_SITE_INFLUENCER_UPDATED_BY} TEXT,'
        '${DbConstants.COL_SITE_INFLUENCER_UPDATED_ON} INTEGER,'
        '${DbConstants.COL_SITE_INFLUENCER_UPDATED_IS_PRIMARY} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_INFLUENCER_TYPE} ('
        '${DbConstants.COL_SITE_INFLUENCER_TYPE_ID} INTEGER,'
        '${DbConstants.COL_SITE_INFLUENCER_TYPE_DESC} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );

    await db.execute('CREATE TABLE ${DbConstants.TABLE_SITE_INFLUENCER_CATEGORY} ('
        '${DbConstants.COL_SITE_INFLUENCER_CATE_ID} INTEGER,'
        '${DbConstants.COL_SITE_INFLUENCER_CATE_DESC} TEXT,'
        '${DbConstants.COL_SYNC_STATUS} BOOL)'
    );


  }

//function for upgrade database tables if database version change
  void _onUpgrade(Database db,int oldVersion,  int newVersion) async {
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_LIST}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_PHOTOS_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_COMMENT_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_DRAFT_LEAD}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_BRAND_NAME}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_COUNTER_LIST_DEALERS}");

    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_FLOOR_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_STAGE_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_CONSTRUCTION_STAGE_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_PROBABILITY_WINNING_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_COMPETITION_STATUS_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_Site_OPPORTUNITY_STATUS_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_VISIT_HISTORY_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_NEXT_STAGE_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_STATUS_ENTITY}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_INFLUENCER}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_INFLUENCER_TYPE}");
    db.execute("DROP TABLE IF EXISTS ${DbConstants.TABLE_SITE_INFLUENCER_CATEGORY}");

    _createDb(db,newVersion);
  }





  /*..........................................................................*/

/*Insert  Operation: Insert object to db*/
  Future<int> insertDataInTable(
      String tableName, Map<String, dynamic> mapData, ConflictAlgorithm conflictAlgorithm ) async {
    Database db = await this.database;
    var result = await db.insert(tableName, mapData, conflictAlgorithm: conflictAlgorithm);

    return result;
  }



  /*..........................................................................*/
/*Update Operation: Update Object and save it to db*/
  Future<int> updateTableRow(
      String tableName, Map<String, dynamic> mapData, where, whereArg) async {
    var db = await this.database;
    var result =
    await db.update(tableName, mapData, where: where, whereArgs: whereArg);
    return result;
  }

/*............................................................................*/
/*Get number of Note object in db*/
  Future<int> getCount(String table) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from '
        '$table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


/*............................................................................*/
/*Clear all data to table*/
  Future<int> clearDBTable(String tableName) async {
    var db = await this.database;
    int rowId = await db.delete(tableName);
    return rowId;

  }

  /*Clear all data to table*/
  Future<int> deleteRowTable(
      String tableName, String where, List<dynamic> whereArgs) async {
    var db = await this.database;
    int rowId = await db.delete(tableName, where: where, whereArgs: whereArgs);
    return rowId;
  }




/*............................................................................*/


  /*Fetch Operation: Get all game objects from database*/
  Future<List<Map<String, dynamic>>> fetchMapList(
      String tableName,
      List<String> columns,
      String where,
      List<dynamic> whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset) async {
    Database db = await this.database;
    var result = await db.query(tableName,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
    return result;
  }
}



