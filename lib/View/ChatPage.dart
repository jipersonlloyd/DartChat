// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Server/SAccount.dart';
import 'package:full_stack_practice/View/UsernamesAdapter.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: SAccount.getUsernames(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> usernames = snapshot.data!['value'];
            usernames.removeWhere((element) => element == accountController.userModel?.username);
            if (snapshot.data!['status']) {
              return ListView.builder(
                itemCount: usernames.length,
                itemBuilder: (context, index) {
                  return UsernamesAdapter(
                    userName: usernames[index],
                  );
                },
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
