import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BrandNameDBHelper extends ChangeNotifier{
  static final BrandNameDBHelper _instance = BrandNameDBHelper._();
  static Database? _database;

  BrandNameDBHelper._();

  factory BrandNameDBHelper() {
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
          await db.execute('CREATE TABLE draftLead (id INTEGER PRIMARY KEY AUTOINCREMENT, leadModel TEXT)');
          await db.execute('CREATE TABLE brandName (id INTEGER , brandName TEXT , productName TEXT)');
          await db.execute('CREATE TABLE counterListDealers (id TEXT, dealerName TEXT)');
        });
    return database;
  }


  Future<int> addBrandName(BrandModelforDB brandModelforDB) async {
    Database? client = await db;
    return client!.insert('brandName', brandModelforDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addDealer(DealerForDb dealerForDb) async {
    Database? client = await db;
    return client!.insert('counterListDealers', dealerForDb.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clearTable() async{
    Database? client = await (db);
    client!.delete("brandName");
    client.delete('counterListDealers');
  }



  Future<List<BrandModelforDB>> fetchAllDistinctBrand() async {
    Database? client = await db;
    var res = await client!.rawQuery('SELECT DISTINCT brandName FROM brandName');

    if (res.isNotEmpty) {
      var brandNames = res.map((leadMap) => BrandModelforDB.fromDb(leadMap)).toList();
      return brandNames;
    }
    return [];
  }

  Future<List<DealerForDb>> fetchAllDistinctDealers() async {
    Database? client = await db;
    var res = await client!.rawQuery('SELECT DISTINCT id,dealerName FROM counterListDealers');

    if (res.isNotEmpty) {
      var dealerNames = res.map((dealerMap) => DealerForDb.fromDb(dealerMap)).toList();
      return dealerNames;
    }
    return [];
  }

  Future<List<BrandModelforDB>> fetchAllDistinctProduct(String? brandName) async {
    Database? client = await db;
    var res = await client!.rawQuery('SELECT * FROM brandName WHERE brandName=?', [brandName]);

    if (res.isNotEmpty) {
      var productName = res.map((leadMap) => BrandModelforDB.fromDb(leadMap)).toList();
      print(productName.length);
      return productName;
    }
    return [];
  }



}

class BrandModelforDB {
   int? id;
   String? brandName;
   String? productName;


  BrandModelforDB(this.id, this.brandName,this.productName);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['brandName'] = brandName;
    map['productName'] = productName;
    return map;
  }

  BrandModelforDB.fromDb(Map<String, dynamic> map){
    this.id = map['id'];
    this.brandName = map['brandName'];
    this.productName = map['productName'];
  }
}


class DealerForDb{
   String? id;
   String? dealerName;
    DealerForDb(this.id, this.dealerName);


  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['dealerName'] = dealerName;
    return map;
  }

  DealerForDb.fromDb(Map<String, dynamic> map){
    this.id = map['id'];
    this.dealerName = map['dealerName'];
  }

}
