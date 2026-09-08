import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'config/router/app_router.dart';
import 'config/di/injection.dart';

/// P.A.C.E. – Main Entry Point 💅
///
/// "Panic Alert & Coordinate Emergency"
/// AI-Enabled Smart Women's Safety Wearable System
///
/// Initializes all services, sets up dependency injection,
/// and launches the app with the premium Material 3 theme.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize dependencies (Hive, notifications, etc.)
  await setupDependencies();

  // NOTE: Firebase initialization is skipped until the user
  // configures their Firebase project and adds credentials.
  // Uncomment the line below once Firebase is set up:
  // await FirebaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: PaceApp(),
    ),
  );
}

class PaceApp extends StatelessWidget {
  const PaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
