import '../../../core/errors/error_mapper.dart';
import '../../models/enums/units.dart';
import '../../models/user_profile_model.dart';
import '../../services/firestore_service.dart';
import '../interfaces/i_user_repository.dart';

class FirebaseUserRepository implements IUserRepository {
  FirebaseUserRepository(this._firestore);

  final FirestoreService _firestore;

  String _path(String userId) => 'users/$userId';

  @override
  Stream<UserProfileModel?> watchProfile({required String userId}) {
    return _firestore
        .docStream(_path(userId))
        .map((data) {
          if (data == null) return null;
          return UserProfileModel.fromJson(data);
        })
        .handleError((Object error) {
          throw ErrorMapper.fromAny(error);
        });
  }

  @override
  Future<UserProfileModel?> getProfile({required String userId}) async {
    try {
      final data = await _firestore.getDoc(_path(userId));
      if (data == null) return null;
      return UserProfileModel.fromJson(data);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<UserProfileModel> createInitialProfile({
    required String userId,
    required String email,
  }) async {
    try {
      final profile = UserProfileModel.initial(uid: userId, email: email);
      // uid is the document ID; also stored in doc body for convenience
      await _firestore.setDoc(path: _path(userId), data: profile.toJson());
      return profile;
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> updateProfile(UserProfileModel profile) async {
    try {
      await _firestore.setDoc(
        path: _path(profile.uid),
        data: profile.toJson(),
        merge: true,
      );
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> updateSettings({
    required String userId,
    Units? units,
    int? defaultRestTimer,
    bool? soundEnabled,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (units != null) updates['units'] = units.name;
      if (defaultRestTimer != null) updates['defaultRestTimer'] = defaultRestTimer;
      if (soundEnabled != null) updates['soundEnabled'] = soundEnabled;
      if (updates.isEmpty) return;
      await _firestore.updateDoc(path: _path(userId), data: updates);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }
}
