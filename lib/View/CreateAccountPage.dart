// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_stack_practice/Constant.dart';
import 'package:full_stack_practice/Controller/AccountController.dart';
import 'package:full_stack_practice/Server/SAccount.dart';
import 'package:full_stack_practice/showDialog.dart';
import 'package:get/get.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});
  AccountController controller = Get.find();

  Future<void> btnCreateAccount(BuildContext context) async {
    EasyLoading.show(status: 'Please wait');

    if(controller.newUsername.text.isEmpty || controller.newPassword.text.isEmpty || controller.newEmail.text.isEmpty || controller.newPhoneNumber.text.isEmpty){
      EasyLoading.dismiss();
      return reusableDialog(context, 'Fields are required', () => Navigator.pop(context));
    }

    await SAccount.createAccount(
      controller.newUsername.text,
      controller.newPassword.text,
      controller.newEmail.text, controller.newPhoneNumber.text).then((value) {
        EasyLoading.dismiss();
        if(value['status']){
          reusableDialog(context, value['message'], () {
            Navigator.popAndPushNamed(context, ConstantRoutes.loginScreen);
          });
          controller.clearLoginPageTextFields();
        }
        else{
          reusableDialog(context, value['message'], () => Navigator.pop(context));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
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
                              controller: controller.newUsername,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'UserName',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            width: double.infinity,
                            child: TextField(
                              controller: controller.newEmail,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            width: double.infinity,
                            child: TextField(
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              controller: controller.newPhoneNumber,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'PhoneNumber',
                                counterText: ''
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            height: 50,
                            width: double.infinity,
                            child: TextField(
                              controller: controller.newPassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  controller.clearLoginPageTextFields();
                                  Navigator.popAndPushNamed(context, ConstantRoutes.loginScreen);
                                },
                                child: const Text('Sign in'),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      height: 50,
                      width: 140,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue)),
                        onPressed: () async {
                          await btnCreateAccount(context);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
