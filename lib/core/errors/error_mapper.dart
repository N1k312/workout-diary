import 'package:firebase_auth/firebase_auth.dart';

import 'app_exception.dart';

class ErrorMapper {
  ErrorMapper._();

  static AppException fromFirebaseAuth(FirebaseAuthException e) {
    return switch (e.code) {
      'user-not-found' =>
        AuthException('No account found with this email', code: e.code),
      'wrong-password' => AuthException('Wrong password', code: e.code),
      'invalid-credential' =>
        AuthException('Invalid email or password', code: e.code),
      'email-already-in-use' =>
        AuthException('Email already registered', code: e.code),
      'weak-password' => AuthException(
          'Password is too weak (min 6 characters)',
          code: e.code,
        ),
      'invalid-email' =>
        AuthException('Invalid email format', code: e.code),
      'network-request-failed' =>
        NetworkException('No internet connection', code: e.code),
      'too-many-requests' =>
        AuthException('Too many attempts. Try again later', code: e.code),
      'user-disabled' =>
        AuthException('This account has been disabled', code: e.code),
      _ => UnknownException(e.message ?? 'Authentication failed', code: e.code),
    };
  }

  static AppException fromFirebaseFirestore(FirebaseException e) {
    return switch (e.code) {
      'not-found' => NotFoundException('Resource not found', code: e.code),
      'permission-denied' => AuthException('Access denied', code: e.code),
      'unavailable' =>
        NetworkException('Service unavailable', code: e.code),
      'cancelled' => NetworkException('Request cancelled', code: e.code),
      _ => UnknownException(e.message ?? 'Database error', code: e.code),
    };
  }

  static AppException fromAny(Object error) {
    if (error is AppException) return error;
    if (error is FirebaseAuthException) return fromFirebaseAuth(error);
    if (error is FirebaseException) return fromFirebaseFirestore(error);
    return UnknownException(error.toString());
  }
}
