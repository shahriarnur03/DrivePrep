import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
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
              style: AppTextStyles.interStyle(weight: FontWeight.w400, color: const Color(0xFF636F85)),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              onPressed: _requestLocationPermission,
              text: 'Enable',
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: Text(
                'Skip, Not Now',
                style: AppTextStyles.interStyle(
                    size: 16,
                    weight: FontWeight.w600, color: const Color(0xFF2D2D2D)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
