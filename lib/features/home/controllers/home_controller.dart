import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  var selectedIndex = 0.obs;
  RxList<DeviceModel> featuredDevices = <DeviceModel>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Featured device IDs
  final List<String> featuredDeviceIds = ['3', '5', '10'];

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedDevices();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Fetch featured devices by IDs
  Future<void> fetchFeaturedDevices() async {
    try {
      isLoading.value = true;
      error.value = '';

      // Get devices by specific IDs
      featuredDevices.value = await _apiService.getDevicesByIds(
        featuredDeviceIds,
      );
    } catch (e) {
      error.value = e.toString();
      print('Error fetching featured devices: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
