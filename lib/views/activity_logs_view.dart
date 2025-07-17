// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/activity_controller.dart';
import '../widgets/animated_card.dart';
import '../widgets/loading_widget.dart';

class ActivityLogsView extends GetView<ActivityController> {
  const ActivityLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Logs'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshActivityLogs,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.activityLogs.isEmpty) {
          return const LoadingWidget(message: 'Loading activity logs...');
        }

        return RefreshIndicator(
          onRefresh: controller.refreshActivityLogs,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !controller.isLoadingMore.value &&
                  controller.hasMoreData.value) {
                controller.loadMoreActivityLogs();
              }
              return false;
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount:
                  controller.activityLogs.length +
                  (controller.hasMoreData.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.activityLogs.length) {
                  return Obx(() {
                    if (controller.isLoadingMore.value) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: LoadingWidget(message: 'Loading more...'),
                      );
                    }
                    return const SizedBox.shrink();
                  });
                }

                final log = controller.activityLogs[index];
                return AnimatedCard(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: _getActivityColor(index),
                        child: Icon(
                          _getActivityIcon(log.title),
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        log.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            log.body,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'User ${log.userId}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getActivityColor(
                                    index,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'ID: ${log.id}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getActivityColor(index),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        _showActivityDetails(context, log);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Color _getActivityColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    return colors[index % colors.length];
  }

  IconData _getActivityIcon(String title) {
    final titleLower = title.toLowerCase();
    if (titleLower.contains('run') || titleLower.contains('jog')) {
      return Icons.directions_run;
    } else if (titleLower.contains('walk')) {
      return Icons.directions_walk;
    } else if (titleLower.contains('bike') || titleLower.contains('cycle')) {
      return Icons.directions_bike;
    } else if (titleLower.contains('swim')) {
      return Icons.pool;
    } else if (titleLower.contains('gym') || titleLower.contains('workout')) {
      return Icons.fitness_center;
    } else if (titleLower.contains('yoga')) {
      return Icons.self_improvement;
    }
    return Icons.directions_walk;
  }

  void _showActivityDetails(BuildContext context, log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getActivityColor(log.id),
                      child: Icon(
                        _getActivityIcon(log.title),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        log.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  log.body,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'User ID: ${log.userId}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getActivityColor(log.id).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Activity #${log.id}',
                        style: TextStyle(
                          color: _getActivityColor(log.id),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
    );
  }
}
