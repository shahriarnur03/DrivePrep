import 'package:driveprep/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DevicesHeader extends StatelessWidget {
  final int deviceCount;

  const DevicesHeader({super.key, required this.deviceCount});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'All Devices',
      showBackButton: false,
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            Icon(Icons.devices_rounded, size: 18, color: Colors.blue.shade700),
            const SizedBox(width: 6),
            Text(
              '$deviceCount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
