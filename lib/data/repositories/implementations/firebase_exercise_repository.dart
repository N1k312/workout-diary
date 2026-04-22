import 'package:flutter/foundation.dart';

import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../models/enums/equipment.dart';
import '../../models/enums/muscle_group.dart';
import '../../models/exercise_model.dart';
import '../../services/firestore_service.dart';
import '../interfaces/i_exercise_repository.dart';

class FirebaseExerciseRepository implements IExerciseRepository {
  FirebaseExerciseRepository(this._firestore);

  final FirestoreService _firestore;
  static const _collection = 'exercises';

  @override
  Stream<List<ExerciseModel>> watchAllExercises({required String userId}) {
    return _firestore.collectionStream(_collection).map((docs) {
      return docs
          .where((data) {
            final isDeleted = data['isDeleted'] as bool? ?? false;
            if (isDeleted) return false;
            final isCustom = data['isCustom'] as bool? ?? false;
            if (!isCustom) return true;
            return data['createdBy'] == userId;
          })
          .map((data) {
            try {
              return ExerciseModel.fromJson(data);
            } catch (e) {
              debugPrint('Failed to parse exercise ${data['id']}: $e');
              return null;
            }
          })
          .whereType<ExerciseModel>()
          .toList();
    }).handleError((Object error) {
      throw ErrorMapper.fromAny(error);
    });
  }

  @override
  Future<ExerciseModel?> getExercise(String exerciseId) async {
    try {
      final data = await _firestore.getDoc('$_collection/$exerciseId');
      if (data == null) return null;
      return ExerciseModel.fromJson(data);
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<ExerciseModel> createCustomExercise({
    required String userId,
    required String name,
    required MuscleGroup muscleGroup,
    required Equipment equipment,
    String? description,
  }) async {
    try {
      final data = <String, dynamic>{
        'name': name,
        'muscleGroup': muscleGroup.name,
        'equipment': equipment.name,
        'isCustom': true,
        'createdBy': userId,
        'isDeleted': false,
        'description': description,
      };
      final id = await _firestore.addDoc(
        collectionPath: _collection,
        data: data,
      );
      return ExerciseModel.fromJson({'id': id, ...data});
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> updateCustomExercise(ExerciseModel exercise) async {
    try {
      if (!exercise.isCustom) {
        throw const ValidationException('Cannot edit seed exercise');
      }
      final data = exercise.toJson()..remove('id');
      await _firestore.setDoc(
        path: '$_collection/${exercise.id}',
        data: data,
        merge: true,
      );
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }

  @override
  Future<void> deleteCustomExercise({
    required String exerciseId,
    required String userId,
  }) async {
    try {
      final existing = await getExercise(exerciseId);
      if (existing == null) {
        throw const NotFoundException('Exercise not found');
      }
      if (!existing.isCustom || existing.createdBy != userId) {
        throw const ValidationException('Cannot delete this exercise');
      }
      await _firestore.updateDoc(
        path: '$_collection/$exerciseId',
        data: {'isDeleted': true},
      );
    } catch (e) {
      throw ErrorMapper.fromAny(e);
    }
  }
}
