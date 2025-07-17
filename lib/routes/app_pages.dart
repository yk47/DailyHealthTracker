import 'package:get/get.dart';
import '../views/splash_view.dart';
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/graph_view.dart';
import '../views/activity_logs_view.dart';
import '../views/timer_view.dart';
import '../views/profile_view.dart';
import '../controllers/splash_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/graph_controller.dart';
import '../controllers/activity_controller.dart';
import '../controllers/timer_controller.dart';
import '../controllers/profile_controller.dart';
import '../middlewares/auth_middleware.dart';
import 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DashboardController>(() => DashboardController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.GRAPH,
      page: () => const GraphView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GraphController>(() => GraphController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.ACTIVITY_LOGS,
      page: () => const ActivityLogsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ActivityController>(() => ActivityController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.TIMER,
      page: () => const TimerView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TimerController>(() => TimerController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
