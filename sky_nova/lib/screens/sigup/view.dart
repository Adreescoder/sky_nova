import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/view.dart';
import 'logic.dart';

class SigupPage extends StatelessWidget {
  SigupPage({Key? key}) : super(key: key);

  final SignupLogic logic = Get.put(SignupLogic());

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
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/logo.png",
          width: isSmallScreen ? 200 : 300,
          height: isSmallScreen ? 200 : 300,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "welcome Sky Nova!".toUpperCase(),
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  final SignupLogic logic;
  const _FormContent({Key? key, required this.logic}) : super(key: key);

  @override
  State<_FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: widget.logic.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: widget.logic.userNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters long';
                }
                if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                  return 'Name can only contain letters and spaces';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your Name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.logic.emailController,
              validator: widget.logic.validateEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.logic.passwordController,
              obscureText: !_isPasswordVisible,
              validator: widget.logic.validatePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: widget.logic.createUserOnFirebase,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.to(() => LoginPage());
                // Implement the login redirection here if needed
              },
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
