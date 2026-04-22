import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/implementations/firebase_exercise_repository.dart';
import '../repositories/interfaces/i_exercise_repository.dart';
import 'firestore_providers.dart';

final exerciseRepositoryProvider = Provider<IExerciseRepository>((ref) {
  return FirebaseExerciseRepository(ref.watch(firestoreServiceProvider));
});
