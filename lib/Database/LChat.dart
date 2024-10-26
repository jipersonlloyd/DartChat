import 'package:full_stack_practice/Database/tblChat.dart';
import 'package:full_stack_practice/Model/ChatModel.dart';
import 'package:sqflite/sqflite.dart';

class LChat{

  static Future<void> insertChat(Database dbase, ChatModel chatModel) async {
    await dbase.insert(TblChat.table, ChatModel.insertDatatoLocal(chatModel));
  }

  static Future<void> deleteChat(Database dbase) async {
    await dbase.delete(TblChat.table);
  }

  
}