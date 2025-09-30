import 'package:get/get.dart';
import 'package:driveprep/features/devices/models/device_model.dart';
import 'package:driveprep/features/devices/services/api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();

  var selectedIndex = 0.obs;
  RxList<DeviceModel> featuredDevices = <DeviceModel>[].obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;

  // Location variables
  RxString currentLocation = ''.obs;
  RxBool isLoadingLocation = false.obs;

  // Featured device IDs
  final List<String> featuredDeviceIds = ['3', '5', '10'];

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedDevices();
    fetchCurrentLocation();
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

  // Fetch current location
  Future<void> fetchCurrentLocation() async {
    try {
      isLoadingLocation.value = true;

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Permission denied, don't show location
        currentLocation.value = '';
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        // Permission denied forever, don't show location
        currentLocation.value = '';
        return;
      }

      // Permission granted, get current position
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Get address from coordinates
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          if (placemarks.isNotEmpty) {
            Placemark place = placemarks[0];

            // Format location string
            String locationStr = '';
            if (place.locality != null && place.locality!.isNotEmpty) {
              locationStr = place.locality!;
            }
            if (place.country != null && place.country!.isNotEmpty) {
              if (locationStr.isNotEmpty) {
                locationStr += ', ${place.country}';
              } else {
                locationStr = place.country!;
              }
            }

            currentLocation.value = locationStr;
          }
        } catch (e) {
          // If geocoding fails, show coordinates
          currentLocation.value =
              '${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)}';
        }
      }
    } catch (e) {
      print('Error fetching location: ${e.toString()}');
      currentLocation.value = '';
    } finally {
      isLoadingLocation.value = false;
    }
  }
}
