import 'package:driveprep/features/device_details/widgets/info_row.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:flutter/material.dart';

class DeviceInfoCard extends StatelessWidget {
  final DeviceModel device;

  const DeviceInfoCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    border: Border.all(color: Colors.blue.shade200),
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
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),
          InfoRow(
            label: 'ID',
            value: device.id ?? 'N/A',
            icon: Icons.fingerprint_rounded,
          ),
          if (device.data?.color != null)
            InfoRow(
              label: 'Color',
              value: device.data!.color!,
              icon: Icons.color_lens_rounded,
            ),
          if (device.data?.capacity != null)
            InfoRow(
              label: 'Capacity',
              value: '${device.data!.capacity} GB',
              icon: Icons.sd_storage_rounded,
            ),
          if (device.data?.year != null)
            InfoRow(
              label: 'Year',
              value: '${device.data!.year}',
              icon: Icons.calendar_today_rounded,
            ),
          if (device.createdAt != null)
            InfoRow(
              label: 'Created',
              value: _formatDate(device.createdAt!),
              icon: Icons.access_time_rounded,
            ),
          if (device.updatedAt != null)
            InfoRow(
              label: 'Updated',
              value: _formatDate(device.updatedAt!),
              icon: Icons.update_rounded,
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
}
