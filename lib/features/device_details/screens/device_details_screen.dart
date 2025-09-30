import 'package:driveprep/common_widgets/custom_app_bar.dart';
import 'package:driveprep/common_widgets/empty_state.dart';
import 'package:driveprep/common_widgets/error_display.dart';
import 'package:driveprep/common_widgets/loading_indicator.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/routes/app_pages.dart';
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
        if (controller.isLoading.value) {
          return const LoadingIndicator(message: 'Loading device details...');
        }

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

        final device = controller.device.value;
        if (device == null) {
          return const EmptyState(
            icon: Icons.devices_other_rounded,
            title: 'No Device Found',
            subtitle: 'The requested device could not be found',
          );
        }

        return _buildDeviceDetailsView(device, context);
      }),
    );
  }

  Widget _buildDeviceDetailsView(DeviceModel device, BuildContext context) {
    // Determine device type based on name for styling
    final String deviceName = device.name.toLowerCase();
    Color iconColor = Colors.blue.shade700;
    IconData deviceIcon;

    if (deviceName.contains('iphone') || deviceName.contains('apple')) {
      iconColor = Colors.blue.shade700;
      deviceIcon = Icons.phone_iphone_rounded;
    } else if (deviceName.contains('samsung') ||
        deviceName.contains('galaxy')) {
      iconColor = Colors.green.shade700;
      deviceIcon = Icons.smartphone_rounded;
    } else if (deviceName.contains('pixel') || deviceName.contains('google')) {
      iconColor = Colors.purple.shade700;
      deviceIcon = Icons.phone_android_rounded;
    } else if (deviceName.contains('watch') || deviceName.contains('smart')) {
      iconColor = Colors.amber.shade700;
      deviceIcon = Icons.watch_rounded;
    } else {
      iconColor = Colors.grey.shade700;
      deviceIcon = Icons.devices_other_rounded;
    }

    return SafeArea(
      child: Column(
        children: [
          // Custom app bar similar to devices screen
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
              child: Icon(deviceIcon, color: iconColor, size: 18),
            ),
          ),

          // Device details content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image section with gradient background
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue.shade500, Colors.blue.shade700],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        deviceIcon,
                        size: 80,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),

                  // Basic info card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                device.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (device.data?.price != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.blue.shade200,
                                  ),
                                ),
                                child: Text(
                                  '\$${device.data!.price!.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (device.data?.description != null)
                          Text(
                            device.data!.description!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'ID',
                          device.id ?? 'N/A',
                          Icons.fingerprint_rounded,
                        ),
                        if (device.data?.color != null)
                          _buildInfoRow(
                            'Color',
                            device.data!.color!,
                            Icons.color_lens_rounded,
                          ),
                        if (device.data?.capacity != null)
                          _buildInfoRow(
                            'Capacity',
                            '${device.data!.capacity} GB',
                            Icons.sd_storage_rounded,
                          ),
                        if (device.data?.year != null)
                          _buildInfoRow(
                            'Year',
                            '${device.data!.year}',
                            Icons.calendar_today_rounded,
                          ),
                        if (device.createdAt != null)
                          _buildInfoRow(
                            'Created',
                            _formatDate(device.createdAt!),
                            Icons.access_time_rounded,
                          ),
                        if (device.updatedAt != null)
                          _buildInfoRow(
                            'Updated',
                            _formatDate(device.updatedAt!),
                            Icons.update_rounded,
                          ),
                      ],
                    ),
                  ),

                  // Technical specs card
                  if (_hasAdvancedSpecs(device))
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.memory_rounded,
                                color: Colors.blue.shade700,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Technical Specifications',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          if (device.data?.cpuModel != null)
                            _buildInfoRow(
                              'CPU Model',
                              device.data!.cpuModel!,
                              Icons.developer_board_rounded,
                            ),
                          if (device.data?.hardDiskSize != null)
                            _buildInfoRow(
                              'Storage',
                              device.data!.hardDiskSize!,
                              Icons.storage_rounded,
                            ),
                          if (device.data?.screenSize != null)
                            _buildInfoRow(
                              'Screen Size',
                              '${device.data!.screenSize}',
                              Icons.aspect_ratio_rounded,
                            ),
                          if (device.data?.generation != null)
                            _buildInfoRow(
                              'Generation',
                              device.data!.generation!,
                              Icons.new_releases_rounded,
                            ),
                          if (device.data?.strapColor != null)
                            _buildInfoRow(
                              'Strap Color',
                              device.data!.strapColor!,
                              Icons.watch_rounded,
                            ),
                          if (device.data?.caseSize != null)
                            _buildInfoRow(
                              'Case Size',
                              device.data!.caseSize!,
                              Icons.straighten_rounded,
                            ),
                        ],
                      ),
                    ),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Get.toNamed(
                              Routes.UPDATE_DEVICE,
                              arguments: device.id,
                            ),
                            icon: const Icon(Icons.edit_rounded),
                            label: const Text('Edit Device'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Get.toNamed(
                              Routes.PARTIAL_UPDATE,
                              arguments: device.id,
                            ),
                            icon: const Icon(Icons.edit_attributes_rounded),
                            label: const Text('Partial Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue.shade700, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  bool _hasAdvancedSpecs(DeviceModel device) {
    final data = device.data;
    if (data == null) return false;

    return data.cpuModel != null ||
        data.hardDiskSize != null ||
        data.screenSize != null ||
        data.generation != null ||
        data.strapColor != null ||
        data.caseSize != null;
  }
}
