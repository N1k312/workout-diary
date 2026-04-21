import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/implementations/firebase_auth_repository.dart';
import '../repositories/interfaces/i_auth_repository.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final service = ref.watch(authServiceProvider);
  return FirebaseAuthRepository(service);
});
