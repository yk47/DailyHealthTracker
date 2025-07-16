import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';

class TimerView extends GetView<TimerController> {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Timer')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer Title
            AnimatedCard(
              child: Text(
                'Next Walk Reminder',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            // Circular Progress Timer
            AnimatedCard(
              duration: const Duration(milliseconds: 800),
              child: Container(
                width: 280,
                height: 280,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Circle
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                    // Progress Circle
                    Obx(
                      () => SizedBox(
                        width: 250,
                        height: 250,
                        child: CircularProgressIndicator(
                          value: controller.progress,
                          strokeWidth: 12,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            controller.isRunning.value
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    // Timer Display
                    Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.formattedTime,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.isRunning.value
                                ? 'Running...'
                                : controller.isPaused.value
                                ? 'Paused'
                                : 'Ready to start',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Control Buttons
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Start/Pause Button
                  AnimatedButton(
                    onPressed: () {
                      if (controller.isRunning.value) {
                        controller.pauseTimer();
                      } else if (controller.isPaused.value) {
                        controller.resumeTimer();
                      } else {
                        controller.startTimer();
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.isRunning.value
                                ? Colors.orange
                                : Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: (controller.isRunning.value
                                    ? Colors.orange
                                    : Theme.of(context).primaryColor)
                                .withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        controller.isRunning.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  // Reset Button
                  AnimatedButton(
                    onPressed: controller.resetTimer,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[600],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Timer Info Card
            AnimatedCard(
              duration: const Duration(milliseconds: 1000),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryColor,
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Activity Reminder',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This timer reminds you to take a walk every 10 minutes to maintain an active lifestyle.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], height: 1.4),
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
  }
}
