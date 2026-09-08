import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';

/// SheShield – Status Badge
///
/// A compact, color-coded badge for connection/alert statuses.
class StatusBadge extends StatelessWidget {
  final String label;
  final StatusType type;
  final bool showDot;
  final bool animate;

  const StatusBadge({
    super.key,
    required this.label,
    this.type = StatusType.info,
    this.showDot = true,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            _buildDot(),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: _textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot() {
    final dot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: _dotColor,
        shape: BoxShape.circle,
      ),
    );

    if (animate) {
      return _PulsatingDot(color: _dotColor);
    }
    return dot;
  }

  Color get _backgroundColor {
    switch (type) {
      case StatusType.success:
        return AppColors.successLight;
      case StatusType.warning:
        return AppColors.warningLight;
      case StatusType.error:
        return AppColors.emergencyLight;
      case StatusType.info:
        return AppColors.infoLight;
      case StatusType.connected:
        return AppColors.successLight;
      case StatusType.disconnected:
        return const Color(0xFFFFF3E0);
    }
  }

  Color get _borderColor {
    switch (type) {
      case StatusType.success:
        return AppColors.success.withValues(alpha: 0.3);
      case StatusType.warning:
        return AppColors.warning.withValues(alpha: 0.3);
      case StatusType.error:
        return AppColors.emergency.withValues(alpha: 0.3);
      case StatusType.info:
        return AppColors.info.withValues(alpha: 0.3);
      case StatusType.connected:
        return AppColors.success.withValues(alpha: 0.3);
      case StatusType.disconnected:
        return AppColors.warning.withValues(alpha: 0.3);
    }
  }

  Color get _dotColor {
    switch (type) {
      case StatusType.success:
        return AppColors.success;
      case StatusType.warning:
        return AppColors.warning;
      case StatusType.error:
        return AppColors.emergency;
      case StatusType.info:
        return AppColors.info;
      case StatusType.connected:
        return AppColors.success;
      case StatusType.disconnected:
        return AppColors.warning;
    }
  }

  Color get _textColor {
    switch (type) {
      case StatusType.success:
      case StatusType.connected:
        return const Color(0xFF2E7D32);
      case StatusType.warning:
      case StatusType.disconnected:
        return const Color(0xFFE65100);
      case StatusType.error:
        return AppColors.emergencyDark;
      case StatusType.info:
        return const Color(0xFF1565C0);
    }
  }
}

enum StatusType { success, warning, error, info, connected, disconnected }

/// Internal pulsating dot widget
class _PulsatingDot extends StatefulWidget {
  final Color color;
  const _PulsatingDot({required this.color});

  @override
  State<_PulsatingDot> createState() => _PulsatingDotState();
}

class _PulsatingDotState extends State<_PulsatingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8 + (_controller.value * 4),
          height: 8 + (_controller.value * 4),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.6 + (_controller.value * 0.4)),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.3),
                blurRadius: 6 + (_controller.value * 4),
              ),
            ],
          ),
        );
      },
    );
  }
}
