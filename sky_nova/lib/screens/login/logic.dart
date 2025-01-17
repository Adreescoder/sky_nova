import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/view.dart';

class LoginLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs; // Track loading state

  // Improved validation functions
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // Login function
  Future<void> loginUser() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true; // Start loading

    try {
      // Sign in the user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null) {
        // Show success message
        Get.snackbar(
          "Success",
          "Login Successful!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
        );

        // Navigate to the HomePage after successful login
        Get.to(() => HomeScreenPage());
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      print("Firebase Auth error: ${e.message}");
      Get.snackbar('Error', 'Failed to log in: ${e.message}');
    } catch (e) {
      // Handle general errors
      print("Error: $e");
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    } finally {
      isLoading.value = false; // End loading
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
