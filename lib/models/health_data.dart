class HealthData {
  final DateTime date;
  final int steps;
  final double calories;
  final int activeMinutes;

  HealthData({
    required this.date,
    required this.steps,
    required this.calories,
    required this.activeMinutes,
  });

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      date: DateTime.parse(json['date']),
      steps: json['steps'],
      calories: json['calories'].toDouble(),
      activeMinutes: json['activeMinutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'steps': steps,
      'calories': calories,
      'activeMinutes': activeMinutes,
    };
  }
}
