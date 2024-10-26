import 'package:full_stack_practice/Database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class TblUser{

  static const String table = 'tblUser';
  static const String uniqueID = 'ID';
  static const String username = 'USERNAME';
  static const String email = 'EMAIL';
  static const String phonenumber = 'PHONENUMBER';
  static const String dateRegistered = 'DATEREGISTERED';
  static const String token = 'TOKEN';

  static Future<void> create(Database db) async {
    bool isExist = await DatabaseHelper.isTableExist(db, table);
    if (!isExist) {
      await db.execute(_createTblUser());
    }
  }

  static String _createTblUser() {
    return "CREATE TABLE $table ("
        "$uniqueID INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$username                  TEXT,"
        "$email                    TEXT,"
        "$phonenumber                   TEXT,"
        "$dateRegistered                   TEXT,"
        "$token                  TEXT"
        ")";
  }
}