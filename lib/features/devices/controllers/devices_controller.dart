import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';

class DevicesController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<DeviceModel> devices = <DeviceModel>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllDevices();
  }

  Future<void> fetchAllDevices() async {
    try {
      isLoading.value = true;
      error.value = '';
      devices.value = await _apiService.getAllDevices();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDevice(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      final message = await _apiService.deleteDevice(id);
      devices.removeWhere((device) => device.id == id);
      Get.snackbar('Success', message);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Failed to delete device');
    } finally {
      isLoading.value = false;
    }
  }
}
