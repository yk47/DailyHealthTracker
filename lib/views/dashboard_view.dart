import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/animated_card.dart';
import '../widgets/loading_widget.dart';
import '../routes/app_routes.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed(Routes.PROFILE),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget(message: 'Loading dashboard...');
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                AnimatedCard(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                controller.user.value?.photoUrl != null
                                    ? NetworkImage(
                                      controller.user.value!.photoUrl!,
                                    )
                                    : null,
                            child:
                                controller.user.value?.photoUrl == null
                                    ? const Icon(Icons.person, size: 30)
                                    : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back!',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  controller.user.value?.name ?? 'User',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  controller.user.value?.email ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                // Quick Action Cards
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildQuickActionCard(
                      context,
                      'Health Graph',
                      Icons.bar_chart,
                      Colors.blue,
                      () => Get.toNamed(Routes.GRAPH),
                    ),
                    _buildQuickActionCard(
                      context,
                      'Activity Logs',
                      Icons.list,
                      Colors.green,
                      () => Get.toNamed(Routes.ACTIVITY_LOGS),
                    ),
                    _buildQuickActionCard(
                      context,
                      'Timer',
                      Icons.timer,
                      Colors.orange,
                      () => Get.toNamed(Routes.TIMER),
                    ),
                    _buildQuickActionCard(
                      context,
                      'Profile',
                      Icons.person,
                      Colors.purple,
                      () => Get.toNamed(Routes.PROFILE),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Today's Summary
                Text(
                  'Today\'s Summary',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                AnimatedCard(
                  duration: const Duration(milliseconds: 500),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildSummaryRow(
                            'Steps',
                            '8,547',
                            Icons.directions_walk,
                          ),
                          const Divider(),
                          _buildSummaryRow(
                            'Calories',
                            '342 kcal',
                            Icons.local_fire_department,
                          ),
                          const Divider(),
                          _buildSummaryRow(
                            'Active Time',
                            '1h 23m',
                            Icons.timer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return AnimatedCard(
      duration: Duration(milliseconds: 400 + (title.length * 50)),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: color),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
