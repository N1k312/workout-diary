import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/error_mapper.dart';
import '../../models/app_user.dart';
import '../../services/auth_service.dart';
import '../interfaces/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(this._authService);

  final AuthService _authService;

  @override
  Stream<AppUser?> authStateChanges() {
    return _authService.authStateChanges().map(
          (user) => user != null ? AppUser.fromFirebaseUser(user) : null,
        );
  }

  @override
  AppUser? get currentUser {
    final user = _authService.currentUser;
    return user != null ? AppUser.fromFirebaseUser(user) : null;
  }

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.fromFirebaseAuth(e);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<AppUser> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AppUser.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.fromFirebaseAuth(e);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.fromFirebaseAuth(e);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.fromFirebaseAuth(e);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _authService.deleteAccount();
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.fromFirebaseAuth(e);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }
}
