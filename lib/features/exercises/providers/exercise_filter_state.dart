import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/enums/muscle_group.dart';

part 'exercise_filter_state.freezed.dart';

@freezed
abstract class ExerciseFilterState with _$ExerciseFilterState {
  const factory ExerciseFilterState({
    @Default('') String searchQuery,
    MuscleGroup? selectedMuscleGroup,
  }) = _ExerciseFilterState;
}
