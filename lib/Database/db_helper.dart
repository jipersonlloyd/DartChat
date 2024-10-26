import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Database/tblChat.dart';
import 'package:full_stack_practice/Database/tblProducts.dart';
import 'package:full_stack_practice/Database/tblUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String databaseName = 'Full_Stack_Practice';
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    Database resDB = await openDatabase(
      path,
      version: 1,
      singleInstance: true,
      onCreate: _onCreate
    );

    return resDB;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await TblChat.create(db);
    await TblProducts.create(db);
    await TblUser.create(db);
  }

  static Future<bool> isTableExist(Database database, String tableName) async {
    try {
      bool result = false;
      String query = "SELECT name FROM sqlite_master WHERE type ='table'";
      List<Map> resultSet = await database.rawQuery(query);
      for (Map map in resultSet) {
        if (tableName == map['name']) {
          result = true;
          break;
        }
      }
      return result;
    } catch (e) {
      debugPrint('error in table exist: $e');
    }
    return false;
  }

  static Future<bool> isColumnExist(
      Database database, String tableName, String columnName) async {
    bool result = false;
    String query = "PRAGMA table_info($tableName)";
    List<Map> resultSet = await database.rawQuery(query);
    for (Map map in resultSet) {
      if (columnName == map['name']) {
        result = true;
        break;
      }
    }
    return result;
  }
}
