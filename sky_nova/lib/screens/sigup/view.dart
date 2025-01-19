import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:sky_nova/screens/login/view.dart';

import 'logic.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupLogic logic = Get.put(SignupLogic());
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/1122.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: logic.formKey,
                  child: Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: isSmallScreen
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildFormContent(isSmallScreen)
                                  .animate()
                                  .fadeIn()
                                  .slideX(
                                    begin: 1,
                                    end: 0,
                                    duration: 800.ms,
                                    curve: Curves.easeInOut,
                                  ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/logo.png",
                                  height: isSmallScreen ? 150 : 200,
                                  width: isSmallScreen ? 150 : 200,
                                ).animate().fadeIn().move(
                                      duration: GetNumUtils(1).seconds,
                                      begin: const Offset(-1, 0),
                                    ),
                                const SizedBox(width: 40),
                                SizedBox(
                                  width: 400,
                                  child: Column(
                                    children: _buildFormContent(isSmallScreen)
                                        .animate()
                                        .fadeIn(duration: 700.ms),
                                  ),
                                ),
                              ],
                            ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildFormContent(bool isSmallScreen) {
    return [
      GestureDetector(
        onTap: _handleImageUpload,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          child: logic.profileImage != null
              ? ClipOval(
                  child: Image.memory(
                    logic.profileImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.grey,
                ),
        ),
      ),
      const SizedBox(height: 20),
      _buildTextField(
        controller: logic.userNameController,
        label: "Name",
        icon: CupertinoIcons.person,
        validator: (value) => value?.isEmpty == true ? "Enter your name" : null,
      ),
      const SizedBox(height: 10),
      _buildTextField(
        controller: logic.emailController,
        label: "Email",
        icon: CupertinoIcons.mail,
        validator: (value) => value != null &&
                !RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+").hasMatch(value)
            ? "Enter a valid email"
            : null,
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: logic.passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.white),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(CupertinoIcons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? CupertinoIcons.eye_slash
                    : CupertinoIcons.eye,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) => value != null && value.length < 6
              ? "Password must be at least 6 characters"
              : null,
        ),
      ),
      const SizedBox(height: 20),
      logic.isLoading.value
          ? const CircularProgressIndicator()
          : SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () => logic.createUser(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
      const SizedBox(height: 20),
      TextButton(
        onPressed: () => Get.to(() => LoginPage()),
        child: const Text(
          "Already have an account? Log In",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  void _handleImageUpload() async {
    try {
      Uint8List? image;

      if (kIsWeb) {
        image = await ImagePickerWeb.getImageAsBytes();
      } else {
        // Add mobile-specific image picker logic here
      }

      if (image != null) {
        setState(() {
          logic.profileImage = image;
        });
      } else {
        Get.snackbar("Error", "No image selected.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
      ),
    );
  }
}
