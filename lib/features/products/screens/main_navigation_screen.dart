import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/products/screens/dashboard_screen.dart';
import 'package:driveprep/features/products/screens/devices_list_screen.dart';
import 'package:driveprep/features/products/screens/add_device_screen.dart';
import 'package:driveprep/features/products/controllers/main_navigation_controller.dart';

class MainNavigationScreen extends StatelessWidget {
  final controller = Get.put(MainNavigationController());

  MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [DashboardScreen(), DevicesListScreen(), AddDeviceScreen()],
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTab,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue.shade700,
            unselectedItemColor: Colors.grey.shade500,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.devices_rounded),
                label: 'Devices',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_rounded),
                label: 'Add Device',
              ),
            ],
          ),
        );
      }),
      // Floating action button removed as requested
    );
  }
}
