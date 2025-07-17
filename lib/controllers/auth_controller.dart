import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';
import '../utils/helpers.dart';

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
        AwesomeSnackBarHelper.showError(
          title: 'Login Failed',
          message: 'Failed to sign in with Google',
        );
      }
    } catch (e) {
      AwesomeSnackBarHelper.showError(
        title: 'Error',
        message: 'An error occurred during login',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();

      // Small delay to ensure snack bar is shown before navigation
      await Future.delayed(const Duration(milliseconds: 500));

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      AwesomeSnackBarHelper.showError(
        title: 'Sign Out Failed',
        message: 'Unable to sign out properly. Please try again.',
      );
    }
  }
}
