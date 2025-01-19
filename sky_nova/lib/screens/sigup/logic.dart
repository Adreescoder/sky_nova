import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  Uint8List? profileImage;

  // Create User
  Future<void> createUser() async {
    if (formKey.currentState?.validate() != true) return;

    isLoading.value = true;

    try {
      // Create user with Firebase Authentication
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (userCredential.user != null) {
        String userId = userCredential.user!.uid;

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('Sky').doc(userId).set({
          'name': userNameController.text,
          'email': emailController.text,
          'createdAt': DateTime.now(),
        });

        Get.snackbar(
          "Success",
          "Signup successful!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to HomeScreen or another screen
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Failed to sign up');
    } finally {
      isLoading.value = false;
    }
  }
}
