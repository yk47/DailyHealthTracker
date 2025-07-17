import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class DashboardController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();

    // Initialize with current user
    user.value = _authService.user;

    // Listen to auth service user changes for real-time updates
    _authService.userStream.listen((User? newUser) {
      user.value = newUser;
      debugPrint(
        'Dashboard user updated: ${newUser?.name} (${newUser?.email})',
      );
    });

    loadDashboardData();
  }

  void loadDashboardData() async {
    isLoading.value = true;
    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  void refreshData() {
    loadDashboardData();
  }
}
