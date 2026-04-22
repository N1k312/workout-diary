import '../../models/personal_record_model.dart';
import '../../models/workout_model.dart';

abstract class IProgressRepository {
  /// Stream all personal records for user, sorted by updatedAt DESC
  Stream<List<PersonalRecordModel>> watchAllPRs({required String userId});

  /// One-shot fetch of a PR for specific exercise; null if not set yet
  Future<PersonalRecordModel?> getPR({
    required String userId,
    required String exerciseId,
  });

  /// Check a finished set against current PR. If it beats PR, update and return true.
  /// Returns false if not a new PR.
  Future<bool> checkAndUpdatePR({
    required String userId,
    required String exerciseId,
    required double weight,
    required int reps,
    required String workoutId,
  });

  /// Detect all PRs in a finished workout and update them atomically.
  /// Returns the list of exerciseIds that got new PRs (for congrats sheet).
  Future<List<String>> detectPRsInWorkout({
    required String userId,
    required WorkoutModel workout,
  });

  /// Stream the set history for a single exercise for progress chart plotting.
  /// Returns one point per finished workout, sorted by date ASC.
  Stream<List<ExerciseHistoryPoint>> watchExerciseHistory({
    required String userId,
    required String exerciseId,
  });
}

/// View model for progress chart — not a Firestore doc
class ExerciseHistoryPoint {
  const ExerciseHistoryPoint({
    required this.date,
    required this.weight,
    required this.reps,
    required this.estimatedOneRM,
    required this.workoutId,
  });

  final DateTime date;
  final double weight;
  final int reps;
  final double estimatedOneRM;
  final String workoutId;
}
