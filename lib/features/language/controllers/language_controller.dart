import 'package:driveprep/features/language/models/language_model.dart';
import 'package:driveprep/routes/app_pages.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLanguage = Rx<Language?>(null);

  final List<Language> languages = [
    Language(name: 'English (US)', flagPath: 'assets/images/US.png'),
    Language(name: 'Indonesia', flagPath: 'assets/images/Indonesia.png'),
    Language(name: 'Afghanistan', flagPath: 'assets/images/Afghanistan.png'),
    Language(name: 'Algeria', flagPath: 'assets/images/Algeria.png'),
    Language(name: 'Malaysia', flagPath: 'assets/images/Malaysia.png'),
    Language(name: 'Arabic', flagPath: 'assets/images/AE.png'),
  ];

  void selectLanguage(Language language) {
    selectedLanguage.value = language;
  }

  void navigateToDashboard() {
    if (selectedLanguage.value != null) {
      Get.offAllNamed(Routes.MAIN_NAVIGATION);
    }
  }
}
