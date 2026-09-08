import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';
import '../core/utils/helpers.dart';
import '../shared/models/contact_model.dart';

/// P.A.C.E. – Contact Tile
///
/// A premium list tile for emergency contacts with avatar and call action.
class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback? onTap;
  final VoidCallback? onCall;
  final VoidCallback? onDelete;
  final int index;

  const ContactTile({
    super.key,
    required this.contact,
    this.onTap,
    this.onCall,
    this.onDelete,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: contact.isPrimary
              ? AppColors.roseGold.withValues(alpha: 0.4)
              : AppColors.borderLight,
          width: contact.isPrimary ? 1.5 : 1,
        ),
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
            child: Row(
              children: [
                // Avatar
                _buildAvatar(),
                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            contact.name,
                            style: AppTypography.titleSmall,
                          ),
                          if (contact.isPrimary) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.roseGoldGradient,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Primary',
                                style: AppTypography.badgeText,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${contact.relationship} • ${contact.phone}',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),

                // Call button
                _buildCallButton(),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: (index * 100).ms)
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: contact.isPrimary
            ? AppColors.roseGoldGradient
            : AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          Helpers.getInitials(contact.name),
          style: AppTypography.buttonMedium.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCallButton() {
    return GestureDetector(
      onTap: onCall,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.call_rounded,
          color: Color(0xFF2E7D32),
          size: 20,
        ),
      ),
    );
  }
}
