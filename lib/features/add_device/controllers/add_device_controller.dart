import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';

class AddDeviceController extends GetxController {
  final ApiService _apiService = ApiService();

  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();
  final yearController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxBool success = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    colorController.dispose();
    priceController.dispose();
    capacityController.dispose();
    yearController.dispose();
    super.onClose();
  }

  Future<void> addDevice() async {
    if (nameController.text.isEmpty) {
      error.value = 'Device name is required';
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';
      success.value = false;

      // Build the device data object
      final deviceData = DeviceData();

      if (colorController.text.isNotEmpty) {
        deviceData.color = colorController.text;
      }

      if (priceController.text.isNotEmpty) {
        deviceData.price = double.tryParse(priceController.text);
      }

      if (capacityController.text.isNotEmpty) {
        deviceData.capacity = capacityController.text;
      }

      if (yearController.text.isNotEmpty) {
        deviceData.year = int.tryParse(yearController.text);
      }

      // Create the device model
      final device = DeviceModel(name: nameController.text, data: deviceData);

      // Send the API request
      final newDevice = await _apiService.addDevice(device);

      // Clear the form on success
      nameController.clear();
      colorController.clear();
      priceController.clear();
      capacityController.clear();
      yearController.clear();

      success.value = true;

      Get.snackbar(
        'Success',
        'Device added successfully with ID: ${newDevice.id}',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to add device: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
