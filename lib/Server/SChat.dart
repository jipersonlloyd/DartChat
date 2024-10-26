import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Model/ChatModel.dart';
import 'package:http/http.dart' as http;

class SChat {
  static Future<Map<String, dynamic>> getChatbyUsername(String username) async {
    Map<String, dynamic> result;
    List<ChatModel> chatLists = [];
    try {
      String url =
          "http://jipersonlloyd-001-site1.etempurl.com/api/Chat/getChats?username=$username";
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';
      final response = await http.get(Uri.parse(url), headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json'
      });

      var res = json.decode(response.body);
      var resMsg = res['Message'];
      if (response.statusCode == 200) {
        for (int i = 0; i < resMsg.length; i++) {
          ChatModel chatModel = ChatModel(
              message: resMsg[i]['message'],
              dateTime: resMsg[i]['datetime'],
              senderID: resMsg[i]['senderID'],
              receiverID: resMsg[i]['receiverID']);
          chatLists.add(chatModel);
        }
        result = {'status': true, 'value': chatLists};
      } else {
        result = {'status': false, 'value': null};
      }
    } catch (e) {
      debugPrint('Error in getting chat by username: $e');
      result = {'status': false, 'value': null};
    }
    return result;
  }

  static Future<Map<String, dynamic>> insertChat(ChatModel chatModel) async {
    Map<String, dynamic> result;
    try {
      String url =
          "http://jipersonlloyd-001-site1.etempurl.com/api/Chat/insertChat";
      String authUserName = '11161869';
      String authPassword = '60-dayfreetrial';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$authUserName:$authPassword'))}';

      final response = await http.post(Uri.parse(url),
          headers: {
            'authorization': basicAuth,
            'Content-Type': 'application/json'
          },
          body: json.encode({
            "message": chatModel.message,
            "datetime": chatModel.dateTime,
            "senderID": chatModel.senderID,
            "receiverID": chatModel.receiverID
          }));

      var res = json.decode(response.body);

      if (response.statusCode == 200) {
        result = {'status': res['Result'], 'message': res['Message']};
      } else {
        result = {'status': res['Result'], 'message': res['Message']};
      }
    } catch (e) {
      debugPrint('Error inserting Chat: $e');
      result = {'status': false, 'message': null};
    }
    return result;
  }
}
