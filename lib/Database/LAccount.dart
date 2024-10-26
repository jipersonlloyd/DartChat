import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Database/tblChat.dart';
import 'package:full_stack_practice/Database/tblUser.dart';
import 'package:full_stack_practice/Model/UserModel.dart';
import 'package:sqflite/sqflite.dart';

class LAccount{

  static Future<void> insertUserData(Database dbase, UserModel userModel) async {
    await dbase.insert(TblUser.table, UserModel.insertDataToLocal(userModel));
  }

  static Future<Map<String,dynamic>> checkUserData(Database dbase) async {
    Map<String,dynamic> result;
    try{
      UserModel? userModel;
      String query = "SELECT * FROM ${TblUser.table}";
      var res = await dbase.rawQuery(query);
      if(res.isNotEmpty){
        userModel = UserModel.getDataFromLocal(res.first);
        result = {
          'status': true,
          'value': userModel
        };
      }
      else{
        result = {
          'status': false,
          'value': null
        };
      }
    }
    catch(e){
      debugPrint('Error in checking User Data: $e');
      result = {
          'status': false,
          'value': null
        };
    }
    return result;
  }

  static Future<void> deleteUserData(Database dbase) async {
    await dbase.delete(TblUser.table);
  }

  static Future<void> insertToken(Database dbase, String token, String username) async {
    String query = "UPDATE ${TblUser.table} SET ${TblUser.token} = '$token' WHERE ${TblUser.username} = '$username'";
    debugPrint('queryToken: $query');
    await dbase.rawUpdate(query);
  }
}