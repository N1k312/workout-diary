import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_exception.dart';
import '../../../data/models/exercise_in_workout_model.dart';
import '../../../data/models/exercise_model.dart';
import '../../../data/models/workout_model.dart';
import '../../../data/providers/repository_providers.dart';
import '../../auth/providers/auth_providers.dart';

// ---------------------------------------------------------------------------
// All workouts stream
// ---------------------------------------------------------------------------

final workoutsProvider = StreamProvider<List<WorkoutModel>>((ref) {
  final user = ref.watch(authStateProvider).asData?.value;
  if (user == null) return Stream.value(<WorkoutModel>[]);
  return ref.watch(workoutRepositoryProvider).watchWorkouts(userId: user.uid);
});

// ---------------------------------------------------------------------------
// Active (unfinished) workout — used for Resume banner (ADR-28)
// ---------------------------------------------------------------------------

final activeWorkoutProvider = FutureProvider<WorkoutModel?>((ref) async {
  final user = ref.watch(authStateProvider).asData?.value;
  if (user == null) return null;
  return ref
      .watch(workoutRepositoryProvider)
      .getActiveWorkout(userId: user.uid);
});

// ---------------------------------------------------------------------------
// Single workout by ID — for Workout Detail screen
// ---------------------------------------------------------------------------

final workoutByIdProvider =
    StreamProvider.family<WorkoutModel?, String>((ref, workoutId) {
  final user = ref.watch(authStateProvider).asData?.value;
  if (user == null) return Stream.value(null);
  return ref.watch(workoutRepositoryProvider).watchWorkout(
        userId: user.uid,
        workoutId: workoutId,
      );
});

// ---------------------------------------------------------------------------
// Start workout notifier
// ---------------------------------------------------------------------------

class WorkoutStartNotifier extends AsyncNotifier<WorkoutModel?> {
  @override
  Future<WorkoutModel?> build() async => null;

  /// Start a new workout with given name and exercises.
  /// Returns the created workout with Firestore-generated ID.
  Future<WorkoutModel?> startWorkout({
    required String name,
    required List<ExerciseModel> exercises,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final user = ref.read(authStateProvider).asData?.value;
      if (user == null) throw const AuthException('Not signed in');

      // Convert ExerciseModel → ExerciseInWorkoutModel, denormalizing name per ADR-12
      final exercisesInWorkout = exercises.indexed.map((entry) {
        final (index, ex) = entry;
        return ExerciseInWorkoutModel(
          exerciseId: ex.id,
          exerciseName: ex.name,
          order: index,
          sets: const [],
        );
      }).toList();

      return ref.read(workoutRepositoryProvider).startWorkout(
            userId: user.uid,
            name: name.trim().isEmpty ? 'Workout' : name.trim(),
            exercises: exercisesInWorkout,
          );
    });
    state = result;
    return result.asData?.value;
  }
}

final workoutStartNotifierProvider =
    AsyncNotifierProvider<WorkoutStartNotifier, WorkoutModel?>(
  WorkoutStartNotifier.new,
);
