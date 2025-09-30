import 'package:flutter/material.dart';

class DeviceHeader extends StatelessWidget {
  final IconData deviceIcon;

  const DeviceHeader({super.key, required this.deviceIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Icon(deviceIcon, size: 80, color: Colors.white.withOpacity(0.9)),
      ),
    );
  }
}
