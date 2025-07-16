import '../models/health_data.dart';

class MockDataService {
  static List<HealthData> generateWeeklyHealthData() {
    final List<HealthData> data = [];
    final now = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      data.add(
        HealthData(
          date: date,
          steps: 8000 + (i * 1000) + (i % 2 == 0 ? 500 : -500),
          calories: 200.0 + (i * 50.0),
          activeMinutes: 30 + (i * 10),
        ),
      );
    }

    return data;
  }

  static List<HealthData> generateMonthlyHealthData() {
    final List<HealthData> data = [];
    final now = DateTime.now();

    for (int i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      data.add(
        HealthData(
          date: date,
          steps: 7000 + (i * 100) + (i % 3 == 0 ? 1000 : 0),
          calories: 180.0 + (i * 10.0),
          activeMinutes: 25 + (i * 5),
        ),
      );
    }

    return data;
  }
}
