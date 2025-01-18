import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chats/view.dart';
import '../profile/view.dart';
// ... other imports

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

class HomeScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // ... (rest of the class remains the same)
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // ... (DrawerHeader remains the same)

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              // Get.find<HomeScreenLogic>().changePage(2); // Removed
              Get.toNamed(
                  '/profile'); // Navigate to the profile page using named route
              // Alternatively, if you don't use named routes:
              // Get.to(ProfilePage());
            },
          ),
          // ... (rest of the ListTile remains the same)
        ],
      ),
    );
  }
}
