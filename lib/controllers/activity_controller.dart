import 'package:get/get.dart';
import '../models/activity_log.dart';
import '../services/api_service.dart';
import '../utils/helpers.dart';

class ActivityController extends GetxController {
  final RxList<ActivityLog> activityLogs = <ActivityLog>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreData = true.obs;

  int currentPage = 1;
  final int itemsPerPage = 10;

  @override
  void onInit() {
    super.onInit();
    loadActivityLogs();
  }

  Future<void> loadActivityLogs() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final logs = await ApiService.getActivityLogs(
        page: 1,
        limit: itemsPerPage,
      );
      activityLogs.value = logs;
      currentPage = 1;
      hasMoreData.value = logs.length >= itemsPerPage;
    } catch (e) {
      AwesomeSnackBarHelper.showError(
        title: 'Error',
        message: 'Failed to load activity logs: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreActivityLogs() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    isLoadingMore.value = true;
    try {
      final logs = await ApiService.getActivityLogs(
        page: currentPage + 1,
        limit: itemsPerPage,
      );

      if (logs.isNotEmpty) {
        activityLogs.addAll(logs);
        currentPage++;
        hasMoreData.value = logs.length >= itemsPerPage;
      } else {
        hasMoreData.value = false;
      }
    } catch (e) {
      AwesomeSnackBarHelper.showError(
        title: 'Error',
        message: 'Failed to load more activity logs: $e',
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshActivityLogs() async {
    currentPage = 1;
    hasMoreData.value = true;
    await loadActivityLogs();
  }
}
