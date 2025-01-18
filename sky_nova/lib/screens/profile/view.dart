import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final ProfileLogic logic = Get.put(ProfileLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: CircleAvatar(
                radius: 90,
                backgroundImage:
                    NetworkImage("https://via.placeholder.com/150"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
