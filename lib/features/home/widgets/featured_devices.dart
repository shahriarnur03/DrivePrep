import 'package:driveprep/common_widgets/device_card.dart';
import 'package:driveprep/common_widgets/empty_state.dart';
import 'package:driveprep/common_widgets/error_display.dart';
import 'package:driveprep/common_widgets/loading_indicator.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedDevicesSection extends StatelessWidget {
  final List<DeviceModel> devices;
  final bool isLoading;
  final String error;
  final VoidCallback onRetry;

  const FeaturedDevicesSection({
    super.key,
    required this.devices,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "See All" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Devices',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.DEVICES_LIST),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: Colors.blue.shade700),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Content based on state
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // Loading state
    if (isLoading) {
      return const LoadingIndicator(message: 'Loading featured devices...');
    }

    // Error state
    if (error.isNotEmpty) {
      return ErrorDisplay(
        errorMessage: error,
        onRetry: onRetry,
        retryButtonText: 'Reload',
      );
    }

    // Empty state
    if (devices.isEmpty) {
      return const EmptyState(
        icon: Icons.devices_rounded,
        title: 'No Featured Devices',
        subtitle: 'Check back later for featured devices',
        backgroundColor: Colors.grey,
        iconColor: Colors.grey,
      );
    }

    // Devices list
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        return DeviceCard(device: devices[index], showActions: false);
      },
    );
  }
}
