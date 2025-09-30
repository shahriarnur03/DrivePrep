import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signInAndNavigate() async {
    // Here you would have your actual sign-in logic.
    // For now, we just check permission and navigate.
    await Future.delayed(const Duration(milliseconds: 500)); // Add a small delay
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Get.offNamed(Routes.SELECT_LANGUAGE); // Use offNamed to not be able to go back to signin
    } else {
      Get.offNamed(Routes.LOCATION_ACCESS);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
