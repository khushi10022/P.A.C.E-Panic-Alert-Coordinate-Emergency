import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

/// SheShield – User Provider
///
/// Manages the current user state across the app.
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  /// Load mock user for development
  void loadMockUser() {
    state = UserModel.mock();
  }

  /// Update user
  void updateUser(UserModel user) {
    state = user;
  }

  /// Update specific fields
  void updateProfile({
    String? name,
    String? phone,
    String? bloodGroup,
    String? medicalInfo,
    String? photoUrl,
  }) {
    if (state == null) return;
    state = state!.copyWith(
      name: name,
      phone: phone,
      bloodGroup: bloodGroup,
      medicalInfo: medicalInfo,
      photoUrl: photoUrl,
      updatedAt: DateTime.now(),
    );
  }

  /// Update safety score
  void updateSafetyScore(int score) {
    if (state == null) return;
    state = state!.copyWith(safetyScore: score);
  }

  /// Clear user data (logout)
  void clear() {
    state = null;
  }
}
