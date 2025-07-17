import 'dart:async';
import 'package:get/get.dart';
import '../utils/helpers.dart';

class TimerController extends GetxController {
  final RxInt remainingTime = 600.obs; // 10 minutes in seconds
  final RxBool isRunning = false.obs;
  final RxBool isPaused = false.obs;

  Timer? _timer;
  static const int initialTime = 600; // 10 minutes

  @override
  void onInit() {
    super.onInit();
    remainingTime.value = initialTime;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    if (isRunning.value) return;

    isRunning.value = true;
    isPaused.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _onTimerComplete();
      }
    });
  }

  void pauseTimer() {
    if (!isRunning.value) return;

    _timer?.cancel();
    isRunning.value = false;
    isPaused.value = true;
  }

  void resumeTimer() {
    if (isRunning.value || !isPaused.value) return;
    startTimer();
  }

  void resetTimer() {
    _timer?.cancel();
    isRunning.value = false;
    isPaused.value = false;
    remainingTime.value = initialTime;
  }

  void _onTimerComplete() {
    _timer?.cancel();
    isRunning.value = false;
    isPaused.value = false;

    AwesomeSnackBarHelper.showSuccess(
      title: 'Timer Complete!',
      message: 'Time for your next walk activity!',
      duration: const Duration(seconds: 3),
    );

    // Auto-reset after completion
    Future.delayed(const Duration(seconds: 2), () {
      resetTimer();
    });
  }

  String get formattedTime {
    final int minutes = remainingTime.value ~/ 60;
    final int seconds = remainingTime.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progress {
    return (initialTime - remainingTime.value) / initialTime;
  }
}
