// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutModel _$WorkoutModelFromJson(Map<String, dynamic> json) =>
    _WorkoutModel(
      id: json['id'] as String,
      name: json['name'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      totalVolume: (json['totalVolume'] as num?)?.toDouble() ?? 0.0,
      notes: json['notes'] as String?,
      exercises:
          (json['exercises'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ExerciseInWorkoutModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ExerciseInWorkoutModel>[],
    );

Map<String, dynamic> _$WorkoutModelToJson(_WorkoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startedAt': instance.startedAt.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'duration': instance.duration,
      'totalVolume': instance.totalVolume,
      'notes': instance.notes,
      'exercises': instance.exercises,
    };
