import 'package:flutter/foundation.dart';

import '../../../core/errors/error_mapper.dart';
import '../../models/exercise_in_workout_model.dart';
import '../../models/workout_model.dart';
import '../../services/firestore_service.dart';
import '../interfaces/i_workout_repository.dart';

class FirebaseWorkoutRepository implements IWorkoutRepository {
  FirebaseWorkoutRepository(this._firestore);

  final FirestoreService _firestore;

  String _workoutsPath(String userId) => 'users/$userId/workouts';
  String _workoutPath(String userId, String workoutId) =>
      'users/$userId/workouts/$workoutId';

  @override
  Stream<List<WorkoutModel>> watchWorkouts({required String userId}) {
    return _firestore
        .collectionStream(
          _workoutsPath(userId),
          queryBuilder: (q) => q.orderBy('startedAt', descending: true),
        )
        .map((docs) {
          return docs.map((data) {
            try {
              return WorkoutModel.fromJson(data);
            } catch (e) {
              debugPrint('Failed to parse workout ${data['id']}: $e');
              return null;
            }
          }).whereType<WorkoutModel>().toList();
        })
        .handleError((Object error) {
          throw ErrorMapper.fromAny(error);
        });
  }

  @override
  Stream<WorkoutModel?> watchWorkout({
    required String userId,
    required String workoutId,
  }) {
    return _firestore
        .docStream(_workoutPath(userId, workoutId))
        .map((data) {
          if (data == null) return null;
          return WorkoutModel.fromJson(data);
        })
        .handleError((Object error) {
          throw ErrorMapper.fromAny(error);
        });
  }

  @override
  Future<WorkoutModel?> getActiveWorkout({required String userId}) async {
    try {
      final docs = await _firestore.getCollection(
        _workoutsPath(userId),
        queryBuilder: (q) => q.where('finishedAt', isNull: true).limit(1),
      );
      if (docs.isEmpty) return null;
      return WorkoutModel.fromJson(docs.first);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<WorkoutModel> startWorkout({
    required String userId,
    required String name,
    required List<ExerciseInWorkoutModel> exercises,
  }) async {
    try {
      final workout = WorkoutModel(
        id: '',
        name: name,
        startedAt: DateTime.now(),
        exercises: exercises,
      );
      final data = workout.toJson()..remove('id');
      debugPrint('[repo.startWorkout] data to write: $data');
      final id = await _firestore.addDoc(
        collectionPath: _workoutsPath(userId),
        data: data,
      );
      debugPrint('[repo.startWorkout] addDoc returned id=$id');
      return workout.copyWith(id: id);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> updateWorkout({
    required String userId,
    required WorkoutModel workout,
  }) async {
    try {
      final data = workout.toJson()..remove('id');
      await _firestore.setDoc(
        path: _workoutPath(userId, workout.id),
        data: data,
        merge: true,
      );
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<WorkoutModel> finishWorkout({
    required String userId,
    required WorkoutModel workout,
  }) async {
    try {
      final now = DateTime.now();
      // Precompute fields per ADR-63 — written once, read many
      final finished = workout.copyWith(
        finishedAt: now,
        duration: now.difference(workout.startedAt).inSeconds,
        totalVolume: workout.computeTotalVolume(),
      );
      final data = finished.toJson()..remove('id');
      await _firestore.setDoc(
        path: _workoutPath(userId, workout.id),
        data: data,
        merge: true,
      );
      return finished;
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> deleteWorkout({
    required String userId,
    required String workoutId,
  }) async {
    try {
      await _firestore.deleteDoc(_workoutPath(userId, workoutId));
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }
}
