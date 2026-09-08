/// P.A.C.E. – All Application Strings
/// 
/// Centralized string constants for consistent copy across the app.
class AppStrings {
  AppStrings._();

  // ──────────────────────────────────────────────
  // App Identity
  // ──────────────────────────────────────────────
  static const String appName = 'P.A.C.E.';
  static const String tagline = 'Panic Alert & Coordinate Emergency';
  static const String appDescription =
      'AI-Enabled Smart Women\'s Safety Wearable System — automatic distress detection, instant BLE alerts, and real-time live tracking.';

  // ──────────────────────────────────────────────
  // Splash
  // ──────────────────────────────────────────────
  static const String splashSubtitle = 'AI-Enabled Smart Women\'s Safety Wearable System';

  // ──────────────────────────────────────────────
  // Onboarding
  // ──────────────────────────────────────────────
  static const String onboardingTitle1 = 'Stay Protected';
  static const String onboardingDesc1 =
      'Your personal wearable safety companion that watches over you — always connected, always ready.';
  
  static const String onboardingTitle2 = 'Instant SOS';
  static const String onboardingDesc2 =
      'Trigger emergency alerts with a single tap or automatically through your smart band. Help is always one moment away.';
  
  static const String onboardingTitle3 = 'Live Location Sharing';
  static const String onboardingDesc3 =
      'Share your real-time location with trusted contacts during emergencies. Let your loved ones know you\'re safe.';

  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String getStarted = 'Get Started';
  static const String back = 'Back';

  // ──────────────────────────────────────────────
  // Authentication
  // ──────────────────────────────────────────────
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to your safe space';
  static const String createAccount = 'Create Account';
  static const String registerSubtitle = 'Join the P.A.C.E. community';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String forgotPassword = 'Forgot Password?';
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String signInWithGoogle = 'Continue with Google';
  static const String orContinueWith = 'or continue with';
  static const String dontHaveAccount = 'Don\'t have an account? ';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordDesc =
      'Enter your email and we\'ll send you a link to reset your password.';
  static const String sendResetLink = 'Send Reset Link';
  static const String passwordResetSent = 'Password reset link sent to your email!';

  // ──────────────────────────────────────────────
  // Dashboard
  // ──────────────────────────────────────────────
  static const String goodMorning = 'Good Morning';
  static const String goodAfternoon = 'Good Afternoon';
  static const String goodEvening = 'Good Evening';
  static const String currentLocation = 'Current Location';
  static const String smartBand = 'Smart Band';
  static const String connected = 'Connected';
  static const String disconnected = 'Disconnected';
  static const String connecting = 'Connecting...';
  static const String battery = 'Battery';
  static const String quickActions = 'Quick Actions';

  // Quick Action Labels
  static const String emergencySos = 'Emergency SOS';
  static const String liveTracking = 'Live Tracking';
  static const String safeRoute = 'Safe Route';
  static const String checkIn = 'Check In';
  static const String healthStatus = 'Health Status';

  // ──────────────────────────────────────────────
  // Emergency SOS
  // ──────────────────────────────────────────────
  static const String sosTitle = 'Emergency SOS';
  static const String sosInstruction = 'Press & hold for 3 seconds to activate';
  static const String sosActivating = 'Activating SOS...';
  static const String sosActive = 'SOS Active';
  static const String sosCancelled = 'SOS Cancelled';
  static const String cancelSos = 'Cancel SOS';
  static const String sosCountdown = 'Sending alert in';
  static const String sosAlertSent = 'Emergency alert sent to your contacts!';
  static const String sosHoldButton = 'HOLD';

  // ──────────────────────────────────────────────
  // Live Tracking
  // ──────────────────────────────────────────────
  static const String trackingTitle = 'Live Tracking';
  static const String startTracking = 'Start Tracking';
  static const String stopTracking = 'Stop Tracking';
  static const String shareLocation = 'Share Location';
  static const String estimatedArrival = 'Estimated Arrival';
  static const String distance = 'Distance';
  static const String duration = 'Duration';

  // ──────────────────────────────────────────────
  // Bluetooth
  // ──────────────────────────────────────────────
  static const String bluetoothTitle = 'Smart Band';
  static const String scanDevices = 'Scan for Devices';
  static const String scanning = 'Scanning...';
  static const String noDevicesFound = 'No devices found nearby';
  static const String connectDevice = 'Connect';
  static const String disconnectDevice = 'Disconnect';
  static const String deviceConnected = 'Device Connected Successfully!';
  static const String firmwareVersion = 'Firmware Version';
  static const String signalStrength = 'Signal Strength';

  // ──────────────────────────────────────────────
  // Contacts
  // ──────────────────────────────────────────────
  static const String emergencyContacts = 'Emergency Contacts';
  static const String addContact = 'Add Contact';
  static const String editContact = 'Edit Contact';
  static const String deleteContact = 'Delete Contact';
  static const String contactName = 'Contact Name';
  static const String relationship = 'Relationship';
  static const String primaryGuardian = 'Primary Guardian';
  static const String setPrimary = 'Set as Primary';
  static const String callContact = 'Call';
  static const String deleteConfirm = 'Are you sure you want to delete this contact?';

  // ──────────────────────────────────────────────
  // History
  // ──────────────────────────────────────────────
  static const String emergencyHistory = 'Emergency History';
  static const String noHistory = 'No emergency events recorded';
  static const String viewOnMap = 'View on Map';
  static const String resolved = 'Resolved';
  static const String pending = 'Pending';

  // ──────────────────────────────────────────────
  // Profile
  // ──────────────────────────────────────────────
  static const String profile = 'Profile';
  static const String editProfile = 'Edit Profile';
  static const String bloodGroup = 'Blood Group';
  static const String medicalInfo = 'Medical Information';
  static const String connectedDevice = 'Connected Device';
  static const String safetyScore = 'Safety Score';
  static const String saveChanges = 'Save Changes';

  // ──────────────────────────────────────────────
  // Settings
  // ──────────────────────────────────────────────
  static const String settings = 'Settings';
  static const String profileSettings = 'Profile Settings';
  static const String notificationSettings = 'Notification Settings';
  static const String deviceSettings = 'Device Settings';
  static const String privacy = 'Privacy';
  static const String pushNotifications = 'Push Notifications';
  static const String sound = 'Sound';
  static const String vibration = 'Vibration';
  static const String autoConnect = 'Auto Connect';
  static const String firmwareUpdate = 'Firmware Update';
  static const String batteryOptimization = 'Battery Optimization';
  static const String permissionManagement = 'Permission Management';
  static const String dataSharingPrefs = 'Data Sharing Preferences';
  static const String deleteAccount = 'Delete Account';
  static const String logout = 'Log Out';
  static const String about = 'About P.A.C.E.';
  static const String version = 'Version';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';

  // ──────────────────────────────────────────────
  // Bottom Navigation
  // ──────────────────────────────────────────────
  static const String navHome = 'Home';
  static const String navTracking = 'Tracking';
  static const String navSos = 'SOS';
  static const String navContacts = 'Contacts';
  static const String navProfile = 'Profile';

  // ──────────────────────────────────────────────
  // General
  // ──────────────────────────────────────────────
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String loading = 'Loading...';
  static const String error = 'Something went wrong';
  static const String retry = 'Retry';
  static const String noInternet = 'No internet connection';
  static const String permissionDenied = 'Permission denied';
}
