import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthService _authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    // Allow splash route to proceed normally
    if (route == Routes.SPLASH) {
      return null;
    }

    // If user is already logged in and trying to access login page,
    // redirect to dashboard
    if (route == Routes.LOGIN && _authService.isLoggedIn) {
      return const RouteSettings(name: Routes.DASHBOARD);
    }

    // If user is not logged in and trying to access protected routes,
    // redirect to login
    if (route != Routes.LOGIN &&
        route != Routes.SPLASH &&
        !_authService.isLoggedIn) {
      return const RouteSettings(name: Routes.LOGIN);
    }

    return null; // No redirect needed
  }
}
