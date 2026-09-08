import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/dashboard/presentation/pages/home_page.dart';
import '../../features/emergency/presentation/pages/sos_page.dart';
import '../../features/tracking/presentation/pages/tracking_page.dart';
import '../../features/bluetooth/presentation/pages/device_page.dart';
import '../../features/contacts/presentation/pages/contacts_page.dart';
import '../../features/contacts/presentation/pages/add_contact_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/settings/presentation/pages/device_settings_page.dart';
import '../../features/settings/presentation/pages/privacy_settings_page.dart';

/// SheShield – GoRouter Configuration
///
/// Defines all navigation routes with smooth transitions.
class AppRouter {
  AppRouter._();

  // Route paths
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String sos = '/sos';
  static const String tracking = '/tracking';
  static const String device = '/device';
  static const String contacts = '/contacts';
  static const String addContact = '/contacts/add';
  static const String editContact = '/contacts/edit';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';
  static const String notificationSettings = '/settings/notifications';
  static const String deviceSettings = '/settings/device';
  static const String privacySettings = '/settings/privacy';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: false,
    routes: [
      // Splash
      GoRoute(
        path: splash,
        name: 'splash',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const SplashPage(),
        ),
      ),

      // Onboarding
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const OnboardingPage(),
        ),
      ),

      // Dashboard (Shell with Bottom Nav)
      ShellRoute(
        builder: (context, state, child) => DashboardPage(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: tracking,
            name: 'tracking',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const TrackingPage(),
            ),
          ),
          GoRoute(
            path: contacts,
            name: 'contacts',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const ContactsPage(),
            ),
          ),
          GoRoute(
            path: profile,
            name: 'profile',
            pageBuilder: (context, state) => _buildPage(
              state: state,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),

      // Full screen pages (outside bottom nav)
      GoRoute(
        path: sos,
        name: 'sos',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const SosPage(),
          transitionType: _TransitionType.scale,
        ),
      ),
      GoRoute(
        path: addContact,
        name: 'addContact',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const AddContactPage(),
        ),
      ),
      GoRoute(
        path: editContact,
        name: 'editContact',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: AddContactPage(
            contactId: state.uri.queryParameters['id'],
          ),
        ),
      ),
      GoRoute(
        path: history,
        name: 'history',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const HistoryPage(),
        ),
      ),
      GoRoute(
        path: editProfile,
        name: 'editProfile',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const EditProfilePage(),
        ),
      ),
      GoRoute(
        path: device,
        name: 'device',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const DevicePage(),
        ),
      ),
      GoRoute(
        path: settings,
        name: 'settings',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const SettingsPage(),
        ),
      ),
      GoRoute(
        path: notificationSettings,
        name: 'notificationSettings',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const NotificationSettingsPage(),
        ),
      ),
      GoRoute(
        path: deviceSettings,
        name: 'deviceSettings',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const DeviceSettingsPage(),
        ),
      ),
      GoRoute(
        path: privacySettings,
        name: 'privacySettings',
        pageBuilder: (context, state) => _buildPage(
          state: state,
          child: const PrivacySettingsPage(),
        ),
      ),
    ],
  );

  // Custom page transition builder
  static CustomTransitionPage _buildPage({
    required GoRouterState state,
    required Widget child,
    _TransitionType transitionType = _TransitionType.fade,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case _TransitionType.fade:
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          case _TransitionType.scale:
            return ScaleTransition(
              scale: CurveTween(curve: Curves.easeOutBack).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          case _TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(CurveTween(curve: Curves.easeInOut).animate(animation)),
              child: child,
            );
        }
      },
    );
  }
}

enum _TransitionType { fade, scale, slide }
