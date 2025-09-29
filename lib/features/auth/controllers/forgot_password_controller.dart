import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  void forgotPassword() {
    if (emailController.text.isEmpty || !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }
    // TODO: Implement actual forgot password logic
    Get.snackbar('Success', 'Verification code sent to your email');
    Get.toNamed(Routes.RESET_PASSWORD);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
