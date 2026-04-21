import '../../../data/models/app_user.dart';

abstract class IAuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  });
  Future<AppUser> registerWithEmail({
    required String email,
    required String password,
  });
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();
  Future<void> deleteAccount();
}
