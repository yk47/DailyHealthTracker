// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${formatTime(date)}';
  }

  static String getWeekdayName(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[date.weekday - 1];
  }

  static String getMonthName(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[date.month - 1];
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  static List<DateTime> getLastNDays(int days) {
    final List<DateTime> dates = [];
    final now = DateTime.now();

    for (int i = days - 1; i >= 0; i--) {
      dates.add(now.subtract(Duration(days: i)));
    }

    return dates;
  }

  static String getRelativeDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      final difference = DateTime.now().difference(date).inDays;
      if (difference < 7) {
        return '$difference days ago';
      } else if (difference < 30) {
        final weeks = (difference / 7).floor();
        return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
      } else {
        return formatDate(date);
      }
    }
  }
}

class NumberHelper {
  static String formatNumber(num number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m ${remainingSeconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${remainingSeconds}s';
    } else {
      return '${remainingSeconds}s';
    }
  }

  static String formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class AwesomeSnackBarHelper {
  /// Show a success snack bar with awesome design at the top
  static void showSuccess({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showTopSnackBar(
      title: title,
      message: message,
      contentType: ContentType.success,
      duration: duration,
    );
  }

  /// Show an error snack bar with awesome design at the top
  static void showError({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    _showTopSnackBar(
      title: title,
      message: message,
      contentType: ContentType.failure,
      duration: duration,
    );
  }

  /// Show a warning snack bar with awesome design at the top
  static void showWarning({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showTopSnackBar(
      title: title,
      message: message,
      contentType: ContentType.warning,
      duration: duration,
    );
  }

  /// Show an info snack bar with awesome design at the top
  static void showInfo({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showTopSnackBar(
      title: title,
      message: message,
      contentType: ContentType.help,
      duration: duration,
    );
  }

  /// Private method to show top snack bar using overlay
  static void _showTopSnackBar({
    required String title,
    required String message,
    required ContentType contentType,
    required Duration duration,
  }) {
    final context = Get.context;
    if (context == null) return;

    // Remove any existing overlay
    _currentOverlay?.remove();
    _currentOverlay = null;

    try {
      _currentOverlay = OverlayEntry(
        builder:
            (context) => Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AwesomeSnackbarContent(
                    title: title,
                    message: message,
                    contentType: contentType,
                  ),
                ),
              ),
            ),
      );

      // Insert overlay safely
      Overlay.of(context, rootOverlay: true).insert(_currentOverlay!);

      // Auto remove after duration
      Future.delayed(duration, () {
        _currentOverlay?.remove();
        _currentOverlay = null;
      });
    } catch (e) {
      // Fallback if overlay insertion fails
      _currentOverlay = null;
      _showFallbackSnackBar(
        context: context,
        title: title,
        message: message,
        contentType: contentType,
        duration: duration,
      );
    }
  }

  /// Fallback method using regular SnackBar positioned at top
  static void _showFallbackSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
    required Duration duration,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: duration,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).size.height * 0.7,
      ),
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static OverlayEntry? _currentOverlay;

  /// Show a custom snack bar based on message type analysis
  static void showMessage({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Auto-detect message type based on keywords
    final lowerMessage = message.toLowerCase();
    final lowerTitle = title.toLowerCase();

    if (lowerMessage.contains('success') ||
        lowerMessage.contains('completed') ||
        lowerMessage.contains('saved') ||
        lowerTitle.contains('success')) {
      showSuccess(title: title, message: message, duration: duration);
    } else if (lowerMessage.contains('error') ||
        lowerMessage.contains('failed') ||
        lowerMessage.contains('wrong') ||
        lowerTitle.contains('error')) {
      showError(title: title, message: message, duration: duration);
    } else if (lowerMessage.contains('warning') ||
        lowerMessage.contains('careful') ||
        lowerMessage.contains('attention') ||
        lowerTitle.contains('warning')) {
      showWarning(title: title, message: message, duration: duration);
    } else {
      showInfo(title: title, message: message, duration: duration);
    }
  }
}
