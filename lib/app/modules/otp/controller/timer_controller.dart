import 'package:get/get.dart';
import 'dart:async';

class TimerController extends GetxController {
  var timeRemaining = 60.obs;
  Timer? _timer;

  void startTimer() {
    timeRemaining.value = 60;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }
}
