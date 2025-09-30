import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';

class DeviceDetailsController extends GetxController {
  final ApiService _apiService = ApiService();

  Rx<DeviceModel?> device = Rx<DeviceModel?>(null);
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final String? id = Get.arguments;
    if (id != null) {
      fetchDeviceDetails(id);
    } else {
      error.value = 'No device ID provided';
    }
  }

  Future<void> fetchDeviceDetails(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      device.value = await _apiService.getDeviceById(id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
