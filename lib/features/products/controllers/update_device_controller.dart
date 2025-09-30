import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driveprep/features/products/models/device_model.dart';
import 'package:driveprep/features/products/services/api_service.dart';
import 'package:driveprep/routes/app_pages.dart';

class UpdateDeviceController extends GetxController {
  final ApiService _apiService = ApiService();

  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();
  final yearController = TextEditingController();
  final cpuModelController = TextEditingController();
  final hardDiskSizeController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  RxString error = ''.obs;
  RxBool success = false.obs;
  RxString deviceId = ''.obs;

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
    colorController.dispose();
    priceController.dispose();
    capacityController.dispose();
    yearController.dispose();
    cpuModelController.dispose();
    hardDiskSizeController.dispose();
    super.onClose();
  }

  Future<void> fetchDeviceDetails(String id) async {
    try {
      isFetching.value = true;
      error.value = '';

      final device = await _apiService.getDeviceById(id);

      // Populate the form with device data
      nameController.text = device.name;

      if (device.data != null) {
        if (device.data!.color != null) {
          colorController.text = device.data!.color!;
        }

        if (device.data!.price != null) {
          priceController.text = device.data!.price.toString();
        }

        if (device.data!.capacity != null) {
          capacityController.text = device.data!.capacity.toString();
        }

        if (device.data!.year != null) {
          yearController.text = device.data!.year.toString();
        }

        if (device.data!.cpuModel != null) {
          cpuModelController.text = device.data!.cpuModel!;
        }

        if (device.data!.hardDiskSize != null) {
          hardDiskSizeController.text = device.data!.hardDiskSize!;
        }
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isFetching.value = false;
    }
  }

  Future<void> updateDevice() async {
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

      if (cpuModelController.text.isNotEmpty) {
        deviceData.cpuModel = cpuModelController.text;
      }

      if (hardDiskSizeController.text.isNotEmpty) {
        deviceData.hardDiskSize = hardDiskSizeController.text;
      }

      // Create the device model
      final device = DeviceModel(name: nameController.text, data: deviceData);

      // Send the API request
      final updatedDevice = await _apiService.updateDevice(
        deviceId.value,
        device,
      );

      success.value = true;

      Get.snackbar(
        'Success',
        'Device updated successfully',
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to update device: ${e.toString()}',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
