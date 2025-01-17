import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginLogic logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: Obx(() {
          // Show CircularProgressIndicator when isLoading is true
          if (logic.isLoading.value) {
            return CircularProgressIndicator();
          }

          return isSmallScreen
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Logo(),
                      _FormContent(logic: logic),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    children: [
                      Expanded(child: _Logo()),
                      Expanded(child: _FormContent(logic: logic)),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.login,
          size: 100,
          color: Colors.blue,
        ),
        SizedBox(height: 20),
        Text(
          'Login',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class _FormContent extends StatelessWidget {
  final LoginLogic logic;

  _FormContent({required this.logic});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: logic.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: logic.emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: logic.validateEmail,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: logic.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: logic.validatePassword,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: logic.loginUser,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
