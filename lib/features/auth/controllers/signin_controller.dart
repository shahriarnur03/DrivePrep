import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateEmail() {
    return GetUtils.isEmail(emailController.text.trim());
  }

  bool validatePassword() {
    return passwordController.text.length >= 8;
  }

  bool validateForm() {
    // Check if email is empty
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check if email is valid
    if (!validateEmail()) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check if password is empty
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    // Check if password is at least 8 characters
    if (!validatePassword()) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return false;
    }

    return true;
  }

  void signInAndNavigate() async {
    // First validate the form
    if (!validateForm()) {
      return;
    }

    try {
      isLoading.value = true;

      // Here you would have your actual sign-in logic.
      // For now, we just check permission and navigate.
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Add a small delay

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Get.offNamed(
          Routes.SELECT_LANGUAGE,
        ); // Use offNamed to not be able to go back to signin
      } else {
        Get.offNamed(Routes.LOCATION_ACCESS);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while signing in',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
