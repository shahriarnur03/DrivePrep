import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/onboarding/controllers/onboarding_controller.dart';
import 'package:driveprep/features/onboarding/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find<OnboardingController>();

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.onboardingPages.length,
          itemBuilder: (context, index) {
            final OnboardingItem item = controller.onboardingPages[index];
            return OnboardingPageContent(item: item, controller: controller);
          },
        ),
      ),
    );
  }
}

class OnboardingPageContent extends StatelessWidget {
  final OnboardingItem item;
  final OnboardingController controller;

  const OnboardingPageContent({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          // height: 812,
          width: 375,
          child: Image.asset(item.imagePath),
        ),
        const SizedBox(height: 32),
        Text(
          item.title,
          style: AppTextStyles.figtreeStyle(size: 24, weight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          item.description,
          style: AppTextStyles.interStyle(
            size: 16,
            color: const Color(0xFF636F85),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.onboardingPages.length,
              (index) => buildDot(index, controller.currentPage.value),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              text:
                  controller.currentPage.value ==
                      controller.onboardingPages.length - 1
                  ? 'Get Started'
                  : 'Next',
              onPressed: () => controller.nextPage(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDot(int index, int currentPage) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFF1B6EF7)
            : const Color(0xFFCCE2FF),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
