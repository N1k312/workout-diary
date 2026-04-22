import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/equipment.dart';
import 'enums/muscle_group.dart';

part 'exercise_model.freezed.dart';
part 'exercise_model.g.dart';

@freezed
abstract class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required String id,
    required String name,
    required MuscleGroup muscleGroup,
    required Equipment equipment,
    @Default(false) bool isCustom,
    String? createdBy,
    @Default(false) bool isDeleted,
    String? description,
  }) = _ExerciseModel;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);
}
