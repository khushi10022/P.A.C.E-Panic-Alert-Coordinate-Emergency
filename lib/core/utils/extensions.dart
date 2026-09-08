import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// SheShield – Dart Extensions
///
/// Elegant utility extensions for cleaner, more expressive code.

// ──────────────────────────────────────────────
// BuildContext Extensions
// ──────────────────────────────────────────────
extension ContextExtensions on BuildContext {
  /// Access the current theme
  ThemeData get theme => Theme.of(this);

  /// Access the color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Access the text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Screen size
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Safe area padding
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Show a snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
      ),
    );
  }

  /// Show a bottom sheet
  Future<T?> showAppBottomSheet<T>(Widget child) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: true,
      builder: (_) => child,
    );
  }
}

// ──────────────────────────────────────────────
// String Extensions
// ──────────────────────────────────────────────
extension StringExtensions on String {
  /// Capitalize the first letter
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Capitalize each word
  String get titleCase =>
      split(' ').map((word) => word.capitalize).join(' ');

  /// Check if string is a valid email
  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  /// Check if string is a valid phone number
  bool get isValidPhone =>
      RegExp(r'^\+?[\d\s-]{10,15}$').hasMatch(this);
}

// ──────────────────────────────────────────────
// DateTime Extensions
// ──────────────────────────────────────────────
extension DateTimeExtensions on DateTime {
  /// Format to readable date
  String get formattedDate => DateFormat('MMM dd, yyyy').format(this);

  /// Format to readable time
  String get formattedTime => DateFormat('hh:mm a').format(this);

  /// Format to full date time
  String get formattedDateTime =>
      DateFormat('MMM dd, yyyy • hh:mm a').format(this);

  /// Time ago format
  String get timeAgo {
    final diff = DateTime.now().difference(this);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  /// Get time-of-day greeting
  String get greeting {
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}

// ──────────────────────────────────────────────
// Num Extensions
// ──────────────────────────────────────────────
extension NumExtensions on num {
  /// SizedBox with height
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// SizedBox with width
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}

// ──────────────────────────────────────────────
// Widget Extensions
// ──────────────────────────────────────────────
extension WidgetExtensions on Widget {
  /// Wrap with Padding
  Widget padAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// Horizontal padding
  Widget padHorizontal(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  /// Vertical padding
  Widget padVertical(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  /// Center the widget
  Widget get centered => Center(child: this);

  /// Wrap with expanded
  Widget get expanded => Expanded(child: this);

  /// Add a sliver to box adapter
  Widget get slpiverBox => SliverToBoxAdapter(child: this);
}
