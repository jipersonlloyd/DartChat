import 'package:flutter/widgets.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Controller/DatabaseController.dart';
import 'package:full_stack_practice/Database/LChat.dart';
import 'package:full_stack_practice/Model/ChatModel.dart';
import 'package:full_stack_practice/Server/SAccount.dart';
import 'package:full_stack_practice/Server/SChat.dart';
import 'package:full_stack_practice/Server/SFirebase.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  AccountController accountController = Get.find();
  DatabaseController controller = Get.find();
  List<ChatModel> chatLists = [];
  List<ChatModel> filterChatList = [];
  final ScrollController scrollController = ScrollController();

  set updatechatList(List<ChatModel> updateList) {
    chatLists = updateList;
    update();
  }

  void filterList(String username) {
    filterChatList = chatLists
        .where((element) =>
            element.receiverID == username || element.senderID == username)
        .toList();
    update();
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void getChatLists() async {
    Map<String, dynamic> res = await SChat.getChatbyUsername(
        accountController.userNameController.text);
    if (res['status']) {
      updatechatList = res['value'];
      for (var item in chatLists) {
        await LChat.insertChat(controller.dbase!, item);
      }
    }
  }

  void sendMessage(String receiverID) async {
    ChatModel chatModel = ChatModel(
        message: messageController.text,
        dateTime: DateTime.now().toString(),
        senderID: accountController.userModel!.username,
        receiverID: receiverID);

    Map<String, dynamic> res =
        await SAccount.getTokenFromDatabase(chatModel.receiverID!);
    if (res['status']) {
      chatLists.add(chatModel);
      updatechatList = chatLists;
      filterChatList.add(chatModel);
      messageController.clear();
      update();
      String receiverToken = res['message'];
      await SFirebase.sendMessageusingFirebase(chatModel, receiverToken);
      await SChat.insertChat(chatModel);
      await LChat.insertChat(controller.dbase!, chatModel);
    }
  }
}
