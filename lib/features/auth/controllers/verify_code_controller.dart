import 'dart:async';

import 'package:get/get.dart';

class VerifyCodeController extends GetxController {
  Timer? _timer;
  final _remainingTime = 10.obs;
  final _isTimerActive = false.obs;

  int get remainingTime => _remainingTime.value;
  bool get isTimerActive => _isTimerActive.value;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _isTimerActive.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        _timer?.cancel();
        _isTimerActive.value = false;
      }
    });
  }

  void resendCode() {
    _remainingTime.value = 10;
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
