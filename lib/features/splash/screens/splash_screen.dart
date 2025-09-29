import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController()); // Initialize the controller

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/splash.svg'),
                  const SizedBox(height: 16),
                  Text(
                    'Theory test in my language',
                    style: AppTextStyles.figtreeStyle(weight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'I must write the real test will be in English\nlanguage and this app just helps you to\nunderstand the materials in your\nlanguage',
                    style: AppTextStyles.interStyle(
                      weight: FontWeight.w400,
                      color: const Color(0xFF636F85),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 64.0,
            left: 0,
            right: 0,
            child: Center(
              child: SpinKitCircle(
                color: Color(0xFF1B6EF7),
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}