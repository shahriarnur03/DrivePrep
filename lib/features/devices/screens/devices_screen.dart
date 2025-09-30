import 'package:driveprep/common_widgets/device_card.dart';
import 'package:driveprep/common_widgets/empty_state.dart';
import 'package:driveprep/common_widgets/error_display.dart';
import 'package:driveprep/common_widgets/loading_indicator.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/widgets/delete_dialog.dart';
import 'package:driveprep/features/devices/widgets/devices_header.dart';
import 'package:driveprep/features/devices/widgets/search_bar.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/devices/controllers/devices_controller.dart';

class DevicesScreen extends StatelessWidget {
  final controller = Get.put(DevicesController());

  DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const LoadingIndicator(message: 'Loading devices...');
        }

        // Error state
        if (controller.error.value.isNotEmpty) {
          return ErrorDisplay(
            errorMessage: controller.error.value,
            onRetry: controller.fetchAllDevices,
          );
        }

        // Empty state
        if (controller.devices.isEmpty) {
          return EmptyState(
            icon: Icons.devices_rounded,
            title: 'No devices found',
            subtitle: 'Add a new device to get started',
            buttonText: 'Add Device',
            onButtonPressed: () => Get.toNamed(Routes.ADD_DEVICE),
          );
        }

        // Content state - show devices list
        return _buildDevicesList();
      }),
    );
  }

  Widget _buildDevicesList() {
    return SafeArea(
      child: Column(
        children: [
          // Header with device count
          DevicesHeader(deviceCount: controller.devices.length),

          // Search bar
          const DeviceSearchBar(),

          // Devices list
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.fetchAllDevices,
              color: Colors.blue.shade700,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.devices.length,
                itemBuilder: (context, index) {
                  final device = controller.devices[index];
                  return DeviceCard(
                    device: device,
                    onDelete: () => _showDeleteConfirmation(device),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(DeviceModel device) {
    Get.dialog(
      DeleteDeviceDialog(
        deviceName: device.name,
        onConfirm: () => controller.deleteDevice(device.id!),
      ),
    );
  }
}
