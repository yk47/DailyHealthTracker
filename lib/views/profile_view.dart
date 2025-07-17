// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/animated_card.dart';
import '../widgets/animated_button.dart';
import '../utils/helpers.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        actions: [
          Obx(
            () => Switch(
              value: controller.isDarkMode.value,
              onChanged: (_) => controller.toggleDarkMode(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header
            AnimatedCard(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              controller.user.value?.photoUrl != null
                                  ? NetworkImage(
                                    controller.user.value!.photoUrl!,
                                  )
                                  : null,
                          child:
                              controller.user.value?.photoUrl == null
                                  ? const Icon(Icons.person, size: 60)
                                  : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => Text(
                          controller.user.value?.name ?? 'User',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          controller.user.value?.email ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Authentication Source Badge
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                controller.user.value?.id.startsWith(
                                          'demo_user_',
                                        ) ==
                                        true
                                    ? Colors.orange.withOpacity(0.1)
                                    : Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  controller.user.value?.id.startsWith(
                                            'demo_user_',
                                          ) ==
                                          true
                                      ? Colors.orange
                                      : Colors.green,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                controller.user.value?.id.startsWith(
                                          'demo_user_',
                                        ) ==
                                        true
                                    ? Icons.code
                                    : Icons.verified_user,
                                size: 16,
                                color:
                                    controller.user.value?.id.startsWith(
                                              'demo_user_',
                                            ) ==
                                            true
                                        ? Colors.orange
                                        : Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                controller.user.value?.id.startsWith(
                                          'demo_user_',
                                        ) ==
                                        true
                                    ? 'Demo Mode'
                                    : 'Google Authenticated',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      controller.user.value?.id.startsWith(
                                                'demo_user_',
                                              ) ==
                                              true
                                          ? Colors.orange
                                          : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Settings Section
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            AnimatedCard(
              duration: const Duration(milliseconds: 600),
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Dark Mode'),
                      trailing: Obx(
                        () => Switch(
                          value: controller.isDarkMode.value,
                          onChanged: (_) => controller.toggleDarkMode(),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Notifications'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {
                          // Placeholder for notification settings
                          AwesomeSnackBarHelper.showInfo(
                            title: 'Feature',
                            message: 'Notification settings coming soon!',
                          );
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      subtitle: const Text('English'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        AwesomeSnackBarHelper.showInfo(
                          title: 'Feature',
                          message: 'Language settings coming soon!',
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip),
                      title: const Text('Privacy Policy'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        _showPrivacyPolicy(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Test Awesome Snack Bars Section
            Text(
              'Test Notifications',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            AnimatedCard(
              duration: const Duration(milliseconds: 700),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                AwesomeSnackBarHelper.showSuccess(
                                  title: 'Success!',
                                  message:
                                      'This is a success notification at the top!',
                                );
                              },
                              icon: const Icon(Icons.check_circle),
                              label: const Text('Success'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                AwesomeSnackBarHelper.showError(
                                  title: 'Error!',
                                  message:
                                      'This is an error notification at the top!',
                                );
                              },
                              icon: const Icon(Icons.error),
                              label: const Text('Error'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                AwesomeSnackBarHelper.showWarning(
                                  title: 'Warning!',
                                  message:
                                      'This is a warning notification at the top!',
                                );
                              },
                              icon: const Icon(Icons.warning),
                              label: const Text('Warning'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                AwesomeSnackBarHelper.showInfo(
                                  title: 'Info!',
                                  message:
                                      'This is an info notification at the top!',
                                );
                              },
                              icon: const Icon(Icons.info),
                              label: const Text('Info'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Statistics Section
            Text(
              'Your Statistics',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            AnimatedCard(
              duration: const Duration(milliseconds: 800),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildStatisticRow(
                        'Days Active',
                        '15',
                        Icons.calendar_today,
                      ),
                      const Divider(),
                      _buildStatisticRow(
                        'Total Steps',
                        '124,567',
                        Icons.directions_walk,
                      ),
                      const Divider(),
                      _buildStatisticRow(
                        'Calories Burned',
                        '3,456',
                        Icons.local_fire_department,
                      ),
                      const Divider(),
                      _buildStatisticRow(
                        'Activities Logged',
                        '42',
                        Icons.list_alt,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Sign Out Button
            AnimatedCard(
              duration: const Duration(milliseconds: 1000),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedButton(
                  onPressed: () {
                    _showSignOutDialog(context);
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Privacy Policy'),
            content: const SingleChildScrollView(
              child: Text(
                'Daily Health Tracker Privacy Policy\n\n'
                'We respect your privacy and are committed to protecting your personal data. '
                'This app collects minimal data necessary for functionality:\n\n'
                '• Google Sign-In information (name, email, profile picture)\n'
                '• Health data you manually input\n'
                '• App usage statistics\n\n'
                'Your data is stored securely and is never shared with third parties without your consent.\n\n'
                'For questions about privacy, please contact our support team.',
                style: TextStyle(height: 1.5),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);

                  // Show loading state briefly
                  AwesomeSnackBarHelper.showInfo(
                    title: 'Signing Out...',
                    message: 'Please wait while we sign you out',
                    duration: const Duration(seconds: 1),
                  );

                  // Small delay for visual feedback
                  await Future.delayed(const Duration(milliseconds: 800));

                  controller.signOut();
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
