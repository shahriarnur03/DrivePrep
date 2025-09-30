import 'package:driveprep/features/products/models/device_model.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/products/controllers/device_details_controller.dart';

class DeviceDetailsScreen extends StatelessWidget {
  final controller = Get.put(DeviceDetailsController());

  DeviceDetailsScreen({super.key});

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

        final device = controller.device.value;
        if (device == null) {
          return _buildEmptyView();
        }

        return _buildDeviceDetailsView(device, context);
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
            'Loading device details...',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Go Back'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    final String? id = Get.arguments;
                    if (id != null) {
                      controller.fetchDeviceDetails(id);
                    } else {
                      Get.back();
                    }
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
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
              Icons.device_unknown_rounded,
              size: 60,
              color: Colors.amber.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Device Not Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The device information is not available',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('Go Back'),
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

  Widget _buildDeviceDetailsView(DeviceModel device, BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeviceHeader(device),
            _buildDeviceInfo(device),
            if (device.data != null) _buildDeviceSpecs(device.data!),
            _buildTimestampsSection(device),
            _buildActionButtons(device),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceHeader(DeviceModel device) {
    // Get a color based on the device name
    final List<Color> primaryColors = [
      Colors.blue.shade700,
      Colors.green.shade600,
      Colors.purple.shade700,
      Colors.amber.shade700,
      Colors.teal.shade700,
    ];

    final colorIndex = device.name.isEmpty
        ? 0
        : device.name.codeUnitAt(0) % primaryColors.length;
    final primaryColor = primaryColors[colorIndex];

    // Create gradient colors
    final gradientColors = [
      primaryColor,
      HSLColor.fromColor(primaryColor).withLightness(0.6).toColor(),
    ];

    return Stack(
      children: [
        // Background with gradient
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
          ),
        ),

        // Back button
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
          ),
        ),

        // Device icon and details
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                // Device icon
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _getDeviceIcon(device.name),
                      size: 40,
                      color: primaryColor,
                    ),
                  ),
                ),
                // Device name and ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        device.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (device.id != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          'ID: ${device.id}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getDeviceIcon(String deviceName) {
    final name = deviceName.toLowerCase();

    if (name.contains('iphone') ||
        name.contains('phone') ||
        name.contains('mobile')) {
      return Icons.smartphone_rounded;
    } else if (name.contains('macbook') || name.contains('laptop')) {
      return Icons.laptop_mac_rounded;
    } else if (name.contains('watch')) {
      return Icons.watch_rounded;
    } else if (name.contains('airpod') ||
        name.contains('headphone') ||
        name.contains('wireless')) {
      return Icons.headphones_rounded;
    } else if (name.contains('ipad') || name.contains('tablet')) {
      return Icons.tablet_mac_rounded;
    } else if (name.contains('tv') || name.contains('television')) {
      return Icons.tv_rounded;
    } else {
      return Icons.devices_other_rounded;
    }
  }

  Widget _buildDeviceInfo(DeviceModel device) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Device Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          if (device.data == null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: Colors.grey.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No additional data available for this device',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceSpecs(DeviceData data) {
    final Map<String, dynamic> dataMap = {};

    if (data.color != null) dataMap['Color'] = data.color;
    if (data.capacity != null) dataMap['Storage'] = data.capacity;
    if (data.price != null) dataMap['Price'] = '\$${data.price}';
    if (data.generation != null) dataMap['Generation'] = data.generation;
    if (data.year != null) dataMap['Year'] = data.year;
    if (data.cpuModel != null) dataMap['CPU'] = data.cpuModel;
    if (data.hardDiskSize != null) dataMap['Storage'] = data.hardDiskSize;
    if (data.strapColor != null) dataMap['Strap'] = data.strapColor;
    if (data.caseSize != null) dataMap['Case Size'] = data.caseSize;
    if (data.description != null) dataMap['Description'] = data.description;
    if (data.screenSize != null) dataMap['Screen'] = '${data.screenSize}"';

    if (dataMap.isEmpty) {
      return const SizedBox.shrink();
    }

    // Define sections to group related properties
    final Map<String, Map<String, IconData>> sections = {
      'Basic Information': {
        'Color': Icons.color_lens_outlined,
        'Strap': Icons.watch_outlined,
        'Case Size': Icons.straighten_outlined,
      },
      'Technical Specs': {
        'CPU': Icons.memory_outlined,
        'Storage': Icons.sd_storage_outlined,
        'Screen': Icons.screen_lock_landscape_outlined,
      },
      'Other Details': {
        'Price': Icons.attach_money_rounded,
        'Generation': Icons.new_releases_outlined,
        'Year': Icons.date_range_outlined,
        'Description': Icons.description_outlined,
      },
    };

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),

          // Build each section
          for (final section in sections.entries) ...[
            // Check if this section has any data
            if (section.value.keys.any((key) => dataMap.containsKey(key))) ...[
              Text(
                section.key,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 16),

              // Build spec items for this section
              ...section.value.entries
                  .where((entry) => dataMap.containsKey(entry.key))
                  .map((entry) {
                    final key = entry.key;
                    final value = dataMap[key];
                    final icon = entry.value;

                    return _buildSpecItem(key, value.toString(), icon);
                  }),

              const SizedBox(height: 24),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildSpecItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
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
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestampsSection(DeviceModel device) {
    if (device.createdAt == null && device.updatedAt == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Timestamps',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          if (device.createdAt != null)
            _buildTimeInfo(
              'Created',
              device.createdAt!,
              Icons.access_time_rounded,
            ),
          if (device.updatedAt != null) ...[
            if (device.createdAt != null) const SizedBox(height: 16),
            _buildTimeInfo(
              'Last Updated',
              device.updatedAt!,
              Icons.update_rounded,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String label, String timestamp, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.purple.shade700, size: 20),
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
              const SizedBox(height: 4),
              Text(
                timestamp,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(DeviceModel device) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Get.toNamed(Routes.UPDATE_DEVICE, arguments: device.id),
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Update'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Get.toNamed(Routes.PARTIAL_UPDATE, arguments: device.id),
                  icon: const Icon(Icons.mode_edit_outline_rounded),
                  label: const Text('Quick Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
