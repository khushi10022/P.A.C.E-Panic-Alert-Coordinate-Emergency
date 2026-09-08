import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// SheShield – Storage Service (Hive)
///
/// Local storage for caching user preferences, onboarding state, etc.
class StorageService {
  static const String _prefsBox = 'preferences';
  static const String _userBox = 'user_data';

  late Box _preferencesBox;
  late Box _userDataBox;

  /// Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    _preferencesBox = await Hive.openBox(_prefsBox);
    _userDataBox = await Hive.openBox(_userBox);
    debugPrint('📦 Hive storage initialized');
  }

  // ──────────────────────────────────────────────
  // Onboarding
  // ──────────────────────────────────────────────
  bool get hasSeenOnboarding =>
      _preferencesBox.get('hasSeenOnboarding', defaultValue: false);

  Future<void> setOnboardingSeen() async {
    await _preferencesBox.put('hasSeenOnboarding', true);
  }

  // ──────────────────────────────────────────────
  // User Session
  // ──────────────────────────────────────────────
  bool get isLoggedIn =>
      _preferencesBox.get('isLoggedIn', defaultValue: false);

  Future<void> setLoggedIn(bool value) async {
    await _preferencesBox.put('isLoggedIn', value);
  }

  String? get userId => _userDataBox.get('userId');

  Future<void> setUserId(String id) async {
    await _userDataBox.put('userId', id);
  }

  // ──────────────────────────────────────────────
  // User Profile Cache
  // ──────────────────────────────────────────────
  String? get userName => _userDataBox.get('userName');

  Future<void> setUserName(String name) async {
    await _userDataBox.put('userName', name);
  }

  String? get userEmail => _userDataBox.get('userEmail');

  Future<void> setUserEmail(String email) async {
    await _userDataBox.put('userEmail', email);
  }

  // ──────────────────────────────────────────────
  // Notification Preferences
  // ──────────────────────────────────────────────
  bool get pushNotificationsEnabled =>
      _preferencesBox.get('pushNotifications', defaultValue: true);

  Future<void> setPushNotifications(bool value) async {
    await _preferencesBox.put('pushNotifications', value);
  }

  bool get soundEnabled =>
      _preferencesBox.get('soundEnabled', defaultValue: true);

  Future<void> setSoundEnabled(bool value) async {
    await _preferencesBox.put('soundEnabled', value);
  }

  bool get vibrationEnabled =>
      _preferencesBox.get('vibrationEnabled', defaultValue: true);

  Future<void> setVibrationEnabled(bool value) async {
    await _preferencesBox.put('vibrationEnabled', value);
  }

  // ──────────────────────────────────────────────
  // Device Settings
  // ──────────────────────────────────────────────
  bool get autoConnect =>
      _preferencesBox.get('autoConnect', defaultValue: true);

  Future<void> setAutoConnect(bool value) async {
    await _preferencesBox.put('autoConnect', value);
  }

  String? get lastDeviceId => _preferencesBox.get('lastDeviceId');

  Future<void> setLastDeviceId(String id) async {
    await _preferencesBox.put('lastDeviceId', id);
  }

  // ──────────────────────────────────────────────
  // Generic Key-Value
  // ──────────────────────────────────────────────
  Future<void> setValue(String key, dynamic value) async {
    await _preferencesBox.put(key, value);
  }

  T? getValue<T>(String key, {T? defaultValue}) {
    return _preferencesBox.get(key, defaultValue: defaultValue);
  }

  // ──────────────────────────────────────────────
  // Clear All
  // ──────────────────────────────────────────────
  Future<void> clearUserData() async {
    await _userDataBox.clear();
    await _preferencesBox.put('isLoggedIn', false);
  }

  Future<void> clearAll() async {
    await _preferencesBox.clear();
    await _userDataBox.clear();
  }
}
