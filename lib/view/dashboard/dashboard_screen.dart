import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/dashboard_controller.dart';
import 'package:my_grocery/view/account/account_screen.dart';
import 'package:my_grocery/view/category/category_screen.dart';
import 'package:my_grocery/view/home/home_screen.dart';
import 'package:my_grocery/view/product/product_screen.dart';

import '../../controller/category_controller.dart';
import '../../starting_pages/starting_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static CategoryController instance = Get.find<CategoryController>();
  @override
  void initState() {
    log('object');
    instance.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: IndexedStack(
            index: controller.tableIndex,
            children: const [
              HomeScreen(),
              ProductScreen(),
              CategoryScreen(),
              AccountScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 0.7))),
          child: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
            padding: const EdgeInsets.symmetric(vertical: 5),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            snakeViewColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            showUnselectedLabels: true,
            currentIndex: controller.tableIndex,
            onTap: (val) {
              controller.updateIndex(val);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu), label: 'Products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Account'),
            ],
          ),
        ),
      ),
    );
  }
}
