// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SetModel _$SetModelFromJson(Map<String, dynamic> json) => _SetModel(
  weight: (json['weight'] as num).toDouble(),
  reps: (json['reps'] as num).toInt(),
  isCompleted: json['isCompleted'] as bool? ?? false,
  estimatedOneRM: (json['estimatedOneRM'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$SetModelToJson(_SetModel instance) => <String, dynamic>{
  'weight': instance.weight,
  'reps': instance.reps,
  'isCompleted': instance.isCompleted,
  'estimatedOneRM': instance.estimatedOneRM,
};
