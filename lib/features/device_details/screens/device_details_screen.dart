import 'package:driveprep/common_widgets/custom_app_bar.dart';
import 'package:driveprep/common_widgets/empty_state.dart';
import 'package:driveprep/common_widgets/error_display.dart';
import 'package:driveprep/common_widgets/loading_indicator.dart';
import 'package:driveprep/features/device_details/widgets/action_buttons.dart';
import 'package:driveprep/features/device_details/widgets/device_header.dart';
import 'package:driveprep/features/device_details/widgets/device_info_card.dart';
import 'package:driveprep/features/device_details/widgets/technical_specs_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/device_details/controllers/device_details_controller.dart';

class DeviceDetailsScreen extends StatelessWidget {
  final controller = Get.put(DeviceDetailsController());

  DeviceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const LoadingIndicator(message: 'Loading device details...');
        }

        // Error state
        if (controller.error.value.isNotEmpty) {
          return ErrorDisplay(
            errorMessage: controller.error.value,
            onRetry: () {
              final String? id = Get.arguments;
              if (id != null) {
                controller.fetchDeviceDetails(id);
              }
            },
          );
        }

        // Empty state
        final device = controller.device.value;
        if (device == null) {
          return const EmptyState(
            icon: Icons.devices_other_rounded,
            title: 'No Device Found',
            subtitle: 'The requested device could not be found',
          );
        }

        // Device found - show details
        return _buildDeviceDetailsView(device);
      }),
    );
  }

  Widget _buildDeviceDetailsView(device) {
    // Determine device icon based on name
    final String deviceName = device.name.toLowerCase();
    IconData deviceIcon;

    if (deviceName.contains('iphone') || deviceName.contains('apple')) {
      deviceIcon = Icons.phone_iphone_rounded;
    } else if (deviceName.contains('samsung') ||
        deviceName.contains('galaxy')) {
      deviceIcon = Icons.smartphone_rounded;
    } else if (deviceName.contains('pixel') || deviceName.contains('google')) {
      deviceIcon = Icons.phone_android_rounded;
    } else if (deviceName.contains('watch') || deviceName.contains('smart')) {
      deviceIcon = Icons.watch_rounded;
    } else {
      deviceIcon = Icons.devices_other_rounded;
    }

    return SafeArea(
      child: Column(
        children: [
          // App bar
          CustomAppBar(
            title: 'Device Details',
            subtitle: device.name,
            showBackButton: true,
            trailing: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Icon(deviceIcon, color: Colors.blue.shade700, size: 18),
            ),
          ),

          // Device details content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Device header with image/icon
                  DeviceHeader(deviceIcon: deviceIcon),

                  // Basic info card
                  DeviceInfoCard(device: device),

                  // Technical specs card (if applicable)
                  TechnicalSpecsCard(device: device),

                  // Action buttons
                  ActionButtons(deviceId: device.id ?? ''),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
