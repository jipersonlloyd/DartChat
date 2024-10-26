import 'package:full_stack_practice/Database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class TblProducts{

  static const String table = 'tblProducts';
  static const String id = 'id';
  static const String productName = 'PRODUCT_NAME';
  static const String price = 'PRICE';
  static const String stocks = 'STOCKS';
  static const String sold = 'SOLD';
  static const String image = 'IMAGE';

  static Future<void> create(Database db) async {
    bool isExist = await DatabaseHelper.isTableExist(db, table);
    if (!isExist) {
      await db.execute(_createTblProducts());
    }
  }

  static String _createTblProducts() {
    return "CREATE TABLE $table ("
        "$id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$productName                  TEXT,"
        "$price                   TEXT,"
        "$stocks                   TEXT,"
        "$sold                   TEXT,"
        "$image                   BLOB"
        ")";
  }
}