import 'package:driveprep/features/onboarding/models/onboarding_model.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<OnboardingItem> onboardingPages = [
    OnboardingItem(
      imagePath: 'assets/images/onboarding1.png',
      title: 'Best online courses\nin the world',
      description: 'Now you can learn anywhere, anytime, even if\nthere is no internet access!',
    ),
    OnboardingItem(
      imagePath: 'assets/images/onboarding2.png',
      title: 'Explore your new skill\ntoday',
      description: 'Our platform is designed to help you explore\nnew skills. Let’s learn & grow with Eduline!',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Get.offNamed(Routes.SIGNIN);
    }
  }
}