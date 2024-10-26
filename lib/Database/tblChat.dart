import 'package:full_stack_practice/Database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class TblChat{

  static const String table = 'tblChat';
  static const String uniqueID = 'ID';
  static const String message = 'MESSAGE';
  static const String dateTime = 'DATETIME';
  static const String senderID = 'SENDERID';
  static const String receiverID = 'receiverID';

  static Future<void> create(Database db) async {
    bool isExist = await DatabaseHelper.isTableExist(db, table);
    if (!isExist) {
      await db.execute(_createTblChat());
    }
  }

  static String _createTblChat() {
    return "CREATE TABLE $table ("
        "$uniqueID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$message                  TEXT,"
        "$dateTime                    TEXT,"
        "$senderID                   TEXT,"
        "$receiverID                   TEXT"
        ")";
  }
}