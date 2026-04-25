// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_in_workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseInWorkoutModel _$ExerciseInWorkoutModelFromJson(
  Map<String, dynamic> json,
) => _ExerciseInWorkoutModel(
  exerciseId: json['exerciseId'] as String,
  exerciseName: json['exerciseName'] as String,
  order: (json['order'] as num).toInt(),
  sets:
      (json['sets'] as List<dynamic>?)
          ?.map((e) => SetModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SetModel>[],
);

Map<String, dynamic> _$ExerciseInWorkoutModelToJson(
  _ExerciseInWorkoutModel instance,
) => <String, dynamic>{
  'exerciseId': instance.exerciseId,
  'exerciseName': instance.exerciseName,
  'order': instance.order,
  'sets': instance.sets.map((e) => e.toJson()).toList(),
};
