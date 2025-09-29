import 'package:driveprep/features/auth/controllers/signup_controller.dart';
import 'package:driveprep/features/auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:driveprep/features/auth/screens/forgot_password/reset_password_screen.dart';
import 'package:driveprep/features/auth/screens/forgot_password/verify_code_screen.dart';
import 'package:driveprep/features/auth/screens/signin/signin_screen.dart';
import 'package:driveprep/features/auth/screens/signup/signup_screen.dart';
import 'package:driveprep/features/language/screens/select_language_screen.dart';
import 'package:driveprep/features/location/screens/location_access_screen.dart';
import 'package:driveprep/features/onboarding/screens/onboarding_screen.dart';
import 'package:driveprep/features/splash/screens/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: Routes.SIGNIN,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignupController>(() => SignupController());
      }),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.VERIFY_CODE,
      page: () => VerifyCodeScreen(),
    ),
    GetPage(
      name: Routes.LOCATION_ACCESS,
      page: () => LocationAccessScreen(),
    ),
    GetPage(
      name: Routes.SELECT_LANGUAGE,
      page: () => SelectLanguageScreen(),
    ),
  ];
}
