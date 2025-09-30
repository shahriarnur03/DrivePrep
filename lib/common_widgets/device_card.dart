import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/routes/app_pages.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModel device;
  final Function()? onDelete;
  final bool showActions;

  const DeviceCard({
    super.key,
    required this.device,
    this.onDelete,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    // Determine device type and color based on name
    final String deviceName = device.name.toLowerCase();
    Color cardColor;
    IconData deviceIcon;

    if (deviceName.contains('iphone') || deviceName.contains('apple')) {
      cardColor = Colors.blue.shade50;
      deviceIcon = Icons.phone_iphone_rounded;
    } else if (deviceName.contains('samsung') ||
        deviceName.contains('galaxy')) {
      cardColor = Colors.green.shade50;
      deviceIcon = Icons.smartphone_rounded;
    } else if (deviceName.contains('pixel') || deviceName.contains('google')) {
      cardColor = Colors.purple.shade50;
      deviceIcon = Icons.phone_android_rounded;
    } else if (deviceName.contains('watch') || deviceName.contains('smart')) {
      cardColor = Colors.amber.shade50;
      deviceIcon = Icons.watch_rounded;
    } else {
      cardColor = Colors.grey.shade50;
      deviceIcon = Icons.devices_other_rounded;
    }

    // Extract price if available
    double? price;
    if (device.data?.price != null) {
      price = device.data!.price;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(Routes.DEVICE_DETAILS, arguments: device.id),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Device icon/image
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      deviceIcon,
                      size: 36,
                      color: cardColor == Colors.blue.shade50
                          ? Colors.blue.shade700
                          : cardColor == Colors.green.shade50
                          ? Colors.green.shade700
                          : cardColor == Colors.purple.shade50
                          ? Colors.purple.shade700
                          : cardColor == Colors.amber.shade50
                          ? Colors.amber.shade700
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Device info
                Expanded(
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
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (price != null)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '\$${price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
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
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (device.data?.year != null)
                            _buildFeaturePill(
                              icon: Icons.calendar_today_rounded,
                              text: '${device.data!.year}',
                              color: Colors.indigo.shade700,
                            ),
                          if (device.data?.capacity != null)
                            _buildFeaturePill(
                              icon: Icons.sd_storage_rounded,
                              text: '${device.data!.capacity} GB',
                              color: Colors.amber.shade700,
                            ),
                          if (device.data?.color != null)
                            _buildFeaturePill(
                              icon: Icons.color_lens_rounded,
                              text: device.data!.color!,
                              color: Colors.pink.shade700,
                            ),
                        ],
                      ),
                      if (showActions) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => Get.toNamed(
                                  Routes.UPDATE_DEVICE,
                                  arguments: device.id,
                                ),
                                icon: const Icon(Icons.edit_rounded, size: 16),
                                label: const Text('Edit'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.blue.shade700,
                                  side: BorderSide(color: Colors.blue.shade200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            if (onDelete != null) ...[
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: onDelete,
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    size: 16,
                                  ),
                                  label: const Text('Delete'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red.shade700,
                                    side: BorderSide(
                                      color: Colors.red.shade200,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
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
        ),
      ),
    );
  }

  Widget _buildFeaturePill({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
