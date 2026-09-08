import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';
import '../shared/models/emergency_model.dart';
import '../core/utils/extensions.dart';

/// SheShield – Emergency History Card
///
/// A card displaying an emergency event with status, location, and timestamp.
class EmergencyCard extends StatelessWidget {
  final EmergencyModel emergency;
  final VoidCallback? onTap;
  final int index;

  const EmergencyCard({
    super.key,
    required this.emergency,
    this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Type badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getTypeColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getTypeColor().withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getTypeIcon(),
                            size: 14,
                            color: _getTypeColor(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            emergency.type.label,
                            style: AppTypography.labelSmall.copyWith(
                              color: _getTypeColor(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        emergency.status.label,
                        style: AppTypography.labelSmall.copyWith(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        emergency.address,
                        style: AppTypography.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Date, Time & Duration
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      emergency.timestamp.formattedDateTime,
                      style: AppTypography.bodySmall,
                    ),
                    if (emergency.duration != null) ...[
                      const SizedBox(width: 12),
                      Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${emergency.duration!.inMinutes}m',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                    const Spacer(),
                    Icon(
                      Icons.map_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'View',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: (index * 80).ms)
        .slideY(begin: 0.05, end: 0);
  }

  Color _getTypeColor() {
    switch (emergency.type) {
      case EmergencyType.manual:
        return AppColors.emergency;
      case EmergencyType.wearable:
        return AppColors.primary;
      case EmergencyType.automatic:
        return AppColors.warning;
    }
  }

  IconData _getTypeIcon() {
    switch (emergency.type) {
      case EmergencyType.manual:
        return Icons.touch_app_rounded;
      case EmergencyType.wearable:
        return Icons.watch_rounded;
      case EmergencyType.automatic:
        return Icons.auto_awesome_rounded;
    }
  }

  Color _getStatusColor() {
    switch (emergency.status) {
      case EmergencyStatus.active:
        return AppColors.emergency;
      case EmergencyStatus.pending:
        return AppColors.warning;
      case EmergencyStatus.resolved:
        return AppColors.success;
      case EmergencyStatus.cancelled:
        return AppColors.textTertiary;
    }
  }
}
