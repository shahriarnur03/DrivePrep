import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';
import 'package:driveprep/routes/app_pages.dart';

class PartialUpdateController extends GetxController {
  final ApiService _apiService = ApiService();

  final nameController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  RxString error = ''.obs;
  RxBool success = false.obs;
  RxString deviceId = ''.obs;
  Rx<DeviceModel?> device = Rx<DeviceModel?>(null);

  @override
  void onInit() {
    super.onInit();
    final dynamic args = Get.arguments;

    // Handle different types of arguments
    if (args != null) {
      String? id;
      if (args is String) {
        id = args;
      } else if (args is Map && args['id'] != null) {
        id = args['id'].toString();
      }

      if (id != null) {
        deviceId.value = id;
        fetchDeviceDetails(id);
        return;
      }
    }

    // If we reach here, we didn't get a valid device ID
    Future.delayed(Duration.zero, () {
      Get.snackbar(
        'Error',
        'Please select a device first',
        duration: const Duration(seconds: 3),
      );
      Get.offNamed(Routes.DEVICES_LIST);
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> fetchDeviceDetails(String id) async {
    try {
      isFetching.value = true;
      error.value = '';

      device.value = await _apiService.getDeviceById(id);
      nameController.text = device.value!.name;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isFetching.value = false;
    }
  }

  Future<void> updateDeviceName() async {
    if (nameController.text.isEmpty) {
      error.value = 'Device name is required';
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';
      success.value = false;

      // Create update payload with only the name
      final Map<String, dynamic> updates = {'name': nameController.text};

      // Send the API request
      final updatedDevice = await _apiService.partialUpdateDevice(
        deviceId.value,
        updates,
      );

      device.value = updatedDevice;
      success.value = true;

      Get.snackbar(
        'Success',
        'Device name updated successfully',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to update device name: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
