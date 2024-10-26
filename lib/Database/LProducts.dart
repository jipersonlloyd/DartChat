import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Database/tblProducts.dart';
import 'package:full_stack_practice/Model/ProductModel.dart';
import 'package:sqflite/sqflite.dart';

class LProducts {
  static Future<void> insertProducts(
      Database dbase, ProductModel productModel) async {
    await dbase.insert(
        TblProducts.table, ProductModel.insertDataToLocal(productModel));
  }

  static Future<void> deleteProducts(Database dbase) async {
    await dbase.delete(TblProducts.table);
  }

  static Future<Map<String, dynamic>> checkData(Database dbase) async {
    Map<String, dynamic> data;
    List<ProductModel> productList = [];
    try {
      String query = "SELECT * FROM ${TblProducts.table}";
      var res = await dbase.rawQuery(query);
      if (res.isNotEmpty) {
        for (var element in res) {
          productList.add(ProductModel.getDataFromLocal(element));
        }
        data = {'status': true, 'value': productList};
      }else{
        data = {'status': false, 'value': null};
      }
    } catch (e) {
      debugPrint('Error in checking Data: $e');
      data = {'status': false, 'value': null};
    }
    return data;
  }
}
