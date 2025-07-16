import 'package:get/get.dart';
import '../models/health_data.dart';
import '../services/mock_data_service.dart';

class GraphController extends GetxController {
  final RxList<HealthData> weeklyData = <HealthData>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedPeriod = 'Week'.obs;

  @override
  void onInit() {
    super.onInit();
    loadGraphData();
  }

  void loadGraphData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));

    if (selectedPeriod.value == 'Week') {
      weeklyData.value = MockDataService.generateWeeklyHealthData();
    } else {
      weeklyData.value = MockDataService.generateMonthlyHealthData();
    }

    isLoading.value = false;
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;
    loadGraphData();
  }

  double get averageSteps {
    if (weeklyData.isEmpty) return 0;
    return weeklyData.map((e) => e.steps).reduce((a, b) => a + b) /
        weeklyData.length;
  }

  double get totalCalories {
    if (weeklyData.isEmpty) return 0;
    return weeklyData.map((e) => e.calories).reduce((a, b) => a + b);
  }

  int get totalActiveMinutes {
    if (weeklyData.isEmpty) return 0;
    return weeklyData.map((e) => e.activeMinutes).reduce((a, b) => a + b);
  }
}
