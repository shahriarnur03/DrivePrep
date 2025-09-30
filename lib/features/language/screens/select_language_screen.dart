import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/language/controllers/language_controller.dart';
import 'package:driveprep/features/language/widgets/language_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController controller = Get.put(LanguageController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'What is Your Mother Language',
                style: AppTextStyles.interStyle(
                  size: 20,
                  weight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Discover what is a podcast description and podcast summary.',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w400,
                  color: const Color(0xFF636F85),
                ),
              ),
              // const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.languages.length,
                  itemBuilder: (context, index) {
                    final language = controller.languages[index];
                    return LanguageCard(
                      key: ValueKey(language.name), // Add a key
                      language: language,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Continue',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
