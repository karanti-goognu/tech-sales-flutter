import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class BrandNameDbConfig{
  static final db= DatabaseHelper();

  static Future<int> addBrandName(BrandModelforDB brandModelforDB) async {
    print(brandModelforDB.brandName);
    Database client = await db.database;
    return client.insert('brandName', brandModelforDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static  Future<int> addDealer(DealerForDb dealerForDb) async {
    print("ADDING: "+ dealerForDb.toMapForDb().toString());
    Database client = await db.database;
    return client.insert('counterListDealers', dealerForDb.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static  Future<void> clearTable() async{
    Database client = await db.database;
    client.delete("brandName");
    client.delete('counterListDealers');
  }



  static Future<List<BrandModelforDB>> fetchAllDistinctBrand() async {
    Database client = await db.database;
    var res = await client.rawQuery('SELECT DISTINCT brandName FROM brandName');

    if (res.isNotEmpty) {
      var brandNames = res.map((leadMap) => BrandModelforDB.fromDb(leadMap)).toList();
      print(brandNames.length);
      return brandNames;
    }
    return [];
  }

  static Future<List<DealerForDb>> fetchAllDistinctDealers() async {
    Database client = await db.database;
    var res = await client.rawQuery('SELECT DISTINCT id, soldToPartyName FROM counterListDealers');

    if (res.isNotEmpty) {
      var dealerNames = res.map((dealerMap) => DealerForDb.fromDb(dealerMap)).toList();
      print("res FROM DB   $res");
      return dealerNames;
    }
    return [];
  }

 static Future<List<BrandModelforDB>> fetchAllDistinctProduct(String brandName) async {
    Database client = await db.database;
    var res = await client.rawQuery('SELECT * FROM brandName WHERE brandName=?', [brandName]);

    if (res.isNotEmpty) {
      var productName = res.map((leadMap) => BrandModelforDB.fromDb(leadMap)).toList();
      print(productName.length);
      return productName;
    }
    return [];
  }
}

class BrandModelforDB {
  // @required
  final int id;
  @required
  final String brandName;
  final String productName;


  BrandModelforDB(this.id, this.brandName,this.productName);

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['brandName'] = brandName;
    map['productName'] = productName;
    return map;
  }

  BrandModelforDB.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        brandName = map['brandName'],
        productName = map['productName'];
}


class DealerForDb{
  String id;
  String dealerName;
  DealerForDb(this.id, this.dealerName);


  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['soldToParty'] = id;
    map['soldToPartyName'] = dealerName;
    return map;
  }

  DealerForDb.fromDb(Map<String, dynamic> map){
    this.id = map['soldToParty'];
    this.dealerName = map['soldToPartyName'];
  }

}