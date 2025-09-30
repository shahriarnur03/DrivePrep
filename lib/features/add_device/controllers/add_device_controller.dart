import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';

class AddDeviceController extends GetxController {
  final ApiService _apiService = ApiService();

  // Text controllers for form fields
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();
  final yearController = TextEditingController();

  // State variables
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxBool success = false.obs;

  @override
  void onClose() {
    // Clean up controllers when the controller is closed
    nameController.dispose();
    colorController.dispose();
    priceController.dispose();
    capacityController.dispose();
    yearController.dispose();
    super.onClose();
  }

  // Add device method
  Future<void> addDevice() async {
    // Validate required fields
    if (nameController.text.isEmpty) {
      error.value = 'Device name is required';
      return;
    }

    try {
      isLoading.value = true;

      // Create device data
      final deviceData = DeviceData(
        color: colorController.text.isEmpty ? null : colorController.text,
        price: priceController.text.isEmpty
            ? null
            : double.tryParse(priceController.text),
        capacity: capacityController.text.isEmpty
            ? null
            : capacityController.text,
        year: yearController.text.isEmpty
            ? null
            : int.tryParse(yearController.text),
      );

      // Create device model
      final device = DeviceModel(name: nameController.text, data: deviceData);

      // Send API request
      await _apiService.addDevice(device);

      // Clear form
      _clearForm();

      // Show success message
      success.value = true;
      Get.snackbar(
        'Success',
        'Device added successfully',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to clear form
  void _clearForm() {
    nameController.clear();
    colorController.clear();
    priceController.clear();
    capacityController.clear();
    yearController.clear();
  }
}
