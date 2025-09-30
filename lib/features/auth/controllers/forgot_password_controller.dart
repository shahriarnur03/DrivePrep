import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  void forgotPassword() {
    // Add forgot password logic here
    Get.toNamed(Routes.VERIFY_CODE);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}