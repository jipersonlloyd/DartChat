// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:full_stack_practice/Constant.dart';
import 'package:full_stack_practice/Controller/ChatController.dart';
import 'package:full_stack_practice/View/ChatScreen.dart';
import 'package:get/get.dart';

class UsernamesAdapter extends StatelessWidget {
  UsernamesAdapter({super.key, this.userName});
  String? userName;
  ChatController chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        chatController.filterList(userName!);
        Navigator.pushNamed(context, ConstantRoutes.chatScreen, arguments: ChatScreenArgument(
          username: userName
        ));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const  [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(1, 1)
            )
          ],
        ),
        child: Center(
          child: Text(userName!),
        ),
      ),
    );
  }
}
