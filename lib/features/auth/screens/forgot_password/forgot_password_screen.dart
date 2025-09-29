import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/auth/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/auth/controllers/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.put(ForgotPasswordController());
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
              Text('Forgot Password', style: AppTextStyles.interStyle(size: 24, weight: FontWeight.w700),),

              const SizedBox(height: 12),

              Text(
                'Enter your email, we will send a verification code to email',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.grey.shade600,
                ),),

              const SizedBox(height: 30),

              // Email field
              Text(
                'Email Address',
                style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 10),
              AuthTextField(
                  controller: controller.emailController,
                ),

              const SizedBox(height: 40),

              PrimaryButton(
                text: 'Continue',
                onPressed: controller.forgotPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
