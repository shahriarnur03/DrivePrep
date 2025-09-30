
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';

class PasswordResetSuccessPopup extends StatelessWidget {
  const PasswordResetSuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric( vertical: 32),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/list.svg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Text(
              'Success',
              style: AppTextStyles.interStyle(
                size: 20,
                weight: FontWeight.w700,
                color: const Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your password is succesfully\ncreated',
              textAlign: TextAlign.center,
              style: AppTextStyles.interStyle(
                size: 14,
                weight: FontWeight.w400,
                color: const Color(0xFF636F85),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 182,
              child: PrimaryButton(
                text: 'Continue',
                onPressed: () => Get.toNamed('/signin'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
