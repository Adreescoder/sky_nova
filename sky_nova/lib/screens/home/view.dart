import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomeScreenPage extends StatelessWidget {
  HomeScreenPage({Key? key}) : super(key: key);

  final HomeScreenLogic logic = Get.put(HomeScreenLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sky nova".toUpperCase()),
      ),
      body: Text("Malik"),
    );
  }
}
