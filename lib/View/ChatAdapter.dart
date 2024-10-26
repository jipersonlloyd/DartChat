// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Model/ChatModel.dart';
import 'package:get/get.dart';

class ChatAdapter extends StatelessWidget {
  ChatAdapter({super.key, this.chatModel});
  ChatModel? chatModel;
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: accountController.userModel!.username! == chatModel?.senderID
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: 200,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: accountController.userModel!.username! == chatModel?.senderID
              ? Colors.blue
              : Colors.lightBlue[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(chatModel!.message!),
        ),
      ),
    );
  }
}
