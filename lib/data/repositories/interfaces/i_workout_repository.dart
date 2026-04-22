import '../../models/exercise_in_workout_model.dart';
import '../../models/workout_model.dart';

abstract class IWorkoutRepository {
  /// Stream all workouts for user, sorted by startedAt DESC
  Stream<List<WorkoutModel>> watchWorkouts({required String userId});

  /// Stream a single workout by ID
  Stream<WorkoutModel?> watchWorkout({
    required String userId,
    required String workoutId,
  });

  /// One-shot fetch of the active (unfinished) workout, if any.
  /// Used on app launch to show "Resume workout" banner (ADR-28).
  Future<WorkoutModel?> getActiveWorkout({required String userId});

  /// Create a new workout with pre-selected exercises; returns it with Firestore ID
  Future<WorkoutModel> startWorkout({
    required String userId,
    required String name,
    required List<ExerciseInWorkoutModel> exercises,
  });

  /// Update the whole workout (used for live-editing sets during active workout).
  /// Does NOT compute totalVolume/duration — those are set only on finish.
  Future<void> updateWorkout({
    required String userId,
    required WorkoutModel workout,
  });

  /// Finish the workout — sets finishedAt, computes totalVolume and duration.
  /// Returns the finished workout.
  Future<WorkoutModel> finishWorkout({
    required String userId,
    required WorkoutModel workout,
  });

  /// Hard delete per ADR-26 — workouts have no downstream deps
  Future<void> deleteWorkout({
    required String userId,
    required String workoutId,
  });
}
