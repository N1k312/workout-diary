// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalRecordModel _$PersonalRecordModelFromJson(Map<String, dynamic> json) =>
    _PersonalRecordModel(
      exerciseId: json['exerciseId'] as String,
      estimatedOneRM: (json['estimatedOneRM'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      reps: (json['reps'] as num).toInt(),
      workoutId: json['workoutId'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PersonalRecordModelToJson(
  _PersonalRecordModel instance,
) => <String, dynamic>{
  'exerciseId': instance.exerciseId,
  'estimatedOneRM': instance.estimatedOneRM,
  'weight': instance.weight,
  'reps': instance.reps,
  'workoutId': instance.workoutId,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
