import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/auth/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/auth/controllers/reset_password_controller.dart';
import 'package:driveprep/features/auth/widgets/password_reset_success_popup.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller = Get.put(ResetPasswordController());
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),

              const SizedBox(height: 30),

              // Header
              Text('Reset Password', style: AppTextStyles.interStyle(size: 24, weight: FontWeight.w700),),

              const SizedBox(height: 12),

              Text(
                'Your password must be at least 8 characters long and include a combination of letters, numbers',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),),

              const SizedBox(height: 30),

              // Email field
              Text(
                'New Password',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => AuthTextField(
                      controller: controller.passwordController,
                      isPassword: !controller.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),
              const SizedBox(height: 20),
              Text(
                'Confirm New Password',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => AuthTextField(
                      controller: controller.confirmPasswordController,
                      isPassword: !controller.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),

              const SizedBox(height: 40),

              PrimaryButton(
                text: 'Submit',
                onPressed: () {
                if (controller.resetPassword()) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PasswordResetSuccessPopup();
                    },
                  );
                }
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
