import 'package:driveprep/common_widgets/custom_app_bar.dart';
import 'package:driveprep/common_widgets/primary_button.dart';
import 'package:driveprep/features/add_device/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/add_device/controllers/add_device_controller.dart';

class AddDeviceScreen extends StatelessWidget {
  final controller = Get.put(AddDeviceController());

  AddDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Column(
            children: [
              // App bar
              CustomAppBar(title: 'Add New Device', showBackButton: true),

              // Form content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Error message
                      if (controller.error.value.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            controller.error.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      // Success message
                      if (controller.success.value)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 12),
                              Text(
                                'Device added successfully!',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Form title
                      Text(
                        'Device Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Form fields using reusable widget
                      CustomTextField(
                        controller: controller.nameController,
                        label: 'Device Name',
                        hint: 'Enter device name',
                        icon: Icons.devices_rounded,
                        required: true,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: controller.colorController,
                        label: 'Color',
                        hint: 'Enter device color',
                        icon: Icons.color_lens_rounded,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: controller.priceController,
                        label: 'Price',
                        hint: 'Enter device price',
                        icon: Icons.attach_money_rounded,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: controller.capacityController,
                        label: 'Capacity (GB)',
                        hint: 'Enter storage capacity',
                        icon: Icons.sd_storage_rounded,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: controller.yearController,
                        label: 'Year',
                        hint: 'Enter release year',
                        icon: Icons.calendar_today_rounded,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 40),

                      // Submit button using PrimaryButton
                      controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : PrimaryButton(
                              text: 'Add Device',
                              onPressed: controller.addDevice,
                            ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
