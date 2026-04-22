import '../../models/enums/units.dart';
import '../../models/user_profile_model.dart';

abstract class IUserRepository {
  /// Stream the user profile document
  Stream<UserProfileModel?> watchProfile({required String userId});

  /// One-shot fetch
  Future<UserProfileModel?> getProfile({required String userId});

  /// Create initial profile right after registration
  Future<UserProfileModel> createInitialProfile({
    required String userId,
    required String email,
  });

  /// Update profile (name, goal, settings, etc.)
  Future<void> updateProfile(UserProfileModel profile);

  /// Update only the settings portion (units, defaultRestTimer, soundEnabled).
  /// Convenience method for settings toggles — only writes provided fields.
  Future<void> updateSettings({
    required String userId,
    Units? units,
    int? defaultRestTimer,
    bool? soundEnabled,
  });
}
