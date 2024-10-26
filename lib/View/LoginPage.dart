// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_stack_practice/Constant.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Controller/ChatController.dart';
import 'package:full_stack_practice/Controller/ProductController.dart';
import 'package:full_stack_practice/Server/SAccount.dart';
import 'package:full_stack_practice/showDialog.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  AccountController controller = Get.find();
  ProductController productController = Get.find();
  ChatController chatController = Get.find();
  FocusNode focusNode = FocusNode();

  Future<void> btnLogin(BuildContext context) async {
    EasyLoading.show(status: 'Please wait');
    if (controller.userNameController.text.isEmpty ||
        controller.passwordController.text.isEmpty) {
      EasyLoading.dismiss();
      return reusableDialog(
          context, 'Input Username and Password', () => Navigator.pop(context));
    }
    await SAccount.loginAccount(controller.userNameController.text,
            controller.passwordController.text)
        .then(
      (value) async {
        if (value['status']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account Login Successfully!'),
            ),
          );
          await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            productController.insertProducts();
            controller.getUserData();
            chatController.getChatLists();
            Navigator.pushNamedAndRemoveUntil(
                context, ConstantRoutes.dashboardScreen, (route) => false);
          });
        } else {
          reusableDialog(context, 'Incorrect Username and Password',
              () => Navigator.pop(context));
        }
        EasyLoading.dismiss();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 20,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.network(
                      "https://images.vexels.com/media/users/3/185202/isolated/preview/04210f166dee214fc751791106b453b2-donut-pink-syrup-icon.png"),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            controller: controller.userNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            focusNode: focusNode,
                            obscureText: true,
                            controller: controller.passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                controller.clearCreateAccountPageTextFields();
                                Navigator.popAndPushNamed(context,
                                    ConstantRoutes.createAccountScreen);
                              },
                              child: const Text('Sign up'),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  width: 140,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                    onPressed: () async {
                      focusNode.unfocus();
                      await btnLogin(context);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
