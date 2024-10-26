// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:full_stack_practice/Constant.dart';
import 'package:full_stack_practice/Controller/ChatController.dart';
import 'package:full_stack_practice/Controller/DatabaseController.dart';
import 'package:full_stack_practice/Controller/ProductController.dart';
import 'package:full_stack_practice/Database/LAccount.dart';
import 'package:full_stack_practice/Database/LChat.dart';
import 'package:full_stack_practice/showDialog.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  ProductController productController = Get.find();
  DatabaseController dbaseController = Get.find();
  ChatController chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            reusableDialog(context, 'Log Out of your account?', () async {
              await LChat.deleteChat(dbaseController.dbase!);
              await LAccount.deleteUserData(dbaseController.dbase!)
                  .whenComplete(() {
                productController.productList.clear();
                chatController.chatLists.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, ConstantRoutes.loginScreen, (route) => false);
              });
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      offset: Offset(1, 0),
                      blurRadius: 1)
                ]),
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            height: 50,
            width: double.infinity,
            child: const Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Icon(Icons.logout),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Log Out'),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
