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
import 'package:driveprep/features/products/controllers/add_device_controller.dart';
import 'package:driveprep/features/products/controllers/dashboard_controller.dart';
import 'package:driveprep/features/products/controllers/device_details_controller.dart';
import 'package:driveprep/features/products/controllers/devices_list_controller.dart';
import 'package:driveprep/features/products/controllers/main_navigation_controller.dart';
import 'package:driveprep/features/products/controllers/partial_update_controller.dart';
import 'package:driveprep/features/products/controllers/update_device_controller.dart';
import 'package:driveprep/features/products/screens/add_device_screen.dart';
import 'package:driveprep/features/products/screens/dashboard_screen.dart';
import 'package:driveprep/features/products/screens/device_details_screen.dart';
import 'package:driveprep/features/products/screens/devices_list_screen.dart';
import 'package:driveprep/features/products/screens/main_navigation_screen.dart';
import 'package:driveprep/features/products/screens/partial_update_screen.dart';
import 'package:driveprep/features/products/screens/update_device_screen.dart';
import 'package:driveprep/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen()),
    GetPage(
      name: Routes.MAIN_NAVIGATION,
      page: () => MainNavigationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainNavigationController>(() => MainNavigationController());
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
      name: Routes.DASHBOARD,
      page: () => DashboardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
    ),
    GetPage(
      name: Routes.DEVICES_LIST,
      page: () => DevicesListScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DevicesListController>(() => DevicesListController());
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
