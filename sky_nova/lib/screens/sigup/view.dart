import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_nova/screens/login/view.dart';

import 'logic.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupLogic logic = Get.put(SignupLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: logic.formKey,
              child: Obx(() {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          if (kIsWeb) {
                            // Update UI after image selection
                          } else if (Platform.isAndroid || Platform.isIOS) {
                            Get.snackbar(
                                "Error", "Please Upload Image on Mobile");
                          }
                        } catch (e) {
                          Get.snackbar("Error", "Image picker failed: $e");
                        }
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .circle, // Use BoxShape.circle for better circle
                          border: Border.all(color: Colors.black),
                        ),
                        child: logic.profileImage != null
                            ? ClipOval(
                                // ClipOval to ensure circular image
                                child: Image.memory(logic.profileImage!),
                              )
                            : const Icon(CupertinoIcons.camera),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Name Field
                    TextFormField(
                      controller: logic.userNameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(CupertinoIcons.person),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter your name"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    // Email Field
                    TextFormField(
                      controller: logic.emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(CupertinoIcons.g),
                      ),
                      validator: (value) => value != null &&
                              !RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                          ? "Enter a valid email"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    // Password Field
                    TextFormField(
                      controller: logic.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) => value != null && value.length < 6
                          ? "Password must be at least 6 characters"
                          : null,
                    ),
                    const SizedBox(height: 20),
                    // Signup Button
                    logic.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () => logic.createUser(),
                            child: const Text("Sign Up"),
                          ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Get.to(() => LoginPage()),
                      child: const Text("Already have an account? Log In"),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
