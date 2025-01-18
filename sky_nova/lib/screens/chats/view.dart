import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({Key? key}) : super(key: key);

  final ChatsLogic logic = Get.put(ChatsLogic());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
