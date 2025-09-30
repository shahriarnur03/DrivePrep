import 'package:driveprep/features/auth/controllers/signin_controller.dart';
import 'package:driveprep/features/auth/controllers/signup_controller.dart';
import 'package:driveprep/features/auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:driveprep/features/auth/screens/forgot_password/reset_password_screen.dart';
import 'package:driveprep/features/auth/screens/forgot_password/verify_code_screen.dart';
import 'package:driveprep/features/auth/screens/signin/signin_screen.dart';
import 'package:driveprep/features/auth/screens/signup/signup_screen.dart';
import 'package:driveprep/features/language/controllers/language_controller.dart';
import 'package:driveprep/features/language/screens/select_language_screen.dart';
import 'package:driveprep/features/location/screens/location_access_screen.dart';
import 'package:driveprep/features/onboarding/controllers/onboarding_controller.dart';
import 'package:driveprep/features/onboarding/screens/onboarding_screen.dart';
import 'package:driveprep/features/splash/screens/splash_screen.dart';

// Feature imports
import 'package:driveprep/features/bottom_navbar/controllers/bottom_navbar_controller.dart';
import 'package:driveprep/features/bottom_navbar/screens/bottom_navbar_screen.dart';
import 'package:driveprep/features/home/controllers/home_controller.dart';
import 'package:driveprep/features/home/screens/home_screen.dart';
import 'package:driveprep/features/devices/controllers/devices_controller.dart';
import 'package:driveprep/features/devices/screens/devices_screen.dart';
import 'package:driveprep/features/add_device/controllers/add_device_controller.dart';
import 'package:driveprep/features/add_device/screens/add_device_screen.dart';
import 'package:driveprep/features/device_details/controllers/device_details_controller.dart';
import 'package:driveprep/features/device_details/screens/device_details_screen.dart';
import 'package:driveprep/features/update_device/controllers/update_device_controller.dart';
import 'package:driveprep/features/update_device/screens/update_device_screen.dart';
import 'package:driveprep/features/partial_update/controllers/partial_update_controller.dart';
import 'package:driveprep/features/partial_update/screens/partial_update_screen.dart';

import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen()),
    GetPage(
      name: Routes.MAIN_NAVIGATION,
      page: () => BottomNavbarScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BottomNavbarController>(() => BottomNavbarController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.SIGNIN,
      page: () => SignInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInController>(() => SignInController());
      }),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignupController>(() => SignupController());
      }),
    ),
    GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPasswordScreen()),
    GetPage(name: Routes.RESET_PASSWORD, page: () => ResetPasswordScreen()),
    GetPage(name: Routes.VERIFY_CODE, page: () => VerifyCodeScreen()),
    GetPage(name: Routes.LOCATION_ACCESS, page: () => LocationAccessScreen()),
    GetPage(
      name: Routes.SELECT_LANGUAGE,
      page: () => SelectLanguageScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LanguageController>(() => LanguageController());
      }),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: Routes.DEVICES_LIST,
      page: () => DevicesScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DevicesController>(() => DevicesController());
      }),
    ),
    GetPage(
      name: Routes.DEVICE_DETAILS,
      page: () => DeviceDetailsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DeviceDetailsController>(() => DeviceDetailsController());
      }),
    ),
    GetPage(
      name: Routes.ADD_DEVICE,
      page: () => AddDeviceScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AddDeviceController>(() => AddDeviceController());
      }),
    ),
    GetPage(
      name: Routes.UPDATE_DEVICE,
      page: () => UpdateDeviceScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<UpdateDeviceController>(() => UpdateDeviceController());
      }),
    ),
    GetPage(
      name: Routes.PARTIAL_UPDATE,
      page: () => PartialUpdateScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PartialUpdateController>(() => PartialUpdateController());
      }),
    ),
  ];
}
