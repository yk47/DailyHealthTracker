import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final Rx<User?> user = Rx<User?>(null);
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _authService.user;
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed('/login');
  }
}
