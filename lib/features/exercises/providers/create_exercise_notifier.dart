import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_exception.dart';
import '../../../data/models/enums/equipment.dart';
import '../../../data/models/enums/muscle_group.dart';
import '../../../data/models/exercise_model.dart';
import '../../../data/providers/repository_providers.dart';
import '../../auth/providers/auth_providers.dart';

class CreateExerciseNotifier extends AsyncNotifier<ExerciseModel?> {
  @override
  Future<ExerciseModel?> build() async => null;

  Future<ExerciseModel?> create({
    required String name,
    required MuscleGroup muscleGroup,
    required Equipment equipment,
    String? description,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final user = ref.read(authStateProvider).asData?.value;
      if (user == null) throw const AuthException('Not signed in');
      final repo = ref.read(exerciseRepositoryProvider);
      final trimmedDesc =
          description?.trim().isEmpty ?? true ? null : description?.trim();
      return repo.createCustomExercise(
        userId: user.uid,
        name: name.trim(),
        muscleGroup: muscleGroup,
        equipment: equipment,
        description: trimmedDesc,
      );
    });
    state = result;
    return result.asData?.value;
  }
}

final createExerciseNotifierProvider =
    AsyncNotifierProvider<CreateExerciseNotifier, ExerciseModel?>(
  CreateExerciseNotifier.new,
);
