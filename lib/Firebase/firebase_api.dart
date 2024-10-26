import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Controller/ChatController.dart';
import 'package:full_stack_practice/Controller/DatabaseController.dart';
import 'package:full_stack_practice/Database/LChat.dart';
import 'package:full_stack_practice/Database/db_helper.dart';
import 'package:full_stack_practice/Model/Account.dart';
import 'package:full_stack_practice/Model/ChatModel.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class FirebaseAPI {
  static var androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High_importance_notification',
      description: 'Test', importance: Importance.defaultImportance);

  static var localnotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    Get.put(DatabaseController());
    AccountController accountController = Get.put(AccountController());
    Get.put(ChatController());
    accountController.token = fcmToken!;
    initPushNotification();
    initLocalNotification();
  }

  static void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    debugPrint('messagehandle');
  }

  static Future<void> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;
        String msgbody = message.notification!.body!;
        if (msgbody.contains('sent')) {
          debugPrint('Payload: ${message.data}');
          ChatModel chatModel = ChatModel(
              message: message.data['MESSAGE'],
              dateTime: message.data['DATETIME'],
              senderID: message.data['SENDERID'],
              receiverID: message.data['receiverID']);
          DatabaseController dbaseController = Get.find();
          ChatController chatController = Get.find();
          chatController.chatLists.add(chatModel);
          chatController.updatechatList = chatController.chatLists;
          chatController.filterChatList.add(chatModel);
          chatController.update();
          LChat.insertChat(dbaseController.dbase!, chatModel);
          Future.delayed(const Duration(seconds: 1));
          chatController.scrollToBottom();
        }
        localnotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
          payload: jsonEncode(
            message.toMap(),
          ),
        );
      },
    );
  }

  static Future<void> initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await localnotifications.initialize(
      settings,
      onSelectNotification: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload!));
        handleMessage(message);
      },
    );

    final platform = localnotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  try {
    Database dbase = await DatabaseHelper.database;
    Get.put(DatabaseController());
    Get.put(AccountController());
    ChatController chatController = Get.put(ChatController());
    String msgbody = message.notification!.body!;
    if (msgbody.contains('sent')) {
      debugPrint('Payload: ${message.data}');
      ChatModel chatModel = ChatModel(
          message: message.data['MESSAGE'],
          dateTime: message.data['DATETIME'],
          senderID: message.data['SENDERID'],
          receiverID: message.data['receiverID']);
          await LChat.insertChat(dbase, chatModel);
      chatController.chatLists.add(chatModel);
      chatController.updatechatList = chatController.chatLists;
      chatController.filterChatList.add(chatModel);
      chatController.update();
    }
  } catch (e) {
    debugPrint('Error handling background message: $e');
  }
}
