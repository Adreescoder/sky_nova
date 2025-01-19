import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupLogic extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  Uint8List? profileImage;

  // Pick Image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = await pickedFile.readAsBytes();
      update(); // Notify GetX about state changes
    }
  }

  // Upload Image
  Future<String?> uploadImageToFirebase(String userId) async {
    if (profileImage == null) return null;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_profiles/$userId/profile.jpg');
      await storageRef.putData(profileImage!);
      return await storageRef.getDownloadURL();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return null;
    }
  }

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

        // Upload profile image and get URL
        String? imageUrl = await uploadImageToFirebase(userId);

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('Sky').doc(userId).set({
          'name': userNameController.text,
          'email': emailController.text,
          'profileImage': imageUrl,
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
