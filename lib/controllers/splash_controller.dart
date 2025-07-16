import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _initializeApp();
  }

  void _initializeApp() async {
    try {
      // Add a small delay to show splash screen
      await Future.delayed(const Duration(seconds: 2));

      // For now, always go to login screen to avoid Firebase auth complications
      // This ensures the app doesn't get stuck on loading
      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      // If there's an error, go to login
      debugPrint('Splash initialization error: $e');
      Get.offNamed(Routes.LOGIN);
    }
  }
}
