import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_stack_practice/Constant.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Controller/ChatController.dart';
import 'package:full_stack_practice/Controller/DatabaseController.dart';
import 'package:full_stack_practice/Controller/ProductController.dart';
import 'package:full_stack_practice/Database/db_helper.dart';
import 'package:full_stack_practice/Firebase/firebase_api.dart';
import 'package:full_stack_practice/View/ChatScreen.dart';
import 'package:full_stack_practice/View/CreateAccountPage.dart';
import 'package:full_stack_practice/View/DashboardPage.dart';
import 'package:full_stack_practice/View/LoginPage.dart';
import 'package:full_stack_practice/firebase_options.dart';
import 'package:get/get.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.database;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await FirebaseAPI.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: ConstantRoutes.loginScreen,
        builder: EasyLoading.init(),
        routes: {
          ConstantRoutes.loginScreen: (context) => LoginPage(),
          ConstantRoutes.createAccountScreen: (context) => CreateAccountPage(),
          ConstantRoutes.dashboardScreen: (context) => DashboardPage(),
          ConstantRoutes.chatScreen:(context) => ChatScreen()
        });
  }
}
