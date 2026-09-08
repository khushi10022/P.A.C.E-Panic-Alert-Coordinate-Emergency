/// SheShield – Asset Path Constants
///
/// Centralized asset paths for images, icons, and animations.
class AppAssets {
  AppAssets._();

  // ──────────────────────────────────────────────
  // Base Paths
  // ──────────────────────────────────────────────
  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';
  static const String _animations = 'assets/animations';

  // ──────────────────────────────────────────────
  // Images
  // ──────────────────────────────────────────────
  static const String logo = '$_images/logo.png';
  static const String logoWhite = '$_images/logo_white.png';
  static const String onboarding1 = '$_images/onboarding_1.png';
  static const String onboarding2 = '$_images/onboarding_2.png';
  static const String onboarding3 = '$_images/onboarding_3.png';
  static const String authIllustration = '$_images/auth_illustration.png';
  static const String profilePlaceholder = '$_images/profile_placeholder.png';
  static const String emptyState = '$_images/empty_state.png';
  static const String smartBand = '$_images/smart_band.png';
  static const String safetyShield = '$_images/safety_shield.png';

  // ──────────────────────────────────────────────
  // Icons
  // ──────────────────────────────────────────────
  static const String iconSos = '$_icons/sos.svg';
  static const String iconTracking = '$_icons/tracking.svg';
  static const String iconRoute = '$_icons/route.svg';
  static const String iconCheckIn = '$_icons/check_in.svg';
  static const String iconHealth = '$_icons/health.svg';
  static const String iconBluetooth = '$_icons/bluetooth.svg';
  static const String iconShield = '$_icons/shield.svg';

  // ──────────────────────────────────────────────
  // Lottie Animations
  // ──────────────────────────────────────────────
  static const String animSplash = '$_animations/splash.json';
  static const String animSos = '$_animations/sos_pulse.json';
  static const String animLocation = '$_animations/location.json';
  static const String animSuccess = '$_animations/success.json';
  static const String animScanning = '$_animations/scanning.json';
  static const String animLoading = '$_animations/loading.json';
  static const String animEmptyState = '$_animations/empty_state.json';
  static const String animShield = '$_animations/shield.json';
}
