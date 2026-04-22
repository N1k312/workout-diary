import 'package:freezed_annotation/freezed_annotation.dart';

import 'set_model.dart';

part 'exercise_in_workout_model.freezed.dart';
part 'exercise_in_workout_model.g.dart';

@freezed
abstract class ExerciseInWorkoutModel with _$ExerciseInWorkoutModel {
  const factory ExerciseInWorkoutModel({
    required String exerciseId,
    required String exerciseName,
    required int order,
    @Default(<SetModel>[]) List<SetModel> sets,
  }) = _ExerciseInWorkoutModel;

  factory ExerciseInWorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseInWorkoutModelFromJson(json);
}

extension ExerciseInWorkoutModelX on ExerciseInWorkoutModel {
  /// Sum of volume across all completed sets
  double get totalVolume =>
      sets.where((s) => s.isCompleted).fold(0.0, (sum, s) => sum + s.volume);

  int get completedSetsCount => sets.where((s) => s.isCompleted).length;
}
