import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';

class SignupSuccessPopup extends StatelessWidget {
  const SignupSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close, size: 24, color: Color(0xFF7E8492)),
              ),
            ),
            Image.asset(
              width: 280,
              'assets/images/reg_success.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Text(
              'Successfully Registered',
              style: AppTextStyles.interStyle(
                size: 20,
                weight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your account has been registered\nsuccessfully, now let\'s enjoy our features!',
              textAlign: TextAlign.center,
              style: AppTextStyles.interStyle(
                size: 14,
                weight: FontWeight.w400,
                color: const Color(0xFF636F85),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Continue',
              onPressed: () => Get.toNamed('/signin'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
