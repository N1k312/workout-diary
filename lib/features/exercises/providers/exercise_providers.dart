import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/enums/muscle_group.dart';
import '../../../data/models/exercise_model.dart';
import '../../../data/providers/repository_providers.dart';
import '../../auth/providers/auth_providers.dart';
import 'exercise_filter_state.dart';

// ---------------------------------------------------------------------------
// Raw stream — all exercises for the current user
// ---------------------------------------------------------------------------

final allExercisesProvider = StreamProvider<List<ExerciseModel>>((ref) {
  final user = ref.watch(authStateProvider).asData?.value;
  if (user == null) return Stream.value(<ExerciseModel>[]);
  return ref.watch(exerciseRepositoryProvider).watchAllExercises(
        userId: user.uid,
      );
});

// ---------------------------------------------------------------------------
// Filter state
// ---------------------------------------------------------------------------

class ExerciseFilterNotifier extends Notifier<ExerciseFilterState> {
  @override
  ExerciseFilterState build() => const ExerciseFilterState();

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setMuscleGroup(MuscleGroup? group) {
    state = state.copyWith(selectedMuscleGroup: group);
  }

  void clearFilters() {
    state = const ExerciseFilterState();
  }
}

final exerciseFilterProvider =
    NotifierProvider<ExerciseFilterNotifier, ExerciseFilterState>(
  ExerciseFilterNotifier.new,
);

// ---------------------------------------------------------------------------
// Filtered list
// ---------------------------------------------------------------------------

final filteredExercisesProvider =
    Provider<AsyncValue<List<ExerciseModel>>>((ref) {
  final exercises = ref.watch(allExercisesProvider);
  final filter = ref.watch(exerciseFilterProvider);

  return exercises.whenData((list) {
    Iterable<ExerciseModel> result = list;

    if (filter.selectedMuscleGroup != null) {
      result = result.where((e) => e.muscleGroup == filter.selectedMuscleGroup);
    }

    if (filter.searchQuery.isNotEmpty) {
      final q = filter.searchQuery.toLowerCase();
      result = result.where((e) => e.name.toLowerCase().contains(q));
    }

    return result.toList();
  });
});

// ---------------------------------------------------------------------------
// Grouped by muscle group (for Library screen)
// ---------------------------------------------------------------------------

final groupedExercisesProvider =
    Provider<AsyncValue<Map<MuscleGroup, List<ExerciseModel>>>>((ref) {
  final filtered = ref.watch(filteredExercisesProvider);

  return filtered.whenData((list) {
    final map = <MuscleGroup, List<ExerciseModel>>{};
    for (final ex in list) {
      (map[ex.muscleGroup] ??= []).add(ex);
    }
    for (final group in map.values) {
      group.sort((a, b) => a.name.compareTo(b.name));
    }
    return map;
  });
});

// ---------------------------------------------------------------------------
// Single exercise by ID
// ---------------------------------------------------------------------------

final exerciseByIdProvider =
    FutureProvider.family<ExerciseModel?, String>((ref, exerciseId) {
  return ref.watch(exerciseRepositoryProvider).getExercise(exerciseId);
});
