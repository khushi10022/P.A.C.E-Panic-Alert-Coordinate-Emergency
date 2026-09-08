import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/helpers.dart';

/// SheShield – Emergency SOS Page 🚨
///
/// The app's most critical feature. A large animated SOS button with
/// 3-second hold confirmation, countdown animation, and cancel option.
class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _holdController;
  late AnimationController _countdownController;

  SosState _state = SosState.idle;
  int _countdown = 3;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _holdController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _holdController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startCountdown();
      }
    });
  }

  void _startCountdown() {
    setState(() {
      _state = SosState.countdown;
      _countdown = 3;
    });

    Helpers.heavyHaptic();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 1) {
        timer.cancel();
        _activateSos();
      } else {
        setState(() => _countdown--);
        Helpers.mediumHaptic();
      }
    });
  }

  void _activateSos() {
    setState(() => _state = SosState.active);
    Helpers.heavyHaptic();
    // TODO: Trigger emergency alert, notify contacts, start tracking
  }

  void _cancelSos() {
    _countdownTimer?.cancel();
    _holdController.reset();
    setState(() {
      _state = SosState.idle;
      _countdown = 3;
    });
    Helpers.lightHaptic();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _holdController.dispose();
    _countdownController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _state == SosState.active
          ? const Color(0xFF1A0A0A)
          : AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _state != SosState.active
            ? IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          AppStrings.sosTitle,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: _state == SosState.active
                ? Colors.white
                : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case SosState.idle:
        return _buildIdleState();
      case SosState.holding:
        return _buildHoldingState();
      case SosState.countdown:
        return _buildCountdownState();
      case SosState.active:
        return _buildActiveState();
    }
  }

  // ── IDLE STATE ──
  Widget _buildIdleState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),

        // SOS Button
        _buildSosButton(),

        const SizedBox(height: 32),

        // Instruction
        Text(
          AppStrings.sosInstruction,
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ).animate().fadeIn(delay: 400.ms),

        const Spacer(flex: 3),

        // Safety message
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Your safety is our priority. Press and hold the SOS button to alert your emergency contacts.',
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: AppColors.textTertiary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ).animate().fadeIn(delay: 600.ms),

        const SizedBox(height: 32),
      ],
    );
  }

  // ── HOLDING STATE ──
  Widget _buildHoldingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        _buildSosButton(),
        const SizedBox(height: 32),
        Text(
          'Keep holding...',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.emergency,
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  // ── COUNTDOWN STATE ──
  Widget _buildCountdownState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),

        // Countdown number
        Text(
          '$_countdown',
          style: GoogleFonts.poppins(
            fontSize: 120,
            fontWeight: FontWeight.w800,
            color: AppColors.emergency,
          ),
        )
            .animate(onComplete: (c) => c.repeat())
            .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1.0, 1.0),
              duration: 800.ms,
            ),

        const SizedBox(height: 16),

        Text(
          '${AppStrings.sosCountdown}...',
          style: GoogleFonts.outfit(
            fontSize: 18,
            color: AppColors.textSecondary,
          ),
        ),

        const Spacer(flex: 2),

        // Cancel button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: GestureDetector(
            onTap: _cancelSos,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.emergency.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  AppStrings.cancelSos,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.emergency,
                  ),
                ),
              ),
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

        const SizedBox(height: 40),
      ],
    );
  }

  // ── ACTIVE STATE ──
  Widget _buildActiveState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),

        // Active indicator
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.emergency.withValues(alpha: 0.2),
            border: Border.all(color: AppColors.emergency, width: 3),
          ),
          child: const Icon(
            Icons.emergency_rounded,
            size: 56,
            color: AppColors.emergency,
          ),
        )
            .animate(onComplete: (c) => c.repeat(reverse: true))
            .scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1.1, 1.1),
              duration: 800.ms,
            ),

        const SizedBox(height: 32),

        Text(
          AppStrings.sosActive,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.emergency,
          ),
        ).animate().fadeIn(),

        const SizedBox(height: 8),

        Text(
          AppStrings.sosAlertSent,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ).animate().fadeIn(delay: 300.ms),

        const Spacer(flex: 2),

        // Emergency status indicators
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              _statusRow(
                Icons.people_rounded,
                'Contacts Notified',
                true,
              ),
              const SizedBox(height: 12),
              _statusRow(
                Icons.location_on_rounded,
                'Location Shared',
                true,
              ),
              const SizedBox(height: 12),
              _statusRow(
                Icons.watch_rounded,
                'Band Alert Active',
                false,
              ),
            ],
          ),
        ).animate().fadeIn(delay: 500.ms),

        const Spacer(),

        // Cancel Emergency
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: GestureDetector(
            onTap: () {
              _cancelSos();
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'End Emergency',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _statusRow(IconData icon, String text, bool active) {
    return Row(
      children: [
        Icon(
          active ? Icons.check_circle_rounded : Icons.pending_rounded,
          color: active ? AppColors.success : Colors.white.withValues(alpha: 0.4),
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: active
                ? Colors.white.withValues(alpha: 0.9)
                : Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  // ── SOS Button ──
  Widget _buildSosButton() {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() => _state = SosState.holding);
        _holdController.forward(from: 0);
        Helpers.mediumHaptic();
      },
      onLongPressEnd: (_) {
        if (_state == SosState.holding) {
          _holdController.reset();
          setState(() => _state = SosState.idle);
        }
      },
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final isHolding = _state == SosState.holding;
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow ring
              Container(
                width: 200 + (_pulseController.value * 20),
                height: 200 + (_pulseController.value * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.emergency
                      .withValues(alpha: 0.05 + (_pulseController.value * 0.05)),
                ),
              ),

              // Middle ring
              Container(
                width: 170 + (_pulseController.value * 10),
                height: 170 + (_pulseController.value * 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.emergency
                      .withValues(alpha: 0.08 + (_pulseController.value * 0.07)),
                ),
              ),

              // Hold progress ring
              if (isHolding)
                SizedBox(
                  width: 150,
                  height: 150,
                  child: AnimatedBuilder(
                    animation: _holdController,
                    builder: (context, _) {
                      return CircularProgressIndicator(
                        value: _holdController.value,
                        strokeWidth: 6,
                        backgroundColor:
                            AppColors.emergency.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.emergency,
                        ),
                      );
                    },
                  ),
                ),

              // Main button
              Container(
                width: isHolding ? 130 : 140,
                height: isHolding ? 130 : 140,
                decoration: BoxDecoration(
                  gradient: AppColors.emergencyGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emergency.withValues(alpha: 0.4),
                      blurRadius: 24 + (_pulseController.value * 12),
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    AppStrings.sosHoldButton,
                    style: GoogleFonts.poppins(
                      fontSize: isHolding ? 32 : 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.elasticOut,
        );
  }
}

enum SosState { idle, holding, countdown, active }
