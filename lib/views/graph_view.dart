import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/graph_controller.dart';
import '../widgets/animated_card.dart';
import '../widgets/loading_widget.dart';

class GraphView extends GetView<GraphController> {
  const GraphView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Graph'),
        actions: [
          PopupMenuButton<String>(
            onSelected: controller.changePeriod,
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'Week', child: Text('This Week')),
                  const PopupMenuItem(
                    value: 'Month',
                    child: Text('This Month'),
                  ),
                ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Obx(() => Text(controller.selectedPeriod.value)),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget(message: 'Loading health data...');
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistics Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Avg Steps',
                      controller.averageSteps.toInt().toString(),
                      Icons.directions_walk,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Total Calories',
                      '${controller.totalCalories.toInt()}',
                      Icons.local_fire_department,
                      Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Active Minutes',
                      '${controller.totalActiveMinutes}',
                      Icons.timer,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Days Tracked',
                      '${controller.weeklyData.length}',
                      Icons.calendar_today,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Steps Chart
              Text(
                'Daily Steps',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              AnimatedCard(
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 50,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${(value / 1000).toInt()}k',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < controller.weeklyData.length) {
                                    final day =
                                        controller.weeklyData[index].date;
                                    return Text(
                                      '${day.day}/${day.month}',
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots:
                                  controller.weeklyData
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => FlSpot(
                                          e.key.toDouble(),
                                          e.value.steps.toDouble(),
                                        ),
                                      )
                                      .toList(),
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.1),
                              ),
                              dotData: const FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Calories Chart
              Text(
                'Daily Calories Burned',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              AnimatedCard(
                duration: const Duration(milliseconds: 600),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY:
                              controller.weeklyData
                                  .map((e) => e.calories)
                                  .reduce((a, b) => a > b ? a : b) +
                              50,
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (
                                group,
                                groupIndex,
                                rod,
                                rodIndex,
                              ) {
                                return BarTooltipItem(
                                  '${rod.toY.toInt()} cal',
                                  const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${value.toInt()}',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < controller.weeklyData.length) {
                                    final day =
                                        controller.weeklyData[index].date;
                                    final dayNames = [
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                      'Sun',
                                    ];
                                    return Text(
                                      dayNames[(day.weekday - 1) % 7],
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups:
                              controller.weeklyData
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => BarChartGroupData(
                                      x: e.key,
                                      barRods: [
                                        BarChartRodData(
                                          toY: e.value.calories,
                                          color: Colors.orange,
                                          width: 20,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return AnimatedCard(
      duration: Duration(milliseconds: 300 + (title.length * 20)),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
