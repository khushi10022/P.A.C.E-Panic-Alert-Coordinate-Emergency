import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../config/di/injection.dart';
import '../../../../services/storage_service.dart';

/// SheShield – Notification Settings Page
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late bool _pushEnabled;
  late bool _soundEnabled;
  late bool _vibrationEnabled;

  @override
  void initState() {
    super.initState();
    final storage = getIt<StorageService>();
    _pushEnabled = storage.pushNotificationsEnabled;
    _soundEnabled = storage.soundEnabled;
    _vibrationEnabled = storage.vibrationEnabled;
  }

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
        title: Text(AppStrings.notificationSettings,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _toggleTile(
              Icons.notifications_active_rounded,
              AppStrings.pushNotifications,
              'Receive emergency alerts and updates',
              _pushEnabled,
              (v) {
                setState(() => _pushEnabled = v);
                getIt<StorageService>().setPushNotifications(v);
              },
            ),
            _toggleTile(
              Icons.volume_up_rounded,
              AppStrings.sound,
              'Play sound for notifications',
              _soundEnabled,
              (v) {
                setState(() => _soundEnabled = v);
                getIt<StorageService>().setSoundEnabled(v);
              },
            ),
            _toggleTile(
              Icons.vibration_rounded,
              AppStrings.vibration,
              'Vibrate on notifications',
              _vibrationEnabled,
              (v) {
                setState(() => _vibrationEnabled = v);
                getIt<StorageService>().setVibrationEnabled(v);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleTile(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
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
                        fontSize: 12, color: AppColors.textTertiary)),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
