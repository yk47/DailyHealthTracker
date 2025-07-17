import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import '../utils/helpers.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final Rx<User?> user = Rx<User?>(null);
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize with current user
    user.value = _authService.user;

    // Listen to auth service user changes for real-time updates
    _authService.userStream.listen((User? newUser) {
      user.value = newUser;
      debugPrint('Profile updated: ${newUser?.name} (${newUser?.email})');
    });

    debugPrint('ProfileController initialized with user: ${user.value?.name}');
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();

      // Small delay to ensure snack bar is shown before navigation
      await Future.delayed(const Duration(milliseconds: 500));

      Get.offAllNamed('/login');
    } catch (e) {
      AwesomeSnackBarHelper.showError(
        title: 'Sign Out Failed',
        message: 'Unable to sign out properly. Please try again.',
      );
    }
  }
}
