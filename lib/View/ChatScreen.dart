// ignore_for_file: prefer_const_constructors_in_immutables, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Controller/ChatController.dart';
import 'package:full_stack_practice/Server/SChat.dart';
import 'package:full_stack_practice/View/ChatAdapter.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController controller = Get.put(ChatController());
  AccountController accountController = Get.find();

  @override
  Widget build(BuildContext context) {
    ChatScreenArgument args =
        ModalRoute.of(context)?.settings.arguments as ChatScreenArgument;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            args.username!,
            style: const TextStyle(fontSize: 13),
          ),
          backgroundColor: Colors.blue,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<ChatController>(
                  builder: (controller) => ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.filterChatList.length,
                    itemBuilder: (context, index) {
                      return ChatAdapter(
                        chatModel: controller.filterChatList[index],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    const Icon(Icons.add_circle_outline, size: 28),
                    const SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 0.5)),
                      height: 50,
                      width: 273,
                      child: Center(
                        child: TextField(
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        controller.sendMessage(args.username!);
                        await Future.delayed(const Duration(seconds: 1));
                        controller.scrollToBottom();
                      },
                      icon: const Icon(Icons.send),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreenArgument {
  String? username;

  ChatScreenArgument({this.username});
}
