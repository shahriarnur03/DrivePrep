import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/onboarding/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPageContent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image
        SizedBox(width: 375, child: Image.asset(item.imagePath)),
        const SizedBox(height: 32),

        // Title
        Text(
          item.title,
          style: AppTextStyles.figtreeStyle(size: 24, weight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          item.description,
          style: AppTextStyles.interStyle(
            size: 16,
            color: const Color(0xFF636F85),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
