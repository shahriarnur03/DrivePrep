import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static const String _permissionKey = 'has_permanent_location_permission';

  /// Check if location screen should be shown during app startup
  static Future<bool> shouldShowLocationScreen() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if user has given permanent permission before
    bool hasPermanentPermission = prefs.getBool(_permissionKey) ?? false;

    if (hasPermanentPermission) {
      // Double check current permission status
      LocationPermission currentPermission = await Geolocator.checkPermission();

      // If permission is still granted (whileInUse or always), don't show screen
      if (currentPermission == LocationPermission.whileInUse ||
          currentPermission == LocationPermission.always) {
        return false;
      } else {
        // Permission was revoked, reset the flag
        await prefs.setBool(_permissionKey, false);
        return true;
      }
    }

    // No permanent permission granted before, show the screen
    return true;
  }

  /// Save permanent location permission status
  static Future<void> savePermanentPermissionStatus(bool hasPermission) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionKey, hasPermission);
  }

  /// Get current location permission status
  static Future<LocationPermission> getCurrentPermissionStatus() async {
    return await Geolocator.checkPermission();
  }

  /// Clear all location related preferences (useful for logout)
  static Future<void> clearLocationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_permissionKey);
  }
}
