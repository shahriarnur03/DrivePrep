import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  
  final isPasswordVisible = false.obs;
  final passwordStrength = 0.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void checkPasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength.value = 0;
      return;
    }
    
    // Simple password strength checker
    int strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;
    
    passwordStrength.value = strength;
  }

  bool validateEmail() {
    return GetUtils.isEmail(emailController.text.trim());
  }

  bool validateName() {
    return fullNameController.text.trim().isNotEmpty;
  }

  bool validatePassword() {
    return passwordController.text.length >= 8 &&
        passwordController.text.contains(RegExp(r'[A-Za-z]')) &&
        passwordController.text.contains(RegExp(r'[0-9]'));
  }

  bool signup() {
    if (!validateEmail()) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }
    
    if (!validateName()) {
      Get.snackbar('Error', 'Please enter your full name');
      return false;
    }
    
    if (!validatePassword()) {
      Get.snackbar('Error', 'Password must be at least 8 characters with letters and numbers');
      return false;
    }

    // TODO: Implement actual signup functionality with your backend
    
    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}