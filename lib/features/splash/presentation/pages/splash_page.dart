import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../config/router/app_router.dart';
import '../../../../services/storage_service.dart';
import '../../../../config/di/injection.dart';

/// SheShield – Splash Screen 💅
///
/// Luxurious animated splash with gradient background, logo animation,
/// and smooth transition to onboarding or dashboard.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _shieldController;

  @override
  void initState() {
    super.initState();

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Gradient animation controller
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Shield animation
    _shieldController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Navigate after splash
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;

    final storage = getIt<StorageService>();
    if (storage.hasSeenOnboarding) {
      context.go(AppRouter.home);
    } else {
      context.go(AppRouter.onboarding);
    }
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _shieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _gradientController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft + Alignment(_gradientController.value * 0.5, 0),
                end: Alignment.bottomRight - Alignment(_gradientController.value * 0.5, 0),
                colors: const [
                  Color(0xFF4B0E1E),
                  Color(0xFF7B1E3A),
                  Color(0xFFB62B5A),
                  Color(0xFFE75480),
                ],
                stops: [
                  0.0,
                  0.3 + (_gradientController.value * 0.1),
                  0.6 + (_gradientController.value * 0.1),
                  1.0,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Stack(
          children: [
            // Background particles/bubbles
            ..._buildParticles(),

            // Center content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Shield Icon
                  _buildShieldLogo()
                      .animate()
                      .scale(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(1.0, 1.0),
                        duration: 800.ms,
                        curve: Curves.elasticOut,
                      )
                      .then()
                      .shimmer(
                        duration: 1500.ms,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),

                  const SizedBox(height: 24),

                  // App Name
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 12),

                  // Tagline
                  Text(
                    AppStrings.tagline,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 3,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 800.ms)
                      .slideY(begin: 0.5, end: 0),
                ],
              ),
            ),

            // Bottom shine line
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 60,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scaleX(begin: 0.5, end: 1.5, duration: 1500.ms)
                    .fadeIn(delay: 1200.ms),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShieldLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.shield_rounded,
          size: 52,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(8, (index) {
      final positions = [
        [0.1, 0.2],
        [0.8, 0.15],
        [0.15, 0.7],
        [0.85, 0.75],
        [0.5, 0.1],
        [0.3, 0.85],
        [0.7, 0.5],
        [0.9, 0.4],
      ];
      final sizes = [30.0, 50.0, 40.0, 60.0, 35.0, 45.0, 55.0, 25.0];

      return Positioned(
        left: MediaQuery.of(context).size.width * positions[index][0],
        top: MediaQuery.of(context).size.height * positions[index][1],
        child: Container(
          width: sizes[index],
          height: sizes[index],
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.06),
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.3, 1.3),
              duration: Duration(milliseconds: 2000 + (index * 300)),
            )
            .fadeIn(duration: 800.ms, delay: (index * 200).ms),
      );
    });
  }
}
