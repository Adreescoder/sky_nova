import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../daily__claim/view.dart';
import '../game_screen/view.dart';
import '../task_screen/view.dart';
import '../wallet/view.dart';
import 'logic.dart';

class HomeScreenPage extends StatelessWidget {
  HomeScreenPage({Key? key}) : super(key: key);

  final HomeScreenLogic logic = Get.put(HomeScreenLogic());

  @override
  Widget build(BuildContext context) {
    // List of screens for navigation
    final List<Widget> screens = [
      GameScreen(),
      TasksScreen(),
      DailyRewardScreen(),
      WalletPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: screens[logic.currentIndex.value],
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 3,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            elevation: 0,
            currentIndex: logic.currentIndex.value,
            onTap: (index) {
              logic.currentIndex.value = index; // Update selected index
            },
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.white70,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            iconSize: 30,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: 'Daily',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Wallet',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
