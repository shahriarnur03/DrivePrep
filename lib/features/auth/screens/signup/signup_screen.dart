import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/auth/controllers/signup_controller.dart';
import 'package:driveprep/features/auth/widgets/auth_textfield.dart';
import 'package:driveprep/common_widgets/primary_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Colors.white,
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
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),

              const SizedBox(height: 30),

              // Header
              Text('Welcome to Eduline', style: AppTextStyles.interStyle(size: 24, weight: FontWeight.w700),),

              const SizedBox(height: 12),

              Text(
                'Let\'s join to DrivePrep learning ecosystem & meet our professional mentor. It\'s Free!',
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

              const SizedBox(height: 16),

              Text('Full Name', style: AppTextStyles.interStyle(
                  size: 14,
                  weight: FontWeight.w500,
                  color: const Color(0xFF0F172A),
                ),),
              const SizedBox(height: 10),
              AuthTextField(
                  controller: controller.fullNameController,
              ),

              const SizedBox(height: 16),

              // Password field
              Text('Password', style: AppTextStyles.interStyle(
                    size: 14,
                    weight: FontWeight.w500,
                    color: const Color(0xFF0F172A),
                  ),),
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

              const SizedBox(height: 8),

              // Password strength indicator
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 327,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: controller.passwordStrength.value >= 1
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: controller.passwordStrength.value >= 2
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: controller.passwordStrength.value >= 3
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: controller.passwordStrength.value >= 4
                                    ? const Color(0xFF1B6EF7)
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.passwordStrength.value <= 1
                                ? 'Weak'
                              : controller.passwordStrength.value == 2
                                ? 'Medium'
                                : controller.passwordStrength.value == 3
                                ? 'Good'
                                : 'Strong',
                            style: TextStyle(
                              color: controller.passwordStrength.value <= 1
                                  ? Colors.red
                                  : controller.passwordStrength.value == 2
                                  ? Colors.orange
                                  : Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: controller.validatePassword()
                              ? Colors.green
                              : Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'At least 8 characters with a combination of letters and numbers',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.validatePassword()
                                  ? Colors.green
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Signup button
              PrimaryButton(
                text: 'Create Account',
                onPressed: controller.signup,
              ),

              const SizedBox(height: 10),

              // Already have an account link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed('/signin'),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF1B6EF7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
