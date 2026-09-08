import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../config/router/app_router.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../shared/providers/location_provider.dart';
import '../../../../shared/providers/bluetooth_provider.dart';
import '../../../../widgets/glass_card.dart';

/// SheShield – Home Dashboard 💅
///
/// The diva's command center. Greeting, location, band status,
/// quick actions, and safety tips — all wrapped in luxury.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Load mock data for development
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadMockUser();
      ref.read(locationProvider.notifier).fetchCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final location = ref.watch(locationProvider);
    final bluetooth = ref.watch(bluetoothProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero Header ──
          SliverToBoxAdapter(
            child: _buildHeroHeader(
              userName: user?.name ?? 'there',
              address: location.address,
              isDeviceConnected: bluetooth.isConnected,
              batteryLevel: bluetooth.connectedDevice?.batteryLevel ?? 0,
            ),
          ),

          // ── Quick Actions ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.quickActions,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 16),
                  _buildQuickActions(),
                ],
              ),
            ),
          ),

          // ── Safety Tip ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: _buildSafetyTip(),
            ),
          ),

          // ── Recent Activity ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: _buildRecentActivity(),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  // ── Hero Header with gradient ──
  Widget _buildHeroHeader({
    required String userName,
    required String address,
    required bool isDeviceConnected,
    required int batteryLevel,
  }) {
    final greeting = Helpers.getGreeting();
    final firstName = userName.split(' ').first;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 16,
        20,
        28,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Greeting + Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting 👋',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 4),
                  Text(
                    firstName,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
                ],
              ),
              Row(
                children: [
                  // History
                  _headerIconButton(
                    Icons.history_rounded,
                    () => context.push(AppRouter.history),
                  ),
                  const SizedBox(width: 8),
                  // Settings
                  _headerIconButton(
                    Icons.settings_rounded,
                    () => context.push(AppRouter.settings),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Location row
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: Colors.white.withValues(alpha: 0.8),
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

          const SizedBox(height: 16),

          // Device Status Card
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            backgroundColor: Colors.white.withValues(alpha: 0.15),
            borderColor: Colors.white.withValues(alpha: 0.25),
            blur: 15,
            child: Row(
              children: [
                // Band icon
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.watch_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Connection info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.smartBand,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isDeviceConnected
                            ? '${AppStrings.battery}: $batteryLevel%'
                            : AppStrings.disconnected,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Status + Connect button
                GestureDetector(
                  onTap: () => context.push(AppRouter.device),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDeviceConnected
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      isDeviceConnected ? AppStrings.connected : 'Connect',
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
          ).animate().fadeIn(duration: 500.ms, delay: 300.ms)
              .slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  Widget _headerIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // ── Quick Actions Grid ──
  Widget _buildQuickActions() {
    final actions = [
      _QuickAction(
        icon: Icons.emergency_rounded,
        label: AppStrings.emergencySos,
        gradient: AppColors.emergencyGradient,
        onTap: () => context.push(AppRouter.sos),
      ),
      _QuickAction(
        icon: Icons.map_rounded,
        label: AppStrings.liveTracking,
        gradient: AppColors.primaryGradient,
        onTap: () => context.go(AppRouter.tracking),
      ),
      _QuickAction(
        icon: Icons.route_rounded,
        label: AppStrings.safeRoute,
        gradient: AppColors.roseGoldGradient,
        onTap: () {},
      ),
      _QuickAction(
        icon: Icons.check_circle_rounded,
        label: AppStrings.checkIn,
        gradient: const LinearGradient(
          colors: [Color(0xFF66BB6A), Color(0xFF81C784)],
        ),
        onTap: () {},
      ),
      _QuickAction(
        icon: Icons.favorite_rounded,
        label: AppStrings.healthStatus,
        gradient: const LinearGradient(
          colors: [Color(0xFFF0A6CA), Color(0xFFF8C8DC)],
        ),
        onTap: () {},
      ),
      _QuickAction(
        icon: Icons.watch_rounded,
        label: AppStrings.smartBand,
        gradient: const LinearGradient(
          colors: [Color(0xFF7B68A8), Color(0xFFA994D3)],
        ),
        onTap: () => context.push(AppRouter.device),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return _buildActionCard(actions[index], index);
      },
    );
  }

  Widget _buildActionCard(_QuickAction action, int index) {
    return GestureDetector(
      onTap: action.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.glassShadow.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: action.gradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                action.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              action.label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: (index * 80 + 500).ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1.0, 1.0),
          duration: 400.ms,
          delay: (index * 80 + 500).ms,
          curve: Curves.easeOutBack,
        );
  }

  // ── Safety Tip Card ──
  Widget _buildSafetyTip() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primarySurface,
            AppColors.secondarySurface,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
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
            child: const Icon(
              Icons.lightbulb_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety Tip 💡',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Keep your emergency contacts updated and share your live location when traveling alone.',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: 900.ms)
        .slideY(begin: 0.1, end: 0);
  }

  // ── Recent Activity ──
  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => context.push(AppRouter.history),
              child: Text(
                'View All',
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Empty state
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            children: [
              Icon(
                Icons.verified_user_rounded,
                size: 48,
                color: AppColors.success.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 12),
              Text(
                'All Clear! ✨',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'No emergency events. Stay safe, queen! 👑',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: 1100.ms);
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.gradient,
    required this.onTap,
  });
}
