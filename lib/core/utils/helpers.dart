import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// SheShield – Utility Helpers
///
/// General purpose helper functions used throughout the app.
class Helpers {
  Helpers._();

  // ──────────────────────────────────────────────
  // Time-based Greeting
  // ──────────────────────────────────────────────
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  // ──────────────────────────────────────────────
  // Format Distance
  // ──────────────────────────────────────────────
  static String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    }
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  // ──────────────────────────────────────────────
  // Format Duration
  // ──────────────────────────────────────────────
  static String formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    }
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    }
    return '${duration.inSeconds}s';
  }

  // ──────────────────────────────────────────────
  // Format Date
  // ──────────────────────────────────────────────
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  // ──────────────────────────────────────────────
  // Generate Initials
  // ──────────────────────────────────────────────
  static String getInitials(String name) {
    if (name.isEmpty) return '?';
    final words = name.trim().split(' ');
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }

  // ──────────────────────────────────────────────
  // Battery Level Text & Color
  // ──────────────────────────────────────────────
  static Color getBatteryColor(int level) {
    if (level > 60) return const Color(0xFF66BB6A);
    if (level > 20) return const Color(0xFFFFB74D);
    return const Color(0xFFE74C6F);
  }

  static IconData getBatteryIcon(int level) {
    if (level > 80) return Icons.battery_full_rounded;
    if (level > 60) return Icons.battery_5_bar_rounded;
    if (level > 40) return Icons.battery_4_bar_rounded;
    if (level > 20) return Icons.battery_2_bar_rounded;
    return Icons.battery_alert_rounded;
  }

  // ──────────────────────────────────────────────
  // Haptic Feedback
  // ──────────────────────────────────────────────
  static void lightHaptic() => HapticFeedback.lightImpact();
  static void mediumHaptic() => HapticFeedback.mediumImpact();
  static void heavyHaptic() => HapticFeedback.heavyImpact();
  static void selectionHaptic() => HapticFeedback.selectionClick();

  // ──────────────────────────────────────────────
  // Signal Strength
  // ──────────────────────────────────────────────
  static String getSignalText(int rssi) {
    if (rssi >= -50) return 'Excellent';
    if (rssi >= -70) return 'Good';
    if (rssi >= -85) return 'Fair';
    return 'Weak';
  }

  static IconData getSignalIcon(int rssi) {
    if (rssi >= -50) return Icons.signal_cellular_4_bar_rounded;
    if (rssi >= -70) return Icons.signal_cellular_alt_rounded;
    if (rssi >= -85) return Icons.signal_cellular_alt_2_bar_rounded;
    return Icons.signal_cellular_alt_1_bar_rounded;
  }

  // ──────────────────────────────────────────────
  // Safety Score Color
  // ──────────────────────────────────────────────
  static Color getSafetyScoreColor(int score) {
    if (score >= 80) return const Color(0xFF66BB6A);
    if (score >= 50) return const Color(0xFFFFB74D);
    return const Color(0xFFE74C6F);
  }
}
