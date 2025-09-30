import 'package:driveprep/features/device_details/widgets/info_row.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:flutter/material.dart';

class TechnicalSpecsCard extends StatelessWidget {
  final DeviceModel device;

  const TechnicalSpecsCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    // Don't show the card if there are no technical specs
    if (!_hasAdvancedSpecs(device)) {
      return const SizedBox.shrink();
    }

    return Container(
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
              Icon(Icons.memory_rounded, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              const Text(
                'Technical Specifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          if (device.data?.cpuModel != null)
            InfoRow(
              label: 'CPU Model',
              value: device.data!.cpuModel!,
              icon: Icons.developer_board_rounded,
            ),
          if (device.data?.hardDiskSize != null)
            InfoRow(
              label: 'Storage',
              value: device.data!.hardDiskSize!,
              icon: Icons.storage_rounded,
            ),
          if (device.data?.screenSize != null)
            InfoRow(
              label: 'Screen Size',
              value: '${device.data!.screenSize}',
              icon: Icons.aspect_ratio_rounded,
            ),
          if (device.data?.generation != null)
            InfoRow(
              label: 'Generation',
              value: device.data!.generation!,
              icon: Icons.new_releases_rounded,
            ),
          if (device.data?.strapColor != null)
            InfoRow(
              label: 'Strap Color',
              value: device.data!.strapColor!,
              icon: Icons.watch_rounded,
            ),
          if (device.data?.caseSize != null)
            InfoRow(
              label: 'Case Size',
              value: device.data!.caseSize!,
              icon: Icons.straighten_rounded,
            ),
        ],
      ),
    );
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
