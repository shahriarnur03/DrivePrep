import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Get.toNamed(Routes.SELECT_LANGUAGE);
    } else if (permission == LocationPermission.deniedForever) {
      // Show a dialog to open app settings
      Get.dialog(
        AlertDialog(
          title: const Text('Location Permission'),
          content: const Text(
              'Location permission is permanently denied. Please go to settings to enable it.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Get.back(),
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Geolocator.openAppSettings();
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/Maps.svg'),
            const SizedBox(height: 28),
            Text(
              'Enable Location',
              style: AppTextStyles.interStyle(size: 20, weight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              'Kindly allow us to access your location to\nprovide you with suggestions for nearby\nsalons',
              textAlign: TextAlign.center,
              style: AppTextStyles.interStyle(
                  weight: FontWeight.w400, color: const Color(0xFF636F85)),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              onPressed: _requestLocationPermission,
              text: 'Enable',
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => Get.toNamed(Routes.SELECT_LANGUAGE),
              child: Text(
                'Skip, Not Now',
                style: AppTextStyles.interStyle(
                    size: 16,
                    weight: FontWeight.w600,
                    color: const Color(0xFF2D2D2D)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
