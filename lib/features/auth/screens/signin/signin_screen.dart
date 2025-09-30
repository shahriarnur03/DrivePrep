import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/auth/controllers/signin_controller.dart';
import 'package:driveprep/features/auth/widgets/auth_textfield.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/logo.svg'),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Back!',
                      style: AppTextStyles.interStyle(
                        size: 32,
                        weight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please login first to start your Theory Test',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.interStyle(
                        size: 14,
                        weight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Email address',
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
                Text(
                  'Password',
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
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(-10, 0),
                          child: Obx(() => Checkbox(
                                value: controller.rememberMe.value,
                                activeColor: const Color(0xFF1B6EF7),
                                onChanged: (value) {
                                  controller.rememberMe.value = value!;
                                },
                              )),
                        ),
                        Transform.translate(
                          offset: const Offset(-17, 0),
                          child: Text(
                            'Remember me',
                            style: AppTextStyles.interStyle(
                              size: 14,
                              weight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                      child: Text(
                        'Forget password',
                        style: AppTextStyles.interStyle(
                          size: 14,
                          weight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                PrimaryButton(
                  text: 'Sign In',
                  onPressed: controller.signInAndNavigate,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to Theory Test? ',
                      style: AppTextStyles.interStyle(
                        size: 14,
                        weight: FontWeight.w400,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.SIGNUP),
                      child: Text(
                        'Create Account',
                        style: AppTextStyles.interStyle(
                          size: 14,
                          weight: FontWeight.w700,
                          color: const Color(0xFF1B6EF7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
