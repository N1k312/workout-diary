import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_in_workout_model.dart';

part 'workout_model.freezed.dart';
part 'workout_model.g.dart';

@freezed
abstract class WorkoutModel with _$WorkoutModel {
  const factory WorkoutModel({
    required String id,
    required String name,
    required DateTime startedAt,
    DateTime? finishedAt,
    @Default(0) int duration,
    @Default(0.0) double totalVolume,
    String? notes,
    @Default(<ExerciseInWorkoutModel>[]) List<ExerciseInWorkoutModel> exercises,
  }) = _WorkoutModel;

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);
}

extension WorkoutModelX on WorkoutModel {
  bool get isActive => finishedAt == null;
  bool get isFinished => finishedAt != null;

  /// Compute total volume from current sets state (use before saving)
  double computeTotalVolume() {
    return exercises.fold(0.0, (sum, ex) => sum + ex.totalVolume);
  }

  /// Compute duration from startedAt to finishedAt (or now if still active)
  int computeDurationSeconds() {
    final end = finishedAt ?? DateTime.now();
    return end.difference(startedAt).inSeconds;
  }

  int get totalCompletedSets =>
      exercises.fold(0, (sum, ex) => sum + ex.completedSetsCount);
}
