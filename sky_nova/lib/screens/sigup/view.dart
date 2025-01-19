import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SignupScreen extends StatelessWidget {
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
                    // Profile Image Picker
                    GestureDetector(
                      onTap: () => logic.pickImage(),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: logic.profileImage != null
                            ? MemoryImage(logic.profileImage!)
                            : null,
                        child: logic.profileImage == null
                            ? const Icon(Icons.add_a_photo, size: 30)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Name Field
                    TextFormField(
                      controller: logic.userNameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
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
                        prefixIcon: Icon(Icons.email),
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
                      onPressed: () => Get.toNamed('/login'),
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
