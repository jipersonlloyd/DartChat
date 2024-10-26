import 'package:flutter/material.dart';
import 'package:full_stack_practice/Controller/DatabaseController.dart';
import 'package:full_stack_practice/Database/LAccount.dart';
import 'package:full_stack_practice/Model/UserModel.dart';
import 'package:full_stack_practice/Server/SAccount.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  DatabaseController dbaseController = Get.find();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String token = '';
  UserModel? userModel;
  TextEditingController newUsername = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController newPhoneNumber = TextEditingController();

  void clearLoginPageTextFields() {
    userNameController.clear();
    passwordController.clear();
    update();
  }

  void getUserData() async {
    Map<String, dynamic> result =
        await LAccount.checkUserData(dbaseController.dbase!);
    if (result['status']) {
      userModel = result['value'];
    } else {
      var res = await SAccount.getUserData(userNameController.text);
      userModel = res['value'];
      await LAccount.insertUserData(dbaseController.dbase!, userModel!);
      userModel?.token = token;
      await LAccount.insertToken(
          dbaseController.dbase!, token, userModel!.username!);
      await SAccount.insertTokentoDatabase(token, userModel!.username!);
    }
  }

  // void token(){

  // }

  void clearCreateAccountPageTextFields() {
    newUsername.clear();
    newPassword.clear();
    newEmail.clear();
    newPhoneNumber.clear();
    update();
  }
}
