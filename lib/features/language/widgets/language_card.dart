import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/language/controllers/language_controller.dart';
import 'package:driveprep/features/language/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageCard extends StatelessWidget {
  final Language language;

  const LanguageCard({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final LanguageController controller = Get.find<LanguageController>();

    return Obx(() {
      final isSelected = controller.selectedLanguage.value == language;
      return GestureDetector(
        onTap: () => controller.selectLanguage(language),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.76),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 68.8,
                      spreadRadius: 0,
                      offset: const Offset(0, 40.133),
                    ),
                  ],
                )
              : BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(13.76),
                ),
          child: Row(
            children: [
              Image.asset(language.flagPath, width: 40, height: 40),
              const SizedBox(width: 16),
              Text(
                language.name,
                style: AppTextStyles.interStyle(size: 16, weight: FontWeight.w500),
              ),
              const Spacer(),
              if (isSelected)
                Container(
                  width: 104,
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 1.3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B6EF7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          'Selected',
                          style: AppTextStyles.interStyle(
                            size: 12,
                            weight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                OutlinedButton(
                  onPressed: () => controller.selectLanguage(language),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(76, 36),
                    backgroundColor: const Color(0xFFF6F6F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Color(0xFFEBEBEB)),
                  ),
                  child: Text(
                    'Select',
                    style: AppTextStyles.interStyle(
                      size: 12,
                      weight: FontWeight.w500,
                      color: const Color(0xFFAEAEB2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
