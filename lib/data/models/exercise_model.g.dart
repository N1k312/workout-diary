// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    _ExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      muscleGroup: $enumDecode(_$MuscleGroupEnumMap, json['muscleGroup']),
      equipment: $enumDecode(_$EquipmentEnumMap, json['equipment']),
      isCustom: json['isCustom'] as bool? ?? false,
      createdBy: json['createdBy'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ExerciseModelToJson(_ExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'muscleGroup': _$MuscleGroupEnumMap[instance.muscleGroup]!,
      'equipment': _$EquipmentEnumMap[instance.equipment]!,
      'isCustom': instance.isCustom,
      'createdBy': instance.createdBy,
      'isDeleted': instance.isDeleted,
      'description': instance.description,
    };

const _$MuscleGroupEnumMap = {
  MuscleGroup.chest: 'chest',
  MuscleGroup.back: 'back',
  MuscleGroup.legs: 'legs',
  MuscleGroup.shoulders: 'shoulders',
  MuscleGroup.biceps: 'biceps',
  MuscleGroup.triceps: 'triceps',
  MuscleGroup.core: 'core',
};

const _$EquipmentEnumMap = {
  Equipment.barbell: 'barbell',
  Equipment.dumbbell: 'dumbbell',
  Equipment.machine: 'machine',
  Equipment.bodyweight: 'bodyweight',
  Equipment.cable: 'cable',
  Equipment.kettlebell: 'kettlebell',
  Equipment.other: 'other',
};
