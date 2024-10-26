// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:full_stack_practice/Controller/DashboardController.dart';
import 'package:full_stack_practice/Controller/ProductController.dart';
import 'package:full_stack_practice/View/HomePage.dart';
import 'package:full_stack_practice/View/ProfilePage.dart';
import 'package:full_stack_practice/View/ChatPage.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardController dashboardController = Get.put(DashboardController());
  ProductController productController = Get.find();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sample Dashboard Screen',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  productController.insertProducts();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Visibility(
              visible: _selectedIndex == 0,
              child: HomePage(),
            ),
            Visibility(
              visible: _selectedIndex == 1,
              child: ChatPage(),
            ),
            Visibility(
              visible: _selectedIndex == 2,
              child: ProfilePage(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
