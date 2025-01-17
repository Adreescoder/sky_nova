import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/view.dart';

class SignupLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
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
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Check if the username is available
  Future<bool> userNameAvailable(String username) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Sky')
        .where('name', isEqualTo: username)
        .get();
    return querySnapshot
        .docs.isEmpty; // Returns true if the username is available
  }

  // Create user on Firebase
  Future<void> createUserOnFirebase() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true; // Start loading

    try {
      // Check if username is available
      bool isAvailable = await userNameAvailable(userNameController.text);
      if (!isAvailable) {
        Get.snackbar('Error', 'Username already exists');
        return;
      }

      // *** INSECURE HASHING METHOD - ONLY FOR TESTING/NON-PRODUCTION USE!!! ***
      final insecureHash = _insecureHash(passwordController.text);

      // Create user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;
        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('Sky').doc(userId).set({
          'name': userNameController.text,
          'email': emailController.text,
          'insecureHash': insecureHash, // Store the insecure hash
          'createdAt': DateTime.now(),
        });

        // Show success message
        Get.snackbar(
          "Success",
          "Signup Successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
        );

        // Navigate to HomePage after successful signup
        Get.to(() => HomeScreenPage());
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      print("Firebase Auth error: ${e.message}");
      Get.snackbar('Error', 'Failed to create account: ${e.message}');
    } catch (e) {
      // Handle general errors
      print("Error: $e");
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    } finally {
      isLoading.value = false; // End loading
    }
  }

  // Insecure hash function (for demonstration purposes)
  String _insecureHash(String password) {
    return password.hashCode.toString(); // Weak hash (not for production)
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
