import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../config/router/app_router.dart';

/// SheShield – Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppColors.textPrimary),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppStrings.settings,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('General'),
            _settingsTile(
              icon: Icons.person_rounded,
              title: AppStrings.profileSettings,
              subtitle: 'Personal info, photo, medical',
              color: AppColors.primary,
              onTap: () => context.push(AppRouter.editProfile),
            ),
            _settingsTile(
              icon: Icons.notifications_rounded,
              title: AppStrings.notificationSettings,
              subtitle: 'Push, sound, vibration',
              color: AppColors.secondary,
              onTap: () => context.push(AppRouter.notificationSettings),
            ),

            const SizedBox(height: 24),
            _sectionTitle('Device'),
            _settingsTile(
              icon: Icons.watch_rounded,
              title: AppStrings.deviceSettings,
              subtitle: 'Auto-connect, firmware, battery',
              color: AppColors.roseGold,
              onTap: () => context.push(AppRouter.deviceSettings),
            ),

            const SizedBox(height: 24),
            _sectionTitle('Privacy & Security'),
            _settingsTile(
              icon: Icons.shield_rounded,
              title: AppStrings.privacy,
              subtitle: 'Permissions, data sharing',
              color: AppColors.accent,
              onTap: () => context.push(AppRouter.privacySettings),
            ),

            const SizedBox(height: 24),
            _sectionTitle('About'),
            _settingsTile(
              icon: Icons.info_rounded,
              title: AppStrings.about,
              subtitle: 'Version 1.0.0',
              color: AppColors.info,
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.description_rounded,
              title: AppStrings.termsOfService,
              subtitle: 'Terms and conditions',
              color: AppColors.textTertiary,
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.privacy_tip_rounded,
              title: AppStrings.privacyPolicy,
              subtitle: 'How we handle your data',
              color: AppColors.textTertiary,
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // Logout
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.emergencyLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.emergency.withValues(alpha: 0.2),
                  ),
                ),
                child: Center(
                  child: Text(
                    AppStrings.logout,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.emergency,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textTertiary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(subtitle,
                          style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppColors.textTertiary)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
