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
    user.value = _authService.user;
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
