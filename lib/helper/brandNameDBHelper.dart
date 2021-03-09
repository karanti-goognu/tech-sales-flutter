import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BrandNameDBHelper extends ChangeNotifier{
  static final BrandNameDBHelper _instance = BrandNameDBHelper._();
  static Database _database;

  BrandNameDBHelper._();

  factory BrandNameDBHelper() {
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
          await db.execute('CREATE TABLE draftLead (id INTEGER PRIMARY KEY AUTOINCREMENT, leadModel TEXT)');
          await db.execute('CREATE TABLE brandName (id INTEGER , brandName TEXT , productName TEXT)');
          await db.execute('CREATE TABLE counterListDealers (id TEXT, dealerName TEXT)');
        });
    return database;
  }


  Future<int> addBrandName(BrandModelforDB brandModelforDB) async {
    print(brandModelforDB.brandName);
    var client = await db;
    return client.insert('brandName', brandModelforDB.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addDealer(DealerForDb dealerForDb) async {
    print("ADDING: "+ dealerForDb.toMapForDb().toString());
    var client = await db;
    return client.insert('counterListDealers', dealerForDb.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> clearTable() async{
    var client = await db;
    client.delete("brandName");
    client.delete('counterListDealers');
  }


  // Future<DraftLeadModelforDB> fetchLeadInDraft(int id) async {
  //   var client = await db;
  //   final Future<List<Map<String, dynamic>>> futureMaps =
  //   client.query('draftLead', where: 'id = ?', whereArgs: [id]);
  //   var maps = await futureMaps;
  //   if (maps.length != 0) {
  //     return DraftLeadModelforDB.fromDb(maps.first);
  //   }
  //   return null;
  // }
  //
  // Future<int> updateLeadInDraft(DraftLeadModelforDB draftLeadModelforDB) async {
  //   print(draftLeadModelforDB.id);
  //   var client = await db;
  //   return client.update('draftLead', draftLeadModelforDB.toMapForDb(),
  //       where: 'id = ?',
  //       whereArgs: [draftLeadModelforDB.id],
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }
  //
  // Future<void> removeLeadInDraft(int id) async {
  //   var client = await db;
  //   return client.delete('draftLead', where: 'id = ?', whereArgs: [id]);
  // }
  //

  Future<List<BrandModelforDB>> fetchAllDistinctBrand() async {
    var client = await db;
    var res = await client.rawQuery('SELECT DISTINCT brandName FROM brandName');

    if (res.isNotEmpty) {
      var brandNames = res.map((leadMap) => BrandModelforDB.fromDb(leadMap)).toList();
      print(brandNames.length);
      return brandNames;
    }
    return [];
  }

  Future<List<DealerForDb>> fetchAllDistinctDealers() async {
    var client = await db;
    var res = await client.rawQuery('SELECT DISTINCT id,dealerName FROM counterListDealers');

    if (res.isNotEmpty) {
      var dealerNames = res.map((dealerMap) => DealerForDb.fromDb(dealerMap)).toList();
      print("res FROM DB   $res");
      return dealerNames;
    }
    return [];
  }

  Future<List<BrandModelforDB>> fetchAllDistinctProduct(String brandName) async {
    var client = await db;
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
    map['id'] = id;
    map['dealerName'] = dealerName;
    return map;
  }

  DealerForDb.fromDb(Map<String, dynamic> map){
    this.id = map['id'];
    this.dealerName = map['dealerName'];
  }

}
