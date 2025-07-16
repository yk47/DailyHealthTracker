class Constants {
  // App Information
  static const String appName = 'Daily Health Tracker';
  static const String appVersion = '1.0.0';

  // Timer Configuration
  static const int defaultTimerDuration = 600; // 10 minutes in seconds

  // API Configuration
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const int itemsPerPage = 10;

  // Animation Durations
  static const int fastAnimationDuration = 300;
  static const int normalAnimationDuration = 500;
  static const int slowAnimationDuration = 800;

  // Health Data Defaults
  static const int defaultSteps = 8000;
  static const double defaultCalories = 200.0;
  static const int defaultActiveMinutes = 30;

  // UI Constants
  static const double cardElevation = 4.0;
  static const double borderRadius = 12.0;
  static const double buttonRadius = 28.0;
}

class AppStrings {
  // Welcome Messages
  static const String welcomeBack = 'Welcome back!';
  static const String signInGoogle = 'Sign in with Google';
  static const String trackActivities =
      'Track your daily activities and stay healthy';

  // Navigation
  static const String dashboard = 'Dashboard';
  static const String healthGraph = 'Health Graph';
  static const String activityLogs = 'Activity Logs';
  static const String timer = 'Activity Timer';
  static const String profile = 'Profile';

  // Messages
  static const String loginFailed = 'Login Failed';
  static const String loginError = 'Failed to sign in with Google';
  static const String networkError = 'Network error occurred';
  static const String loadingData = 'Loading data...';
  static const String noMoreData = 'No more data available';

  // Timer
  static const String nextWalkReminder = 'Next Walk Reminder';
  static const String timerComplete = 'Timer Complete!';
  static const String timeForWalk = 'Time for your next walk activity!';

  // Settings
  static const String darkMode = 'Dark Mode';
  static const String notifications = 'Notifications';
  static const String language = 'Language';
  static const String privacyPolicy = 'Privacy Policy';
  static const String signOut = 'Sign Out';
}
