import '../../models/enums/equipment.dart';
import '../../models/enums/muscle_group.dart';
import '../../models/exercise_model.dart';

abstract class IExerciseRepository {
  /// Stream of all non-deleted exercises (seed + current user's custom)
  Stream<List<ExerciseModel>> watchAllExercises({required String userId});

  /// One-shot fetch of a single exercise by ID; returns null if not found
  Future<ExerciseModel?> getExercise(String exerciseId);

  /// Create a custom exercise owned by userId.
  /// Returns the created ExerciseModel with Firestore-generated ID.
  Future<ExerciseModel> createCustomExercise({
    required String userId,
    required String name,
    required MuscleGroup muscleGroup,
    required Equipment equipment,
    String? description,
  });

  /// Update a custom exercise (only works if createdBy == userId)
  Future<void> updateCustomExercise(ExerciseModel exercise);

  /// Soft delete (sets isDeleted=true) — only for custom exercises
  Future<void> deleteCustomExercise({
    required String exerciseId,
    required String userId,
  });
}
