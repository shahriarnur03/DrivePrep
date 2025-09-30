import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/auth/controllers/verify_code_controller.dart';
import 'package:driveprep/features/auth/widgets/pin_code_textfield.dart';
import 'package:driveprep/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifyCodeController controller = Get.put(VerifyCodeController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),

              const SizedBox(height: 30),

              // Header
              Text(
                'Verify Code',
                style: AppTextStyles.interStyle(size: 24, weight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'Please enter the code we just sent to email pristia@gmail.com',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              PinCodeTextField(
                length: 4,
                onCompleted: (pin) {
                  Get.toNamed(Routes.RESET_PASSWORD);
                },
              ),

              const SizedBox(height: 40),

              Obx(() {
                if (controller.isTimerActive) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Resend code in ',
                        style: AppTextStyles.interStyle(
                          size: 14,
                          weight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        '00:${controller.remainingTime.toString().padLeft(2, '0')}',
                        style: AppTextStyles.interStyle(
                          size: 14,
                          weight: FontWeight.w700,
                          color: const Color(0xFF1B6EF7),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: TextButton(
                      onPressed: controller.resendCode,
                      child: Text(
                        'Resend code',
                        style: AppTextStyles.interStyle(
                          size: 16,
                          weight: FontWeight.w600,
                          color: const Color(0xFF1B6EF7),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
