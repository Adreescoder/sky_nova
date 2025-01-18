import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_nova/screens/chats/view.dart';
import 'package:sky_nova/screens/home/view.dart';

import '../profile/view.dart';

class HomeScreenLogic extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreenPage(),
    ChatsPage(),
    ProfilePage(),
  ];

  Widget get currentPage => pages[selectedIndex.value];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
