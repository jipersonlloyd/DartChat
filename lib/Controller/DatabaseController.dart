import 'package:full_stack_practice/Database/db_helper.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends GetxController {
  
  Database? dbase;

  @override
  void onInit() async {
    super.onInit();
    dbase = await DatabaseHelper.database;
  }
}
