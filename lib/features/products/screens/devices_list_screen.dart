import 'package:driveprep/features/products/models/device_model.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/products/controllers/devices_list_controller.dart';

class DevicesListScreen extends StatelessWidget {
  final controller = Get.put(DevicesListController());

  DevicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingView();
        }

        if (controller.error.value.isNotEmpty) {
          return _buildErrorView();
        }

        if (controller.devices.isEmpty) {
          return _buildEmptyView();
        }

        return _buildDevicesList();
      }),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              color: Colors.blue.shade700,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Loading devices...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 60,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              controller.error.value,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: controller.fetchAllDevices,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.devices_other_rounded,
              size: 60,
              color: Colors.amber.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No devices found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add a new device to get started',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed(Routes.ADD_DEVICE),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Device'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevicesList() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.devices.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final device = controller.devices[index];
                return _buildDeviceCard(device);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.devices_rounded,
                size: 28,
                color: Colors.blue.shade700,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Devices',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Obx(() {
                    final count = controller.devices.length;
                    return Text(
                      '$count ${count == 1 ? 'device' : 'devices'} available',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    );
                  }),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: controller.fetchAllDevices,
                icon: const Icon(Icons.refresh_rounded),
                tooltip: 'Refresh',
                color: Colors.blue.shade700,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search devices...',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(DeviceModel device) {
    // Get a color based on the first character of the device name
    final List<Color> colors = [
      Colors.blue.shade700,
      Colors.green.shade600,
      Colors.amber.shade700,
      Colors.purple.shade600,
      Colors.red.shade600,
      Colors.teal.shade600,
    ];

    final colorIndex = device.name.isEmpty
        ? 0
        : device.name.codeUnitAt(0) % colors.length;
    final color = colors[colorIndex];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.DEVICE_DETAILS, arguments: device.id),
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              // Header section with image and basic info
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Device image with gradient background
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color.withOpacity(0.2),
                            color.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        'assets/images/mobile.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Device details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Device name - allow more space
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              device.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Price and capacity row
                          Row(
                            children: [
                              if (device.data?.price != null) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.green.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        size: 14,
                                        color: Colors.green.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        device.data!.price!.toStringAsFixed(2),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],

                              if (device.data?.capacity != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${device.data?.capacity}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: color,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Additional specs row if available
                          if (device.data?.color != null ||
                              device.data?.year != null) ...[
                            Row(
                              children: [
                                if (device.data?.color != null) ...[
                                  Icon(
                                    Icons.palette_outlined,
                                    size: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    device.data!.color!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  if (device.data?.year != null) ...[
                                    const SizedBox(width: 16),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${device.data!.year}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ] else if (device.data?.year != null) ...[
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${device.data!.year}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.grey.shade200,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Action buttons section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Action buttons with better styling
                    Expanded(
                      child: _buildModernActionButton(
                        icon: Icons.visibility_outlined,
                        label: 'View',
                        color: Colors.blue.shade600,
                        onTap: () => Get.toNamed(
                          Routes.DEVICE_DETAILS,
                          arguments: device.id,
                        ),
                        isPrimary: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModernActionButton(
                        icon: Icons.edit_outlined,
                        label: 'Edit',
                        color: Colors.amber.shade600,
                        onTap: () => Get.toNamed(
                          Routes.UPDATE_DEVICE,
                          arguments: device.id,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildIconOnlyButton(
                      icon: Icons.delete_outline_rounded,
                      color: Colors.red.shade400,
                      onTap: () =>
                          _showDeleteConfirmation(Get.context!, device.id!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Material(
      color: isPrimary ? color : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            border: isPrimary
                ? null
                : Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: isPrimary ? Colors.white : color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconOnlyButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }

  Widget _buildSpecifications(DeviceModel device) {
    // Skip price as it's now shown in the tag
    final specs = <Widget>[];
    final specData = <Map<String, dynamic>>[];

    if (device.data?.color != null) {
      specData.add({
        'label': 'Color',
        'value': device.data?.color ?? '',
        'icon': Icons.color_lens_outlined,
        'color': Colors.blue.shade700,
      });
    }

    // Don't add price again since it's in the tag

    if (device.data?.capacity != null) {
      specData.add({
        'label': 'Capacity',
        'value': '${device.data?.capacity}',
        'icon': Icons.sd_storage_outlined,
        'color': Colors.amber.shade700,
      });
    }

    if (device.data?.generation != null) {
      specData.add({
        'label': 'Generation',
        'value': device.data?.generation ?? '',
        'icon': Icons.new_releases_outlined,
        'color': Colors.purple.shade600,
      });
    }

    if (device.data?.year != null) {
      specData.add({
        'label': 'Year',
        'value': device.data?.year.toString() ?? '',
        'icon': Icons.calendar_today_outlined,
        'color': Colors.orange.shade600,
      });
    }

    if (device.data?.cpuModel != null) {
      specData.add({
        'label': 'CPU',
        'value': device.data?.cpuModel ?? '',
        'icon': Icons.memory_outlined,
        'color': Colors.teal.shade600,
      });
    }

    // Create modern spec items
    for (final item in specData) {
      specs.add(
        _buildSpecItem(
          item['label'],
          item['value'],
          item['icon'],
          item['color'],
        ),
      );
    }

    if (specs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(spacing: 8, runSpacing: 8, children: specs);
  }

  Widget _buildSpecItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 12),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade400),
            const SizedBox(width: 12),
            const Text('Delete Device'),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete this device? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.grey.shade700),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              controller.deleteDevice(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
