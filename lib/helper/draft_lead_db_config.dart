import 'package:flutter_tech_sales/utils/constants/db_constants.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'draftLeadDBHelper.dart';

class DraftLeadDbConfig{
static final db= DatabaseHelper();
  static Future<int> addLeadInDraft(DraftLeadModelforDB draftLeadModelforDB) async {

    // var client = await db;
    // print(draftLeadModelforDB.leadModel);
    // return client.insert('draftLead', draftLeadModelforDB.toMapForDb(),
    //     conflictAlgorithm: ConflictAlgorithm.replace);
    return db.insertDataInTable(DbConstants.TABLE_DRAFT_LEAD, draftLeadModelforDB.toMapForDb(), ConflictAlgorithm.replace);


  }

static Future<DraftLeadModelforDB> fetchLeadInDraft(int id) async {
   // var client = await db;
    Database client = await db.database;

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

 static Future<int> updateLeadInDraft(DraftLeadModelforDB draftLeadModelforDB) async {
    print(draftLeadModelforDB.id);
    //var client = await db;
    Database client = await db.database;

    return client.update('draftLead', draftLeadModelforDB.toMapForDb(),
        where: 'id = ?',
        whereArgs: [draftLeadModelforDB.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

static Future<void> removeLeadInDraft(int id) async {
    print('Draft id $id');
   // var client = await db;
    Database client = await db.database;

    return client.delete('draftLead', where: 'id = ?', whereArgs: [id]);
  }

static Future<List<DraftLeadModelforDB>> fetchAll() async {
    //var client = await db;
    Database client = await db.database;
    var res = await client.query('draftLead');

    if (res.isNotEmpty) {
      var draftLeads = res.map((leadMap) => DraftLeadModelforDB.fromDb(leadMap)).toList();
      return draftLeads;
    }
    return [];
  }

}