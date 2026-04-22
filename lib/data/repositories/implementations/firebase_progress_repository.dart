import 'package:flutter/foundation.dart';

import '../../../core/errors/error_mapper.dart';
import '../../models/personal_record_model.dart';
import '../../models/workout_model.dart';
import '../../services/firestore_service.dart';
import '../interfaces/i_progress_repository.dart';
import '../interfaces/i_workout_repository.dart';

class FirebaseProgressRepository implements IProgressRepository {
  FirebaseProgressRepository(this._firestore, this._workoutRepo);

  final FirestoreService _firestore;
  final IWorkoutRepository _workoutRepo;

  String _prsPath(String userId) => 'users/$userId/personalRecords';
  String _prPath(String userId, String exerciseId) =>
      'users/$userId/personalRecords/$exerciseId';

  /// Epley formula per ADR-27
  double _epleyOneRM(double weight, int reps) => weight * (1 + reps / 30);

  @override
  Stream<List<PersonalRecordModel>> watchAllPRs({required String userId}) {
    return _firestore
        .collectionStream(
          _prsPath(userId),
          queryBuilder: (q) => q.orderBy('updatedAt', descending: true),
        )
        .map((docs) {
          return docs.map((data) {
            try {
              // Doc ID equals exerciseId in the PR collection
              return PersonalRecordModel.fromJson({
                ...data,
                'exerciseId': data['id'] ?? data['exerciseId'],
              });
            } catch (e) {
              debugPrint('Failed to parse PR ${data['id']}: $e');
              return null;
            }
          }).whereType<PersonalRecordModel>().toList();
        })
        .handleError((Object error) {
          throw ErrorMapper.fromAny(error);
        });
  }

  @override
  Future<PersonalRecordModel?> getPR({
    required String userId,
    required String exerciseId,
  }) async {
    try {
      final data = await _firestore.getDoc(_prPath(userId, exerciseId));
      if (data == null) return null;
      return PersonalRecordModel.fromJson({...data, 'exerciseId': exerciseId});
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<bool> checkAndUpdatePR({
    required String userId,
    required String exerciseId,
    required double weight,
    required int reps,
    required String workoutId,
  }) async {
    try {
      final newOneRM = _epleyOneRM(weight, reps);
      final current = await getPR(userId: userId, exerciseId: exerciseId);

      if (current != null && newOneRM <= current.estimatedOneRM) return false;

      final pr = PersonalRecordModel(
        exerciseId: exerciseId,
        estimatedOneRM: newOneRM,
        weight: weight,
        reps: reps,
        workoutId: workoutId,
        updatedAt: DateTime.now(),
      );

      // exerciseId is the doc path — don't write it into the body
      final data = pr.toJson()
        ..remove('id')
        ..remove('exerciseId');

      await _firestore.setDoc(path: _prPath(userId, exerciseId), data: data);
      return true;
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<List<String>> detectPRsInWorkout({
    required String userId,
    required WorkoutModel workout,
  }) async {
    try {
      final newPRs = <String>[];

      for (final ex in workout.exercises) {
        final completedSets = ex.sets.where((s) => s.isCompleted).toList();
        if (completedSets.isEmpty) continue;

        // Best set = highest estimated 1RM in this exercise
        completedSets.sort(
          (a, b) => b.estimatedOneRM.compareTo(a.estimatedOneRM),
        );
        final best = completedSets.first;

        final updated = await checkAndUpdatePR(
          userId: userId,
          exerciseId: ex.exerciseId,
          weight: best.weight,
          reps: best.reps,
          workoutId: workout.id,
        );

        if (updated) newPRs.add(ex.exerciseId);
      }

      return newPRs;
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Stream<List<ExerciseHistoryPoint>> watchExerciseHistory({
    required String userId,
    required String exerciseId,
  }) {
    return _workoutRepo.watchWorkouts(userId: userId).map((workouts) {
      final points = <ExerciseHistoryPoint>[];

      for (final w in workouts) {
        if (w.finishedAt == null) continue;

        for (final ex in w.exercises) {
          if (ex.exerciseId != exerciseId) continue;

          final completed = ex.sets.where((s) => s.isCompleted).toList();
          if (completed.isEmpty) continue;

          // One data point per workout — the best set
          completed.sort(
            (a, b) => b.estimatedOneRM.compareTo(a.estimatedOneRM),
          );
          final best = completed.first;

          points.add(ExerciseHistoryPoint(
            date: w.finishedAt!,
            weight: best.weight,
            reps: best.reps,
            estimatedOneRM: best.estimatedOneRM,
            workoutId: w.id,
          ));
        }
      }

      // Oldest first for chart plotting
      points.sort((a, b) => a.date.compareTo(b.date));
      return points;
    });
  }
}
