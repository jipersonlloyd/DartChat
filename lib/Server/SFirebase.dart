import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:full_stack_practice/Model/ChatModel.dart';
import 'package:http/http.dart' as http;

class SFirebase {
  static Future<void> sendMessageusingFirebase(ChatModel chatModel, String receiverToken) async {
    try {
      String url = 'https://fcm.googleapis.com/fcm/send';
      String serverToken =
          'AAAAI90fcdc:APA91bEQ6JIp9d-PWdlRnjwmlK5IdekKz_2Tqsf_5nv7uV5nW7Ogu76CsM0qhAyk05yL3hsP_u5Kagj9MO9BOvWPrhl4m6aMsuIDPhmoQ__xoca-rXPjAwWGYBnG_E4QVLrISTAUX8sN';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $serverToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "to": receiverToken,
            "notification": {
              "title": "Flutter App",
              "body": "${chatModel.senderID} has sent you a message"
            },
            "data": {
              "MESSAGE": "${chatModel.message}",
              "DATETIME": "${chatModel.dateTime}",
              "SENDERID": "${chatModel.senderID}",
              "receiverID": "${chatModel.receiverID}"
              }
          },
        ),
      );
    } catch (e) {
      debugPrint('Error in sending message using firebase');
    }
  }
}
