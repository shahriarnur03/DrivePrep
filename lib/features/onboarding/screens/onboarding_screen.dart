import 'package:driveprep/features/onboarding/controllers/onboarding_controller.dart';
import 'package:driveprep/features/onboarding/widgets/navigation_button.dart';
import 'package:driveprep/features/onboarding/widgets/onboarding_page_content.dart';
import 'package:driveprep/features/onboarding/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find<OnboardingController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // PageView for onboarding content
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageContent(
                    item: controller.onboardingPages[index],
                  );
                },
              ),
            ),

            // Page indicator dots
            Obx(
              () => PageIndicator(
                pageCount: controller.onboardingPages.length,
                currentPage: controller.currentPage.value,
              ),
            ),

            const SizedBox(height: 40),

            // Navigation button
            Obx(
              () => NavigationButton(
                isLastPage:
                    controller.currentPage.value ==
                    controller.onboardingPages.length - 1,
                onPressed: controller.nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
