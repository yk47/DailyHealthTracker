import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final success = await _authService.signInWithGoogle();
      if (success) {
        Get.offNamed(Routes.DASHBOARD);
      } else {
        Get.snackbar(
          'Login Failed',
          'Failed to sign in with Google',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during login',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
