import 'package:full_stack_practice/Database/tblChat.dart';

class ChatModel{

  int? id;
  String? message;
  String? dateTime;
  String? senderID;
  String? receiverID;

  ChatModel({
    this.id,
    this.message,
    this.dateTime,
    this.senderID,
    this.receiverID
  });

  static Map<String,dynamic> insertDatatoLocal(ChatModel chatModel){
    Map<String,dynamic> result = {
      TblChat.message: chatModel.message,
      TblChat.dateTime: chatModel.dateTime,
      TblChat.senderID: chatModel.senderID,
      TblChat.receiverID: chatModel.receiverID
    };
    return result;
  }

  static ChatModel getDatafromLocal(var json){
    ChatModel chatModel = ChatModel(
      message: json[TblChat.message],
      dateTime: json[TblChat.message],
      senderID: json[TblChat.senderID],
      receiverID: json[TblChat.receiverID]
    );
    return chatModel;
  }
}