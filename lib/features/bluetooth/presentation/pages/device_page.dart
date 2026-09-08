import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../shared/providers/bluetooth_provider.dart';
import '../../../../widgets/gradient_button.dart';

/// SheShield – Bluetooth Device Management
class DevicePage extends ConsumerStatefulWidget {
  const DevicePage({super.key});

  @override
  ConsumerState<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends ConsumerState<DevicePage> {
  @override
  Widget build(BuildContext context) {
    final bt = ref.watch(bluetoothProvider);

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
        title: Text(AppStrings.bluetoothTitle,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connected Device Card
            if (bt.isConnected && bt.connectedDevice != null)
              _buildConnectedDevice(bt)
                  .animate()
                  .fadeIn()
                  .slideY(begin: 0.1, end: 0),

            if (!bt.isConnected) ...[
              // Scan animation
              Center(
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primarySurface,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (bt.isScanning)
                        ...[80.0, 110.0, 140.0].map((size) => Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.2),
                                ),
                              ),
                            )
                                .animate(
                                    onComplete: (c) =>
                                        c.repeat(reverse: true))
                                .scale(
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2),
                                  duration: Duration(
                                      milliseconds: 1500 + (size * 5).toInt()),
                                )),
                      Icon(
                        Icons.bluetooth_searching_rounded,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms),

              const SizedBox(height: 24),

              // Scan button
              GradientButton(
                text: bt.isScanning
                    ? AppStrings.scanning
                    : AppStrings.scanDevices,
                icon: Icons.bluetooth_searching_rounded,
                isLoading: bt.isScanning,
                onPressed: bt.isScanning
                    ? null
                    : () => ref.read(bluetoothProvider.notifier).startScan(),
              ),

              const SizedBox(height: 24),
            ],

            // Discovered Devices
            if (bt.devices.isNotEmpty) ...[
              Text(
                'Nearby Devices',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...bt.devices.asMap().entries.map((entry) {
                final device = entry.value;
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.watch_rounded,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(device.name,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'Signal: ${Helpers.getSignalText(device.rssi)} • ${device.firmwareVersion}',
                              style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: AppColors.textTertiary),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: bt.isConnecting
                            ? null
                            : () => ref
                                .read(bluetoothProvider.notifier)
                                .connect(device),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            bt.isConnecting ? '...' : AppStrings.connectDevice,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: (entry.key * 150).ms)
                    .slideX(begin: 0.1, end: 0);
              }),
            ],

            if (bt.devices.isEmpty && !bt.isScanning && !bt.isConnected)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(Icons.bluetooth_disabled_rounded,
                          size: 48,
                          color: AppColors.textTertiary.withValues(alpha: 0.4)),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.noDevicesFound,
                        style: GoogleFonts.outfit(
                            color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedDevice(BluetoothState bt) {
    final device = bt.connectedDevice!;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.watch_rounded,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.name,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    Text(AppStrings.connected,
                        style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.8))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () =>
                    ref.read(bluetoothProvider.notifier).disconnect(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Text(AppStrings.disconnectDevice,
                      style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _deviceStat(Icons.battery_std_rounded,
                  '${device.batteryLevel}%', 'Battery'),
              _deviceStat(Icons.system_update_rounded,
                  device.firmwareVersion, 'Firmware'),
              _deviceStat(Helpers.getSignalIcon(device.rssi),
                  Helpers.getSignalText(device.rssi), 'Signal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _deviceStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 20),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        Text(label,
            style: GoogleFonts.outfit(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.6))),
      ],
    );
  }
}
