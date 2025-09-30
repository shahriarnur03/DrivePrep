import 'package:driveprep/features/home/controllers/home_controller.dart';
import 'package:driveprep/features/home/widgets/featured_devices.dart';
import 'package:driveprep/features/home/widgets/home_header.dart';
import 'package:driveprep/features/home/widgets/logout_dialog.dart';
import 'package:driveprep/features/home/widgets/stats_section.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header section with search bar
          Obx(
            () => HomeHeader(
              onProfileTap: _showLogoutDialog,
              location: controller.currentLocation.value,
            ),
          ),

          // Stats section showing API operations
          const StatsSection(),

          // Featured devices section
          Expanded(
            child: Obx(
              () => FeaturedDevicesSection(
                devices: controller.featuredDevices,
                isLoading: controller.isLoading.value,
                error: controller.error.value,
                onRetry: controller.fetchFeaturedDevices,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show logout dialog when profile icon is clicked
  void _showLogoutDialog() {
    Get.dialog(LogoutDialog(onConfirm: () => Get.offAllNamed(Routes.SIGNIN)));
  }
}
